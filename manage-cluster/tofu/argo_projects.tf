resource "kubernetes_manifest" "appproject_argocd_system" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind" = "AppProject"
    "metadata" = {
      "name" = "system"
      "namespace" = kubernetes_namespace.argocd.metadata[0].name
    }
    "spec" = {
      "clusterResourceWhitelist" = [
        {
          "group" = "*"
          "kind" = "*"
        }
      ]
      "destinations" = [{
        "namespace" = "*"
        "server" = "*"
      }]
      "sourceRepos" = ["*"]
    }
  }
}
