resource "exoscale_domain" "decatech_domain" {
  name = "decatech.at"
}

# If we were to deploy traefik with terraform, we could get the IP here
# resource "exoscale_domain_record" "decatech" {
#   domain      = exoscale_domain.decatech_domain.id
#   name        = "decatech"
#   record_type = "A"
#   content     = "85.217.185.69"
# }
