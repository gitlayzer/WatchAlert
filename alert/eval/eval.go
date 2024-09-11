package eval

import (
	"context"
	"golang.org/x/sync/errgroup"
	"sync"
	"time"
	"watchAlert/internal/global"
	"watchAlert/internal/models"
	"watchAlert/pkg/ctx"
	"watchAlert/pkg/utils/cmd"
)

type AlertRule struct {
	l           sync.RWMutex
	ctx         *ctx.Context
	watchCtxMap map[string]context.CancelFunc
}

func NewAlertRuleEval(ctx *ctx.Context) AlertRule {
	return AlertRule{
		ctx:         ctx,
		watchCtxMap: make(map[string]context.CancelFunc),
	}
}

func (t *AlertRule) Submit(rule models.AlertRule) {
	t.l.Lock()
	defer t.l.Unlock()

	c, cancel := context.WithCancel(context.Background())
	t.watchCtxMap[rule.RuleId] = cancel
	go t.Eval(c, rule)
}

func (t *AlertRule) Stop(ruleId string) {
	t.l.Lock()
	defer t.l.Unlock()

	if cancel, exists := t.watchCtxMap[ruleId]; exists {
		cancel()
		delete(t.watchCtxMap, ruleId)
	}
}

func (t *AlertRule) Eval(ctx context.Context, rule models.AlertRule) {
	timer := time.NewTicker(time.Second * time.Duration(rule.EvalInterval))
	defer timer.Stop()
	for {
		select {
		case <-timer.C:
			for _, dsId := range rule.DatasourceIdList {
				instance, err := t.ctx.DB.Datasource().GetInstance(dsId)
				if err != nil {
					global.Logger.Sugar().Error(err.Error())
				}

				switch rule.DatasourceType {
				case "Prometheus", "VictoriaMetrics":
					metrics(t.ctx, dsId, instance.Type, rule)
				case "AliCloudSLS", "Loki", "ElasticSearch":
					logs(t.ctx, dsId, instance.Type, rule)
				case "Jaeger":
					traces(t.ctx, dsId, instance.Type, rule)
				case "CloudWatch":
					cloudWatch(t.ctx, dsId, rule)
				case "KubernetesEvent":
					kubernetesEvent(t.ctx, dsId, rule)
				}
			}
			global.Logger.Sugar().Infof("规则评估 -> %v", cmd.JsonMarshal(rule))
		case <-ctx.Done():
			global.Logger.Sugar().Infof("停止 RuleId: %v, RuleName: %s 的 Watch 协程", rule.RuleId, rule.RuleName)
			return
		}
		timer.Reset(time.Second * time.Duration(rule.EvalInterval))
	}
}

func (t *AlertRule) RePushTask(ctx *ctx.Context) {
	var ruleList []models.AlertRule
	if err := ctx.DB.DB().Where("enabled = ?", "1").Find(&ruleList).Error; err != nil {
		global.Logger.Sugar().Error(err.Error())
		return
	}

	g := new(errgroup.Group)
	for _, rule := range ruleList {
		rule := rule
		g.Go(func() error {
			t.Submit(rule)
			return nil
		})
	}

	if err := g.Wait(); err != nil {
		global.Logger.Sugar().Error(err.Error())
	}
}
