locals {
  vpa_cert_manager          = templatefile("${path.module}/manifests/verticalpodautoscalers/vpa-cert-manager.yaml", {})
  vpa_cert_manager_webhook  = templatefile("${path.module}/manifests/verticalpodautoscalers/vpa-cert-manager-webhook.yaml", {})
  vpa_cert_manager_cainjector = templatefile("${path.module}/manifests/verticalpodautoscalers/vpa-cert-manager-cainjector.yaml", {})
}

resource "kubectl_manifest" "vpa-cert-manager" {
  yaml_body = local.vpa_cert_manager

  depends_on = [
    helm_release.cert-manager
  ]
}

resource "kubectl_manifest" "vpa-cert-manager-cainjector" {
  yaml_body = local.vpa_cert_manager_cainjector

  depends_on = [
    helm_release.cert-manager
  ]
}

resource "kubectl_manifest" "vpa-cert-manager-webhook" {
  yaml_body = local.vpa_cert_manager_webhook

  depends_on = [
    helm_release.cert-manager
  ]
}
