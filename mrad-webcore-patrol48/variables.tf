# Input variables for mrad-webcore-patrol48 module

variable "prefix" {
  description = "Prefix for resource names"
  type        = string
}

variable "suffix" {
  description = "Environment suffix (Dev, QA, Prod)"
  type        = string
}

variable "git_branch" {
  description = "Git branch name for deployment tracking"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

