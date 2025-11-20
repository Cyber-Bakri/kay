# External main.tf that references the mrad-webcore-lmdbsched module
# This would be used in your infrastructure repository

module "lmdbsched" {
  source  = "app.terraform.io/pgetech/mrad-webcore-lmdbsched/aws"
  version = "0.0.13"
  count   = var.create_lmdbsched ? 1 : 0

  providers = {
    aws       = aws
    github    = github
    sumologic = sumologic
  }

  prefix     = var.prefix
  suffix     = var.suffix
  git_branch = var.git_branch
  tags       = local.tags
}

