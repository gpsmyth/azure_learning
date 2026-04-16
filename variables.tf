variable "storage_account_name" {
  description = "storage account name"
  type        = string
  default     = "mystorageacct12345"
}

variable "principal_id" {
  description = "Principal ID of the user or service principal to assign the role to."
  type        = string
  default     = "00000000-0000-0000-0000-000000000000" # Replace with actual Principal ID
}