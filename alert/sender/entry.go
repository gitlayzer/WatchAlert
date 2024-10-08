package sender

import (
	"bytes"
	"encoding/json"
	"errors"
	"io"
	"watchAlert/alert/mute"
	"watchAlert/internal/global"
	"watchAlert/internal/models"
	"watchAlert/pkg/client"
	"watchAlert/pkg/ctx"
	"watchAlert/pkg/utils/http"
	"watchAlert/pkg/utils/templates"
)

type DingResponseMsg struct {
	Code int    `json:"errcode"`
	Msg  string `json:"errmsg"`
}

type FeishuResponseMsg struct {
	Code int    `json:"code"`
	Msg  string `json:"msg"`
	Data string `json:"data"`
}

func Sender(ctx *ctx.Context, alert models.AlertCurEvent, notice models.AlertNotice) error {
	ok := mute.IsMuted(ctx, &alert)
	if ok {
		return nil
	}

	n := templates.NewTemplate(ctx, alert, notice)
	NoticeType := notice.NoticeType
	switch NoticeType {
	case "Email":
		setting, err := ctx.DB.Setting().Get()
		if err != nil {
			return errors.New("获取系统配置失败: " + err.Error())
		}
		eCli := client.NewEmailClient(setting.EmailConfig.ServerAddress, setting.EmailConfig.Email, setting.EmailConfig.Token, setting.EmailConfig.Port)
		if alert.IsRecovered {
			notice.Email.Subject = notice.Email.Subject + "「已恢复」"
		} else {
			notice.Email.Subject = notice.Email.Subject + "「报警中」"
		}
		err = eCli.Send(notice.Email.To, notice.Email.CC, notice.Email.Subject, []byte(n.CardContentMsg))
		if err != nil {
			global.Logger.Sugar().Error("Email 类型报警发送失败: " + err.Error() + ", Content: " + n.CardContentMsg)
			return err
		}
	case "FeiShu", "DingDing":
		var msg string
		cardContentByte := bytes.NewReader([]byte(n.CardContentMsg))
		res, err := http.Post(nil, notice.Hook, cardContentByte)
		if err != nil {
			msg = err.Error()
		}

		// 读取响应体内容
		body, err := io.ReadAll(res.Body)
		if err != nil {
			global.Logger.Sugar().Errorf("Error reading response body: %v", err)
			return err
		}

		if NoticeType == "FeiShu" {
			var response FeishuResponseMsg
			err = json.Unmarshal(body, &response)
			if err != nil {
				global.Logger.Sugar().Errorf("Error unmarshalling %v response: %v", NoticeType, err)
				return err
			}
			if response.Code != 0 {
				global.Logger.Sugar().Error(response.Msg)
				return errors.New(response.Msg)
			}
		}

		if NoticeType == "DingDing" {
			var response DingResponseMsg
			err = json.Unmarshal(body, &response)
			if err != nil {
				global.Logger.Sugar().Errorf("Error unmarshalling %v response: %v", NoticeType, err)
				return err
			}
			if response.Code != 0 {
				global.Logger.Sugar().Error(response.Msg)
				return errors.New(response.Msg)
			}
		}

		if res.StatusCode != 200 {
			msg = string(body)
		}

		if msg != "" {
			global.Logger.Sugar().Errorf("Hook 类型报警发送失败 code: %d data: %s", res.StatusCode, n.CardContentMsg)
			return errors.New(msg)
		}
	default:
		return errors.New("无效的通知类型: " + notice.NoticeType)
	}

	global.Logger.Sugar().Info("报警发送成功: ", n.CardContentMsg)
	return nil
}