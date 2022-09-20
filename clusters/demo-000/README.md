This directory contains cluster definitions, managed by FluxCD.

The structure:

- `apps` - contains envs and overlays relative to higher level base app definitions
- `infra` - contains grouped infra layer resources with overlays over higher level base infra definitions
- `rbac` - cluster-specific rbac entries
- `kubernetes-api-ingress.yaml` - ingress resource for Kubernetes API
- `flux-system` - internal directory managed by Flux itself

The following units are added as separate Flux kustomization resources, subject to independent reconciliations:

- apps/demoapp-home
  - dev
  - stg
  - prod

- apps/demoapp-work
  - dev

- infra
  - sources
  - crds
  - operations
  - ingress
  - storage
  - observability
  - security