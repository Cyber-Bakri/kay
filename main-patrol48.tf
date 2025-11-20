# External main.tf that references the mrad-webcore-patrol48 module
# This would be used in your infrastructure repository

module "patrol48" {
  source  = "app.terraform.io/pgetech/mrad-webcore-patrol48/aws"
  version = "0.0.1"
  count   = var.create_patrol48 ? 1 : 0

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

