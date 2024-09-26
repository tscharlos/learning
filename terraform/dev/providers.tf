terraform {
  required_providers {
    exoscale = {
      source = "exoscale/exoscale"
    }
  }
}

provider "exoscale" {
  key    = var.key
  secret = var.secret
}
