package models

import (
	"encoding/json"
	"log"
	"time"
	"watchAlert/public/globals"
)

const FiringAlertCachePrefix = "firing-alert-"
const PendingAlertCachePrefix = "pending-alert-"

type AlertCurEvent struct {
	TenantId               string                 `json:"tenantId"`
	RuleId                 string                 `json:"rule_id"`
	RuleName               string                 `json:"rule_name"`
	DatasourceType         string                 `json:"datasource_type"`
	DatasourceId           string                 `json:"datasource_id" gorm:"datasource_id"`
	Fingerprint            string                 `json:"fingerprint"`
	Severity               string                 `json:"severity"`
	Metric                 map[string]interface{} `json:"metric" gorm:"metric;serializer:json"`
	Labels                 map[string]string      `json:"labels" gorm:"labels;serializer:json"`
	EvalInterval           int64                  `json:"eval_interval"`
	ForDuration            int64                  `json:"for_duration"`
	NoticeId               string                 `json:"notice_id" gorm:"-"` // 默认通知对象ID
	NoticeGroupList        NoticeGroup            `json:"noticeGroup" gorm:"-"`
	NoticeGroup            string                 `json:"-" gorm:"noticeGroup"`
	Annotations            string                 `json:"annotations" gorm:"-"`
	IsRecovered            bool                   `json:"is_recovered" gorm:"-"`
	FirstTriggerTime       int64                  `json:"first_trigger_time"` // 第一次触发时间
	FirstTriggerTimeFormat string                 `json:"first_trigger_time_format" gorm:"-"`
	RepeatNoticeInterval   int64                  `json:"repeat_notice_interval"`  // 重复通知间隔时间
	LastEvalTime           int64                  `json:"last_eval_time" gorm:"-"` // 上一次评估时间
	LastSendTime           int64                  `json:"last_send_time" gorm:"-"` // 上一次发送时间
	RecoverTime            int64                  `json:"recover_time" gorm:"-"`   // 恢复时间
	RecoverTimeFormat      string                 `json:"recover_time_format" gorm:"-"`
	DutyUser               string                 `json:"duty_user" gorm:"-"`
}

func (ace *AlertCurEvent) GetFiringAlertCacheKey() string {
	return ace.TenantId + ":" + FiringAlertCachePrefix + ace.AlertCacheTailKey()
}

func (ace *AlertCurEvent) GetPendingAlertCacheKey() string {
	return ace.TenantId + ":" + PendingAlertCachePrefix + ace.AlertCacheTailKey()
}

func (ace *AlertCurEvent) AlertCacheTailKey() string {
	return ace.RuleId + "-" + ace.DatasourceId + "-" + ace.Fingerprint
}

func (ace *AlertCurEvent) GetCache(key string) AlertCurEvent {

	var alert AlertCurEvent

	d, err := globals.RedisCli.Get(key).Result()
	_ = json.Unmarshal([]byte(d), &alert)
	if err != nil {
		return AlertCurEvent{}
	}

	return alert

}

func (ace *AlertCurEvent) SetFiringCache(expiration time.Duration) {
	alertJson, _ := json.Marshal(ace)
	// 设置缓存前检查当前 Rule 是否存在，避免出现删除/禁用规则后依旧能添加缓存。
	exist := ace.GetRuleIsExist(ace.RuleId)
	if exist {
		globals.RedisCli.Set(ace.GetFiringAlertCacheKey(), string(alertJson), expiration)
	}
}

func (ace *AlertCurEvent) SetPendingCache(expiration time.Duration) {
	alertJson, _ := json.Marshal(ace)
	exist := ace.GetRuleIsExist(ace.RuleId)
	if exist {
		globals.RedisCli.Set(ace.GetPendingAlertCacheKey(), string(alertJson), expiration)
	}
}

// GetRuleIsExist 检查 Rule 是否存在
func (ace *AlertCurEvent) GetRuleIsExist(ruleId string) bool {
	var ruleNum int64
	globals.DBCli.Model(&AlertRule{}).Where("rule_id = ? and enabled = ?", ruleId, "true").Count(&ruleNum)
	if ruleNum > 0 {
		return true
	}
	return false
}

func (ace *AlertCurEvent) DelCache(key string) {

	//globals.RedisCli.Del(key)

	// 使用Scan命令获取所有匹配指定模式的键
	iter := globals.RedisCli.Scan(0, key, 0).Iterator()
	keysToDelete := make([]string, 0)

	// 遍历匹配的键
	for iter.Next() {
		key := iter.Val()
		keysToDelete = append(keysToDelete, key)
	}

	if err := iter.Err(); err != nil {
		log.Fatal(err)
	}

	// 批量删除键
	if len(keysToDelete) > 0 {
		err := globals.RedisCli.Del(keysToDelete...).Err()
		if err != nil {
			log.Fatal(err)
		}
		globals.Logger.Sugar().Infof("移除告警消息 -> %s\n", keysToDelete)
	}

}

func (ace *AlertCurEvent) GetFirstTime(key string) int64 {

	ft := ace.GetCache(key).FirstTriggerTime
	if ft == 0 {
		return time.Now().Unix()
	}
	return ft

}

func (ace *AlertCurEvent) GetLastEvalTime(key string) int64 {

	curTime := time.Now().Unix()
	let := ace.GetCache(key).LastEvalTime
	if let == 0 || let < curTime {
		return curTime
	}

	return let

}

func (ace *AlertCurEvent) GetLastSendTime(key string) int64 {

	return ace.GetCache(key).LastSendTime

}
