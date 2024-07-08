resource "kubectl_manifest" "ingress-grafana" {
  yaml_body = templatefile("${path.module}/yml/ingress-grafana.yaml.tpl", {
    domain         = var.domain,
    cluster_issuer = var.cluster_issuer
  })

  depends_on = [
    helm_release.prometheus
  ]
}
