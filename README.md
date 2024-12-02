# **Dockerized-FedPyLot**

FedPyLot was originally designed to run on a physical MPI cluster. By containerizing the project with Docker, we have enhanced its **portability** and **scalability**. This Dockerized application can now be deployed across various platforms without requiring significant modifications. 

Containerization simplifies the deployment process, enables efficient resource utilization, and facilitates better simulation of heterogeneous resource environments, particularly in federated learning scenarios.

---

## **Automated Installation Workflow**

Follow these steps to set up the project and run it seamlessly:

### **1. Create and Activate the Conda Environment**
```bash
#install conda or miniconda with python3.9 to get rid of compatability problems
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh
chmod +x Miniconda3-py39_4.12.0-Linux-x86_64.sh
bash Miniconda3-py39_4.12.0-Linux-x86_64.sh
# insatallion path in my machine is /FLearning/miniconda3, therefore add bin folder to environment PATH variable
export PATH=/FLearning/miniconda3/bin/:$PATH
conda init
source ~/.bashrc 

conda env create -f environment.yml
conda activate my_env
```

### **2. Install pip dependencies:**
```bash
  pip install -r requirements.txt
```
  
### **3. Install system dependencies:**
```bash
  sudo apt-get install -y libgl1-mesa-glx
```
