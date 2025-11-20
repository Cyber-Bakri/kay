locals {
  account_num  = data.aws_caller_identity.current.account_id
  envname      = local.account_id_to_envname_table[local.account_num]
  project_name = "PATROL-48hr-Lambda"
  subnet_id    = local.subnet_qualifier[local.envname]
  short_name   = "patrol48"
  s3_bucket    = "webcore-patrol-${lower(var.suffix)}-lambdas"
  s3_key       = "PATROL-48hr-Lambda.zip"
  sumo_layer_arn = "arn:aws:lambda:us-west-2:663229565520:layer:sumologic-otel-lambda-nodejs-x86_64-v1-17-2:1"


  account_id_to_envname_table = {
    "990878119577" = "Dev",
    "471817339124" = "QA",
    "712640766496" = "Prod"
  }

  subnet_qualifier = {
    Dev  = "Dev-2",
    QA   = "QA",
    Prod = "Prod"
  }

  sumologic_endpoint = local.sumologic_endpoints[local.envname]

  sumologic_endpoints = {
    "Dev"  = "https://endpoint3.collection.us2.sumologic.com/receiver/v1/trace/ZaVnC4dhaV2JT06PBNlbkCRG7Oa1XbeVQ0QGAhJtvAnAPZfnYYOQvLey9rvQqT47SVBWAZdx7ZFjjlGKWqITM6"
    "QA"   = "https://endpoint3.collection.us2.sumologic.com/receiver/v1/trace/ZaVnC4dhaV2JT06PBNlbkCRG7Oa1XbeVQ0QGAhJtvAnAPZfnYYOQvLey9rvQqT47SVBWAZdx7ZFjjlGKWqITM6"
    "Prod" = "https://endpoint3.collection.us2.sumologic.com/receiver/v1/trace/ZaVnC4dhaV2VAhF7q7H7TSCmlmurlwWm3mEkTEtEx_yoctcvkibT3DKaAERVs7IcsHlPyGgZWT_bYcxDdd0Z"
  }

  # 48-hour schedule - runs every 2 days
  run_every_48hrs = {
    name                = "patrol48_run_every_48hrs"
    description         = "Schedule the PATROL Lambda to run every 48 hours"
    schedule_expression = "rate(48 hours)"
  }
}

