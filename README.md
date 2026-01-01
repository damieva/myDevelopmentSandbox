# myDevelopmentSandbox

This repository centralizes the configuration of my **local cloud-native development environment**.  
The goal is to provide a **ready-to-use Kubernetes cluster** with **GitOps tooling**, reproducible via Infrastructure as Code and easy to operate locally.

The setup is intentionally close to real-world Platform / SRE workflows, while remaining simple enough for local development.

---

## 🚀 Components

- **Kubernetes Cluster:**  
  Local Kubernetes using [Kind](https://kind.sigs.k8s.io/) (Kubernetes in Docker).

- **Infrastructure as Code:**  
  [Terraform](https://www.terraform.io/) orchestrated with [Terragrunt](https://terragrunt.gruntwork.io/) to manage multiple modules and dependencies.

- **GitOps / CD:**  
  [ArgoCD](https://argoproj.github.io/argo-cd/) installed via Helm and ready for automated deployments.

- **State Backend:**  
  Terraform state stored remotely in **HCP Terraform (Terraform Cloud)** with:
  - state locking
  - history
  - safety guarantees

- **Automation Interface:**  
  A simple `Makefile` to standardize local workflows.

---

## 📁 Repository Structure

```text
.
├── root.hcl        # Root Terragrunt configuration (orchestration only)
├── k8s-cluster/          # Kubernetes cluster provisioning (Kind)
│   └── terragrunt.hcl
├── k8s-tools/            # Tooling installed on the cluster (ArgoCD, etc.)
│   └── terragrunt.hcl
└── Makefile              # Human-friendly interface for Terragrunt
```
---

## 🌐 Access

### ArgoCD UI

Once the environment is up and running, ArgoCD is available locally at:

👉 **http://argocd.127.0.0.1.nip.io:8080/**

This setup uses the `nip.io` wildcard DNS, which resolves automatically to `127.0.0.1`.  
No local DNS configuration or `/etc/hosts` changes are required.

---
