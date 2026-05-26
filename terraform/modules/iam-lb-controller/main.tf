data "http" "lb_controller_policy" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json"
}

resource "aws_iam_policy" "aws_lb_controller" {
  name   = "AWSLoadBalancerControllerIAMPolicy-${var.cluster_name}"
  policy = data.http.lb_controller_policy.response_body
}

locals {
  oidc_issuer = replace(var.oidc_issuer_url, "https://", "")
}

data "aws_iam_policy_document" "lb_controller_assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    principals {
      type        = "Federated"
      identifiers = [var.oidc_provider_arn]  # ← Passed from EKS module
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_issuer}:sub"
      values   = ["system:serviceaccount:kube-system:aws-load-balancer-controller"]
    }

    condition {
      test     = "StringEquals"
      variable = "${local.oidc_issuer}:aud"
      values   = ["sts.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lb_controller" {
  name               = "AWSLoadBalancerControllerRole-${var.cluster_name}"
  assume_role_policy = data.aws_iam_policy_document.lb_controller_assume.json
}

resource "aws_iam_role_policy_attachment" "lb_controller" {
  role       = aws_iam_role.lb_controller.name
  policy_arn = aws_iam_policy.aws_lb_controller.arn
}