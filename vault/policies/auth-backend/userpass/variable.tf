variable login_username {
  description = "username to login to vault"
  type        = string
  default     = ""
}
variable login_password {
  description = "password to login to vault"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Enter environment to deploy"
  type        = string
  default     = ""
}