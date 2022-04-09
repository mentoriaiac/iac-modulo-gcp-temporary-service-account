terraform {
  required_version = ">= 1.0.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~>4.16.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~>3"
    }
    local = {
      source  = "hashicorp/local"
      version = "~>2"
    }
    time = {
      source  = "hashicorp/time"
      version = "~>0"
    }
  }
}
