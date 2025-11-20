# Shared variables for external configuration

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "suffix" {
  description = "Environment suffix (Dev, QA, Prod)"
  type        = string
}

variable "git_branch" {
  description = "Git branch name"
  type        = string
}

variable "create_lmdbsched" {
  description = "Whether to create lmdbsched resources"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
