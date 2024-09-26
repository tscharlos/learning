resource "exoscale_security_group" "sks" {
  name = "${var.stage}-sks"
}

resource "exoscale_security_group_rule" "calico_rule" {
  security_group_id      = exoscale_security_group.sks.id
  description            = "Calico traffic"
  type                   = "INGRESS"
  protocol               = "UDP"
  start_port             = "4789"
  end_port               = "4789"
  user_security_group_id = exoscale_security_group.sks.id
}

resource "exoscale_security_group_rule" "kubelet_rule" {
  security_group_id      = exoscale_security_group.sks.id
  description            = "Nodes logs/exec"
  type                   = "INGRESS"
  protocol               = "TCP"
  start_port             = 10250
  end_port               = 10250
  user_security_group_id = exoscale_security_group.sks.id
}

resource "exoscale_security_group_rule" "nodeport_tcp_rule" {
  security_group_id = exoscale_security_group.sks.id
  description       = "NodePort TCP services"
  type              = "INGRESS"
  protocol          = "TCP"
  start_port        = 30000
  end_port          = 32767
  cidr              = "0.0.0.0/0"
}

resource "exoscale_security_group_rule" "nodeport_udp_rule" {
  security_group_id = exoscale_security_group.sks.id
  description       = "Nodeport UDP services"
  type              = "INGRESS"
  protocol          = "UDP"
  start_port        = 30000
  end_port          = 32767
  cidr              = "0.0.0.0/0"
}

resource "exoscale_sks_cluster" "cluster" {
  zone          = var.zone
  name          = "${var.stage}-sks"
  service_level = "starter"
  version       = "1.30.4"
  depends_on = [
    exoscale_security_group.sks
  ]
  auto_upgrade = false
}

resource "exoscale_sks_nodepool" "nodepool" {
  zone       = var.zone
  cluster_id = exoscale_sks_cluster.cluster.id
  name       = "${var.stage}-sks-nodepool"

  instance_type   = "standard.medium"
  instance_prefix = "default-medium"
  size            = 1
  disk_size       = 50
  security_group_ids = [
    exoscale_security_group.sks.id
  ]
}
