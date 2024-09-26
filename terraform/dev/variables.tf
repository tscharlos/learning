variable "key" {
  description = "Key of TerraformAPIKey IAM key"
  sensitive   = true
}

variable "secret" {
  description = "Secret of TerraformAPIKey IAM key"
  sensitive   = true
}

variable "stage" {
  description = "Stage's shortname - e.g. dev, test, prod"
  type        = string
}

variable "zone" {
  description = "The zone of the cluster"
  type        = string
  default     = "at-vie-1"
}