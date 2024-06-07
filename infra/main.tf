module "lambda-container" {
    source = "../module"
    image_tag = var.image_tag
    package_type = var.package_type
  
}