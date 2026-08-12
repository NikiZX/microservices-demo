# Helm chart for Online Boutique (helm-charts2)

Helm chart converted from `release/kubernetes-manifests.yaml`.

## Install

```sh
helm upgrade onlineboutique ./helm-charts2 \
    --install \
    --create-namespace \
    -n onlineboutique
```

## Customize

Override the image repository or tag:

```sh
helm upgrade onlineboutique ./helm-charts2 \
    --install \
    --set images.repository=us-central1-docker.pkg.dev/online-boutique-ci/microservices-demo \
    --set images.tag=v0.10.6
```

Disable the load generator or external LoadBalancer:

```sh
helm upgrade onlineboutique ./helm-charts2 \
    --install \
    --set loadGenerator.create=false \
    --set frontend.externalService=false
```

### AWS (EKS) load balancing

An ALB **cannot** be created from a `Service` — only from an `Ingress`. Use `frontend.loadBalancer` for an NLB, or `frontend.ingress` for an ALB. Requires the [AWS Load Balancer Controller](https://kubernetes-sigs.github.io/aws-load-balancer-controller/) installed on the cluster.

NLB example (via the `frontend-external` Service, IP targets):

```sh
helm upgrade onlineboutique ./helm-charts2 \
    --install \
    --set 'frontend.loadBalancer.annotations.service\.beta\.kubernetes\.io/aws-load-balancer-type=external' \
    --set 'frontend.loadBalancer.annotations.service\.beta\.kubernetes\.io/aws-load-balancer-nlb-target-type=ip' \
    --set 'frontend.loadBalancer.annotations.service\.beta\.kubernetes\.io/aws-load-balancer-scheme=internet-facing'
```

ALB example (via a new `Ingress`, IP targets). Also disable the plain `LoadBalancer` Service since you don't need both:

```sh
helm upgrade onlineboutique ./helm-charts2 \
    --install \
    --set frontend.externalService=false \
    --set frontend.ingress.create=true \
    --set frontend.ingress.ingressClassName=alb \
    --set 'frontend.ingress.annotations.alb\.ingress\.kubernetes\.io/scheme=internet-facing' \
    --set 'frontend.ingress.annotations.alb\.ingress\.kubernetes\.io/target-type=ip' \
    --set 'frontend.ingress.annotations.alb\.ingress\.kubernetes\.io/healthcheck-path=/_healthz'
```

Also override `images.repository` to your ECR repo if needed:

```sh
helm upgrade onlineboutique ./helm-charts2 \
    --install \
    --set images.repository=<your-account>.dkr.ecr.<region>.amazonaws.com/microservices-demo \
    --set images.tag=v0.10.6
```

See [values.yaml](./values.yaml) for all configurable options.
