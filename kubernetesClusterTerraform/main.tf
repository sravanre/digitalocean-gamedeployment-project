terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "my_cluster" {
  name    = "my-k8s-cluster"
  region  = "nyc3"  # Change to your preferred region
  version = "1.27.1-do.0"  # Adjust based on available versions

  node_pool {
    name       = "worker-pool"
    size       = "s-2vcpu-4gb"
    node_count = 3
  }
}

output "kubeconfig" {
  value     = digitalocean_kubernetes_cluster.my_cluster.kube_config[0].raw_config
  sensitive = true
}
