resource "kubectl_manifest" "karpenter" {
  yaml_body = templatefile("${path.module}/yml/vpa-karpenter.yaml", {})

  depends_on = [
    helm_release.karpenter
  ]
}

