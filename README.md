# DevOps Lab – GitHub Actions, Terraform & Kubernetes

This repository documents my hands-on learning journey into DevOps and CI/CD.

## What this repo demonstrates

- GitHub Actions workflows using:
  - Secrets-based authentication
  - OIDC-based authentication
  - Self-hosted runners on Kubernetes
- Terraform provisioning and destruction of Azure resources
- Secure cloud authentication using GitHub OIDC
- Kubernetes-based runner management using Actions Runner Controller (ARC)

## Workflow progression

1. **GitHub-hosted runner with secrets**
   - Baseline CI/CD approach
   - Demonstrates traditional authentication

2. **GitHub-hosted runner with OIDC**
   - Modern, secure authentication
   - No long-lived secrets

3. **Self-hosted runner on Kubernetes**
   - Runners managed inside Kubernetes (Minikube)
   - ARC handles runner lifecycle
   - Mirrors real-world DevOps architecture

## Key learning outcomes

- Understanding of GitHub Actions runner types
- Practical use of Terraform remote state
- Secure authentication with GitHub OIDC
- Kubernetes-based CI/CD execution

> Note: This repository is intentionally structured to preserve learning stages rather than a single production workflow.
