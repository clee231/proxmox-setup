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
      "namespace" = "argocd"
    }
    "stringData" = {
      "name" = "bitnami"
      "type" = "helm"
      "url" = "https://charts.bitnami.com/bitnami"
    }
  }
}
