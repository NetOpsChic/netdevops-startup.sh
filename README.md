# 🚀 NetDevOps Setup Script

## 📌 Overview
This script automates the installation of essential tools and frameworks for **NetDevOps engineers**. It sets up **Docker, Kubernetes, Terraform, Ansible, Google Cloud SDK, Azure CLI, AWS CLI**, and many more in a single run.

## 🛠️ Tools Installed

### **🖥️ System Utilities**
- `build-essential`
- `cmake`
- `pkg-config`
- `curl`, `wget`, `git`, `unzip`
- `ca-certificates`, `gnupg`, `lsb-release`

### **⚙️ DevOps Tools**
- `Docker`
- `Ansible`
- `Terraform`
- `Go`
- `Jenkins`

### **☸️ Kubernetes Tools**
- `kubectl`
- `minikube`
- `k9s`

### **🌐 Networking Tools**
- `GNS3`
- `Containerlab`

### **📊 Monitoring Tools**
- `Prometheus`
- `Grafana`

### **☁️ Cloud CLIs**
- `AWS CLI`
- `Google Cloud SDK`
- `Azure CLI`

## 🔧 Installation
### **1️⃣ Clone the Repository**
```sh
git clone https://github.com/NetOpsChic/netdevops-startup.sh.git
cd netdevops-startup.sh
```

### **2️⃣ Run the Script**
```sh
chmod +x netdevops_setup.sh
./netdevops-setup.sh
```

### **3️⃣ Verify Installations**
After installation, run:
```sh
./test-setup.sh
```
This will check if all tools are installed correctly.

## ⚡ Features
✅ Installs all necessary tools for **NetDevOps automation**
✅ Ensures correct **repository keys** for all cloud services
✅ Handles **Kubernetes & network automation setup**
✅ Includes **GNS3 & Containerlab** for networking
✅ Fully **automated and minimal setup**

## 📌 Notes
- **Run as root or use `sudo`** for installations
- **Reboot your system** after installation to apply changes
- If any package fails, check the logs and re-run the script


💡 **Contribute & Improve** → Submit PRs, suggest updates, or report issues!

🚀 Happy Automating!

