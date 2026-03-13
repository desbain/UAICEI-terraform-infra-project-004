locals {
  project_tags = {
    contact      = "devops@uaicei.com"
    application  = "Jupiter"
    project      = "UAICEI"
    environment  = "${terraform.workspace}" # refers to your current workspace (dev, prod, etc)
    creationTime = timestamp()
  }
}