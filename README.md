# terraform-infra_k8s

Terraform exaple project for creating Kubernetes infra in vApp on VMware vCloud Director.

Project works with T1 cloud infrastructure!
## Variables for work module

`vcd_user` - username for auth in vCloud Director

`vcd_password` - password for auth in vCloud Director

`vcd_network` - network name for VMs

`vdc_name` - vCloud Director company name/id

`vcd_org_name` - vCloud Director organization name

`vcd_url` - vCloud Director URL for auth, example https://vcd.company.com/api/

### Example for use

Example for local test use:
```
export vcd_user='admin'
export vcd_password='123456'
export vcd_network='vcd-net01-2324'
export vdc_name='company-2323-21'
export vcd_org_name='company-13131311111-2'
export vcd_url='https://vcd.company.com/api/'
terraform init
terraform plan
terraform apply
```

## About the Author

This project was created by [Sergey Kurbatov](https://skurbatov.github.io/).