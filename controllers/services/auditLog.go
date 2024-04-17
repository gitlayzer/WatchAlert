package services

import (
	"strconv"
	"time"
	"watchAlert/models"
	"watchAlert/public/globals"
)

type AuditLogService struct{}

type InterAuditLogService interface {
	ListAuditLog(req interface{}) (interface{}, interface{})
	SearchAuditLog(req interface{}) (interface{}, interface{})
}

func NewInterAuditLogService() InterAuditLogService {
	return &AuditLogService{}
}

func (as AuditLogService) ListAuditLog(req interface{}) (interface{}, interface{}) {
	r := req.(*models.AuditLogQuery)
	var db = globals.DBCli.Model(&models.AuditLog{})
	var data []models.AuditLog
	var count int64

	pageIndexInt, _ := strconv.Atoi(r.PageIndex)
	pageSizeInt, _ := strconv.Atoi(r.PageSize)

	db.Where("tenant_id = ?", r.TenantId)

	db.Count(&count)

	db.Limit(pageSizeInt).Offset((pageIndexInt - 1) * pageSizeInt).Order("created_at desc")
	err := db.Find(&data).Error
	if err != nil {
		return nil, err
	}

	d := models.AuditLogResponse{
		List:       data,
		PageIndex:  int64(pageIndexInt),
		PageSize:   int64(pageSizeInt),
		TotalCount: count,
	}

	return d, nil
}

func (as AuditLogService) SearchAuditLog(req interface{}) (interface{}, interface{}) {
	r := req.(*models.AuditLogQuery)
	var db = globals.DBCli.Model(&models.AuditLog{})
	var data []models.AuditLog

	db.Where("tenant_id = ?", r.TenantId)

	if r.Scope != "" {
		curTime := time.Now()
		i, _ := strconv.Atoi(r.Scope)
		eTime := curTime.Add(-time.Duration(i) * (time.Hour * 24))
		db.Where("created_at > ?", eTime.Unix())
	}

	if r.Query != "" {
		db.Where("username LIKE ? OR ip_address LIKE ? OR audit_type LIKE ?", "%"+r.Query+"%", "%"+r.Query+"%", "%"+r.Query+"%")
	}

	err := db.Find(&data).Error
	if err != nil {
		return nil, err
	}
	return data, nil
}
