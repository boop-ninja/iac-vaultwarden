variable "kube_host" {
}

variable "kube_crt" {
  default = ""
}
variable "kube_key" {
  default = ""
}
variable "chart_name" {
  type        = string
  default     = "vaultwarden"
  description = "description"
}
variable "chart_version" {
  type        = string
  description = "description"
}
variable "chart_repo" {
  type        = string
  default     = "https://k8s-at-home.com/charts/"
  description = "description"
}

variable "domain_name" {
  type        = string
  default     = ""
  description = "description"
}

variable "admin_token" {
  type        = string
  description = "description"
}


output "domain" {
  value = "https://${var.domain_name}"
}

