data "sops_file" "secrets" {
  source_file = "secrets.yml"
  input_type  = "yaml"
}

locals {
  secrets = {
    kowabunga_admin_api_key = data.sops_file.secrets.data.kowabunga_admin_api_key
  }
}
