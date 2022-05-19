output "ba01-k8s-master-info" {
  value = module.ba01-k8s-master[*].vm-info
}

output "ba01-k8s-ingress-info" {
  value = module.ba01-k8s-ingress[*].vm-info
}

output "ba01-k8s-worker-info" {
  value = module.ba01-k8s-worker[*].vm-info
}

output "ba01-k8s-nfs-info" {
  value = module.ba01-k8s-nfs[*].vm-info
}
