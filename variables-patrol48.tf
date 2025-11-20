# Variables for external configuration using mrad-webcore-patrol48 module

variable "create_patrol48" {
  description = "Whether to create patrol48 resources"
  type        = bool
  default     = false
}

# Note: These variables should already exist in your root module:
# - var.prefix
# - var.suffix
# - var.git_branch
# - var.tags (or local.tags)

