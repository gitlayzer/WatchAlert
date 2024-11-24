package templates

import (
	"watchAlert/internal/models"
	"watchAlert/pkg/ctx"
)

type Template struct {
	CardContentMsg string
}

func NewTemplate(ctx *ctx.Context, alert models.AlertCurEvent, notice models.AlertNotice) Template {
	noticeTmpl := ctx.DB.NoticeTmpl().Get(models.NoticeTemplateExampleQuery{Id: notice.NoticeTmplId})
	switch notice.NoticeType {
	case "FeiShu":
		return Template{CardContentMsg: feishuTemplate(alert, noticeTmpl)}
	case "DingDing":
		return Template{CardContentMsg: dingdingTemplate(alert, noticeTmpl)}
	case "Email":
		return Template{CardContentMsg: emailTemplate(alert, noticeTmpl)}
	}

	return Template{}
}
