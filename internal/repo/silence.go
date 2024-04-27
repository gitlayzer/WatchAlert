package repo

import (
	"gorm.io/gorm"
	"watchAlert/internal/models"
)

type (
	SilenceRepo struct {
		entryRepo
	}

	InterSilenceRepo interface {
		List(r models.AlertSilenceQuery) ([]models.AlertSilences, error)
		Create(r models.AlertSilences) error
		Update(r models.AlertSilences) error
		Delete(r models.AlertSilenceQuery) error
	}
)

func newSilenceInterface(db *gorm.DB, g InterGormDBCli) InterSilenceRepo {
	return &SilenceRepo{
		entryRepo{
			g:  g,
			db: db,
		},
	}
}

func (sr SilenceRepo) List(r models.AlertSilenceQuery) ([]models.AlertSilences, error) {
	var silenceList []models.AlertSilences
	db := sr.db.Model(models.AlertSilences{})
	db.Where("tenant_id = ?", r.TenantId)
	err := db.Find(&silenceList).Error
	if err != nil {
		return silenceList, err
	}

	return silenceList, nil
}

func (sr SilenceRepo) Create(r models.AlertSilences) error {
	err := sr.g.Create(models.AlertSilences{}, r)
	if err != nil {
		return err
	}

	return nil
}

func (sr SilenceRepo) Update(r models.AlertSilences) error {
	u := Updates{
		Table: models.AlertSilences{},
		Where: map[string]interface{}{
			"tenant_id = ?": r.TenantId,
			"id = ?":        r.Id,
		},
		Updates: r,
	}

	err := sr.g.Updates(u)
	if err != nil {
		return err
	}

	return nil
}

func (sr SilenceRepo) Delete(r models.AlertSilenceQuery) error {
	var silence models.AlertSilences
	db := sr.db.Where("tenant_id = ? AND id = ?", r.TenantId, r.Id)
	err := db.Find(&silence).Error
	if err != nil {
		return err
	}

	del := Delete{
		Table: models.AlertSilences{},
		Where: map[string]interface{}{
			"tenant_id = ?": r.TenantId,
			"id = ?":        r.Id,
		},
	}
	err = sr.g.Delete(del)
	if err != nil {
		return err
	}

	return nil
}
