variable "bucket_name" {
  description = "The name of the bucket"
}

variable "bucket_description" {
  type        = string
  default     = "bucket description"
  description = "S3 Bucket for saving terraform state"
}