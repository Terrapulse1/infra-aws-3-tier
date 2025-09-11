# Data source to reference your existing Route 53 hosted zone
data "aws_route53_zone" "existing_r53_zone" {
  # IMPORTANT: Ensure 'domain_name' matches the variable name in your variables.tf
  name         = var.domain_name # Use the exact domain name of your manually created zone
  private_zone = false           # Set to true if it's a private hosted zone
}

resource "aws_route53_record" "bank_cname" {
  # Reference the zone_id from the data source
  zone_id = data.aws_route53_zone.existing_r53_zone.zone_id
  # IMPORTANT: Ensure 'domain_name' matches the variable name in your variables.tf
  name    = "bank.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [var.nginx_lb_ip]
}

resource "aws_route53_record" "bankapi_cname" {
  # Reference the zone_id from the data source
  zone_id = data.aws_route53_zone.existing_r53_zone.zone_id
  # IMPORTANT: Ensure 'domain_name' matches the variable name in your variables.tf
  name    = "bankapi.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [var.nginx_lb_ip]
}

resource "aws_route53_record" "argocd_cname" {
  # Reference the zone_id from the data source
  zone_id = data.aws_route53_zone.existing_r53_zone.zone_id
  # IMPORTANT: Ensure 'domain_name' matches the variable name in your variables.tf
  name    = "argocd.${var.domain_name}"
  type    = "CNAME"
  ttl     = 300
  records = [var.nginx_lb_ip]
}

# Example A record pointing to a specific IP address
resource "aws_route53_record" "test_a_record" {
  zone_id = data.aws_route53_zone.existing_r53_zone.zone_id
  name    = "test.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = ["1.2.3.4"]  # Replace with your actual IP address
}

# # modules/dns/main.tf (Updated for ALIAS Records)

# resource "aws_route53_record" "bank_app" { # Renamed resource for clarity (optional, but good practice)
#     zone_id = data.aws_route53_zone.r53_zone.zone_id
#     name    = "bank.${var.domain_name}"
#     type    = "A" # <--- Changed from "CNAME" to "A" (for ALIAS)

#     alias {
#       name                   = var.nginx_lb_dns_name       # <--- New variable for LB DNS Name
#       zone_id                = var.nginx_lb_hosted_zone_id # <--- New variable for LB Hosted Zone ID
#       evaluate_target_health = true                        # Recommended for health checks
#     }
#     # Removed 'ttl' and 'records' because they are not used with 'alias' blocks
# }

# resource "aws_route53_record" "bankapi_app" { # Renamed resource
#     zone_id = data.aws_route53_zone.r53_zone.zone_id
#     name    = "bankapi.${var.domain_name}"
#     type    = "A"

#     alias {
#       name                   = var.nginx_lb_dns_name
#       zone_id                = var.nginx_lb_hosted_zone_id
#       evaluate_target_health = true
#     }
# }

# resource "aws_route53_record" "argocd_app" { # Renamed resource
#     zone_id = data.aws_route53_zone.r53_zone.zone_id
#     name    = "argocd.${var.domain_name}"
#     type    = "A"

#     alias {
#       name                   = var.nginx_lb_dns_name
#       zone_id                = var.nginx_lb_hosted_zone_id
#       evaluate_target_health = true
#     }
# }




# resource "aws_route53_zone" "r53_zone" {
#     name = var.domain-name
#     comment = "Managed by Terraform"
#     force_destroy = true
    
#     tags = {
#         Name        = "${var.environment}-hosted-zone"
#         Environment = var.environment
#     }
# }

# resource "aws_route53_record" "name" {
#     zone_id = aws_route53_zone.r53_zone.zone_id
#     name    = "bank.${var.domain-name}" # Use a subdomain for CNAME
#     type    = "CNAME"
#     ttl     = 300
#     records = [var.nginx_lb_ip]
# }

# resource "aws_route53_record" "name1" {
#     zone_id = aws_route53_zone.r53_zone.zone_id
#     name    = "bankapi.${var.domain-name}" # Use a subdomain for CNAME
#     type    = "CNAME"
#     ttl     = 300
#     records = [var.nginx_lb_ip]
# }
# resource "aws_route53_record" "name2" {
#     zone_id = aws_route53_zone.r53_zone.zone_id
#     name    = "argocd.${var.domain-name}" # Use a subdomain for CNAME
#     type    = "CNAME"
#     ttl     = 300
#     records = [var.nginx_lb_ip]
# }