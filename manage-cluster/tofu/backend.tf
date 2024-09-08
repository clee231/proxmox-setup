terraform {
  backend "kubernetes" {
    secret_suffix    = "tofu"
    config_path      = "../manage-kubeconfig"
  }
}

