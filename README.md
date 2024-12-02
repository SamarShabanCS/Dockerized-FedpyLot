# **Dockerized-FedPyLot**

FedPyLot was originally designed to run on a physical MPI cluster. By containerizing the project with Docker, we have enhanced its **portability** and **scalability**. This Dockerized application can now be deployed across various platforms without requiring significant modifications. 

Containerization simplifies the deployment process, enables efficient resource utilization, and facilitates better simulation of heterogeneous resource environments, particularly in federated learning scenarios.

---

## **Automated Installation Workflow**

Follow these steps to set up the project and run it seamlessly:

### **1. Create and Activate the Conda Environment**
```bash
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
