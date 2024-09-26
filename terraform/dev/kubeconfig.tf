resource "exoscale_sks_kubeconfig" "sks_kubeconfig" {
  zone       = var.zone
  cluster_id = exoscale_sks_cluster.cluster.id

  user   = "kubernetes-admin"
  groups = ["system:masters"]
}

resource "local_sensitive_file" "sks_kubeconfig" {
  filename        = "kubeconfig-${var.stage}.yaml"
  content         = exoscale_sks_kubeconfig.sks_kubeconfig.kubeconfig
  file_permission = "0600"
}

# Outputs
output "my_sks_cluster_endpoint" {
  value = exoscale_sks_cluster.cluster.endpoint
}

output "my_sks_kubeconfig" {
  value = local_sensitive_file.sks_kubeconfig.filename
}