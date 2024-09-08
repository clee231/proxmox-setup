resource "kubernetes_manifest" "manage_cluster_app" {
  manifest = {
    "apiVersion" = "argoproj.io/v1alpha1"
    "kind" = "Application"
    "metadata" = {
      "name" = "manage-cluster"
      "namespace" = kubernetes_namespace.argocd.metadata[0].name
    }
    "spec" = {
      "destination" = {
        "server" = "https://kubernetes.default.svc"
      }
      "source" = {
        "path" = "manage-cluster/argo/common"
        "repoURL" = "git@github.com:clee231/proxmox-setup.git"
        "targetRevision" = "HEAD"
      }
      "sources" = []
      "project" = "default"
      "syncPolicy" = {
        "automated" = {
          "prune" = "true"
          "selfHeal" = "true"
        }
      }
    }
  }
}
