This is an automatically created location for flux-managed kustomization, it is not a part of the rest of definitions.

Flux CLI should be used to generate these base manifests:

    flux bootstrap github --owner=artazar --repository=flux2-general --branch=main --path=clusters/demo-000 --token-auth --toleration-keys='node-role.kubernetes.io/master'

It is safe to re-run the command with a live cluster.

Note: `--token-auth` is needed for Flux to make initial commits into repository to correct `flux-system` manifests. The token should provide write access to the repo.

When a cluster is bootstrapped from scratch, pod-monitor.yaml should be excluded (commented out in kustomization.yaml) and then enabled again after observability unit is fully up (chicken-egg problem).
