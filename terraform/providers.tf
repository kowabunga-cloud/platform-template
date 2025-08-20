terraform {
  required_version = "~> 1.0"
    sops = {
      source  = "carlpett/sops"
      version = "1.2.1"
    }
    kowabunga = {
      source  = "kowabunga-cloud/kowabunga"
      version = ">=0.55.0"
    }
  }

  encryption {
    key_provider "pbkdf2" "passphrase" {
      passphrase = var.passphrase
    }

    method "aes_gcm" "sops" {
      keys = key_provider.pbkdf2.passphrase
    }

    state {
      method = method.aes_gcm.sops
    }

    plan {
      method = method.aes_gcm.sops
    }
  }
}

variable "passphrase" {
  # Value to be defined in your local passphrase.auto.tfvars file.
  # Content to be retrieved from decyphered secrets.yml file.
  sensitive = true
}

provider "kowabunga" {
  uri   = "https://kowabunga.acme.com"
  token = local.secrets.kowabunga_admin_api_key
}
