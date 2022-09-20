Here we create the required instances of NGINX ingress controller.

The controllers are configured in daemonset mode with hostPort service type, therefore each application node of the cluster will also serve traffic for the apps it hosts.

This way we achieve proper load balancing, traffic separation between environments, and with no external load balancer involved, we convert all application nodes into web servers at the same time. Nodes will expose port 443 to the outside world via public IPs.
