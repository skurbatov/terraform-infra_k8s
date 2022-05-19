provider "vcd" {
  user                 = var.vcd_user
  password             = var.vcd_password
  auth_type            = "integrated"
  org                  = var.vcd_org_name
  vdc                  = var.vdc_name
  url                  = var.vcd_url
  max_retry_timeout    = 5
  allow_unverified_ssl = true
}
