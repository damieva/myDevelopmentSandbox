output "endpoint" {
  value     = kind_cluster.this.endpoint
  sensitive = true
}

output "cluster_ca" {
  value     = kind_cluster.this.cluster_ca_certificate
  sensitive = true
}

output "client_cert" {
  value     = kind_cluster.this.client_certificate
  sensitive = true
}

output "client_key" {
  value     = kind_cluster.this.client_key
  sensitive = true
}
