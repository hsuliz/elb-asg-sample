package dto

type PostHighLoadRequest struct {
	Power       int `json:"power" binding:"required,min=1"`
	NumberOfCPU int `json:"number-of-cpu" binding:"min=0" `
}
