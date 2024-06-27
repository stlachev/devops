module "ecr" {
  source = "terraform-aws-modules/ecr/aws"

  for_each = var.ecr_repositories

  repository_name = each.key
  repository_image_scan_on_push = each.value.scanning_enabled
  repository_image_tag_mutability = each.value.tag_mutability

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority = 1,
        description  = "Expire untagged images",
        selection = {
          tagStatus     = "untagged",
          countType     = "imageCountMoreThan",
          countNumber   = each.value.expiration_after_days
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}