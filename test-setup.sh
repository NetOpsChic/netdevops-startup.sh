#!/bin/bash

set -e

# List of tools to check
TOOLS=(
    "docker"
    "ansible"
    "terraform"
    "go"
    "jenkins"
    "kubectl"
    "minikube"
    "k9s"
    "gns3server"
    "containerlab"
    "prometheus"
    "grafana-server"
    "aws"
    "gcloud"
    "az"
    "python3"
    "pip3"
)

# Function to check if a command exists
check_tool() {
    if command -v "$1" >/dev/null 2>&1; then
        echo -e "✅ $1 is installed."
    else
        echo -e "❌ $1 is NOT installed!"
    fi
}

# Run checks for each tool
echo "\n🔍 Checking installed tools..."
for tool in "${TOOLS[@]}"; do
    check_tool "$tool"
done

echo "\n✔️ Installation check complete!"
