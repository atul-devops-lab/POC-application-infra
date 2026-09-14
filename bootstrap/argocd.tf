resource "helm_release" "argocd" {
  name             = "argocd"
  namespace        = "argocd"
  create_namespace = true

  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "10.4.1"

  wait          = true
  atomic        = true
  cleanup_on_fail = true
  timeout       = 900
}
