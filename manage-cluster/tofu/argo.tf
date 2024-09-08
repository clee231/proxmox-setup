resource "kubernetes_namespace" "argocd" {
  metadata {
    name = "argocd"
  }
}

resource "helm_release" "argocd" {
  depends_on = [kubernetes_namespace.argocd]
  name       = "argocd"
  chart      = "argo-cd"
  repository = "https://argoproj.github.io/argo-helm"
  namespace  = "argocd"

  set {
    name  = "server.service.annotations.external-dns\\.alpha\\.kubernetes\\.io/hostname"
    value = "cd.anibase02.chase.ninja"
  }

  set {
    name  = "redis-ha.enabled"
    value = "true"
  }

  set {
    name  = "controller.replicas"
    value = "1"
  }

  set {
    name  = "server.autoscaling.enabled"
    value = "true"
  }

  set {
    name  = "server.autoscaling.minReplicas"
    value = "2"
  }

  set {
    name  = "repoServer.autoscaling.enabled"
    value = "true"
  }

  set {
    name  = "repoServer.autoscaling.minReplicas"
    value = "2"
  }

  set {
    name  = "applicationSet.replicaCount"
    value = "2"
  }

  set {
    name  = "server.service.type"
    value = "NodePort"
  }

  set {
    name  = "configs.params.server\\.insecure"
    value = "true"
  }

}
