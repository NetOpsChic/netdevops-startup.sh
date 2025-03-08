#!/bin/bash

set -e  # Exit on error

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Update system
sudo apt update && sudo apt upgrade -y

echo "\n🔹 Installing Essential Utilities..."
sudo apt install -y curl wget git unzip apt-transport-https ca-certificates gnupg lsb-release build-essential software-properties-common python3-pip

# Function to install a package if not already installed
install_package() {
    if ! command_exists "$1"; then
        echo "Installing $2..."
        eval "$3"
        if command_exists "$1"; then
            echo "✅ $2 installed successfully."
        else
            echo "❌ Failed to install $2!"
        fi
    else
        echo "✅ $2 is already installed. Skipping..."
    fi
}

### SYSTEM UTILITIES ###
echo "\n🔹 Installing Developer Tools..."
sudo apt install -y build-essential cmake pkg-config

### DEVOPS TOOLS ###
echo "\n🔹 Installing DevOps Tools..."
install_package "docker" "Docker" "curl -fsSL https://get.docker.com | bash && sudo usermod -aG docker \$USER"
install_package "ansible" "Ansible" "sudo apt install -y ansible"
install_package "terraform" "Terraform" "wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && echo 'deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com \$(lsb_release -cs) main' | sudo tee /etc/apt/sources.list.d/hashicorp.list && sudo apt update && sudo apt install -y terraform"
install_package "go" "Go" "sudo apt install -y golang && echo 'export PATH=\$PATH:/usr/local/go/bin' >> ~/.bashrc && source ~/.bashrc && go version"
install_package "jenkins" "Jenkins" "sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian/jenkins.io-2023.key && echo 'deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/' | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null && sudo apt update && sudo apt install -y jenkins && sudo systemctl enable --now jenkins"

### KUBERNETES TOOLS ###
echo "\n🔹 Installing Kubernetes Tools..."
sudo rm -f /etc/apt/sources.list.d/kubernetes.list
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key | sudo tee /etc/apt/keyrings/kubernetes-archive-keyring.gpg > /dev/null
gpg --dearmor < /etc/apt/keyrings/kubernetes-archive-keyring.gpg | sudo tee /etc/apt/keyrings/kubernetes-keyring.gpg > /dev/null

echo "deb [signed-by=/etc/apt/keyrings/kubernetes-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
install_package "kubectl" "kubectl" "sudo apt install -y kubectl"
install_package "minikube" "Minikube" "curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/"
install_package "k9s" "K9s" "curl -Lo k9s.tar.gz https://github.com/derailed/k9s/releases/latest/download/k9s_Linux_amd64.tar.gz && tar -xzf k9s.tar.gz && sudo mv k9s /usr/local/bin/ && rm k9s.tar.gz"

### NETWORKING TOOLS ###
echo "\n🔹 Installing Networking Tools..."
install_package "gns3server" "GNS3" "sudo add-apt-repository ppa:gns3/ppa -y && sudo apt update && sudo apt install -y gns3-gui gns3-server"
install_package "containerlab" "Containerlab" "curl -sL https://containerlab.dev/setup | sudo -E bash -s 'all'"

### MONITORING TOOLS ###
echo "\n🔹 Installing Monitoring Tools..."
install_package "prometheus" "Prometheus" "sudo apt install -y prometheus"
install_package "grafana-server" "Grafana" "sudo rm -f /usr/share/keyrings/grafana-archive-keyring.gpg && sudo mkdir -p /etc/apt/keyrings && curl -fsSL https://packages.grafana.com/gpg.key | sudo gpg --dearmor -o /usr/share/keyrings/grafana-archive-keyring.gpg && echo 'deb [signed-by=/usr/share/keyrings/grafana-archive-keyring.gpg] https://packages.grafana.com/oss/deb stable main' | sudo tee /etc/apt/sources.list.d/grafana.list > /dev/null && sudo apt update && sudo apt install -y grafana && sudo systemctl enable --now grafana-server && systemctl status grafana-server"
### CLOUD CLIs ###
echo "\n🔹 Installing Cloud CLIs..."
install_package "aws" "AWS CLI" "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip' && unzip awscliv2.zip && sudo ./aws/install && rm -rf awscliv2.zip aws && export PATH=\$PATH:/usr/local/bin/aws"

# Updated Azure CLI installation command using the official installer
install_package "az" "Azure CLI" "curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash"

# Updated Google Cloud CLI installation command
install_package "gcloud" "Google Cloud CLI" "sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates gnupg curl && sudo rm -f /etc/apt/sources.list.d/google-cloud-sdk.list && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg && echo \"deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main\" | sudo tee /etc/apt/sources.list.d/google-cloud-sdk.list > /dev/null && sudo apt-get update && sudo apt-get install -y google-cloud-cli"

echo "\n🔹 Installing Python Networking Libraries..."
pip3 install --upgrade pip
pip3 install netmiko napalm

### CLEANUP ###
echo "\n🔹 Cleaning up..."
sudo apt autoremove -y

echo "\n🚀 NetDevOps Setup Completed! Restart your shell or run 'source ~/.bashrc' to apply changes. \n"
