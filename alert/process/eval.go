package process

import (
	"context"
	"github.com/zeromicro/go-zero/core/logc"
	"watchAlert/internal/models"
	"watchAlert/pkg/ctx"
)

// EvalCondition 评估告警条件
func EvalCondition(ec models.EvalCondition) bool {
	switch ec.Operator {
	case ">":
		if ec.QueryValue > ec.ExpectedValue {
			return true
		}
	case ">=":
		if ec.QueryValue >= ec.ExpectedValue {
			return true
		}
	case "<":
		if ec.QueryValue < ec.ExpectedValue {
			return true
		}
	case "<=":
		if ec.QueryValue <= ec.ExpectedValue {
			return true
		}
	case "==":
		if ec.QueryValue == ec.ExpectedValue {
			return true
		}
	case "!=":
		if ec.QueryValue != ec.ExpectedValue {
			return true
		}
	default:
		logc.Error(context.Background(), "无效的评估条件", ec.Type, ec.Operator, ec.ExpectedValue)
	}
	return false
}

func SaveAlertEvent(ctx *ctx.Context, event models.AlertCurEvent) {
	ok := ctx.DB.Rule().GetRuleIsExist(event.RuleId)
	if ok {
		SaveEventCache(ctx, event)
	}
}
