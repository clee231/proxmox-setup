resource "kubernetes_manifest" "secret_argocd_bitnami_repo" {
  computed_fields = ["stringData"]
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Secret"
    "metadata" = {
      "labels" = {
        "argocd.argoproj.io/secret-type" = "repository"
      }
      "name" = "bitnami-repo"
      "namespace" = kubernetes_namespace.argocd.metadata[0].name
    }
    "stringData" = {
      "name" = "bitnami"
      "type" = "helm"
      "url" = "https://charts.bitnami.com/bitnami"
    }
  }
}

resource "kubernetes_manifest" "secret_argocd_github_repo" {
  computed_fields = ["stringData"]
  manifest = {
    "apiVersion" = "v1"
    "kind" = "Secret"
    "metadata" = {
      "labels" = {
        "argocd.argoproj.io/secret-type" = "repository"
      }
      "name" = "github"
      "namespace" = kubernetes_namespace.argocd.metadata[0].name
    }
    "stringData" = {
      "type" = "git"
      "name" = "github"
      "url" = "git@github.com:clee231/proxmox-setup.git"
      "sshPrivateKey": file("../argo-ssh-key")
    }
  }
}
