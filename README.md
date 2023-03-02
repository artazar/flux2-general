# flux2-general
A repo with FluxCD reference structure.

An existing Kubernetes cluster is required before using this repository. 

For a demo case it is enough to start a minikube node:

    minikube start

For a quick start consult with bootstrap procedure:

[FluxCD bootstrap](https://github.com/artazar/flux2-general/tree/main/clusters/demo-000/flux-system)

The structure of cluster and grouped resources:

[demo-app cluster structure](https://github.com/artazar/flux2-general/tree/main/clusters/demo-000)

## Auto-update notes

The repository contains three techniques to allow automatic component updates:

1. For Flux specifically - [flux-update workflow](https://github.com/artazar/flux2-general/blob/main/.github/workflows/flux-update.yaml)

2. For HelmRelease objects, version range can be indicated - [example kyverno manifest](https://github.com/artazar/flux2-general/blob/main/infra/security/kyverno.yaml#L14)

3. Global auto-update flow via [renovate addon](https://github.com/renovatebot/renovate) - [workflow](https://github.com/artazar/flux2-general/blob/main/.github/workflows/renovate.yaml)
