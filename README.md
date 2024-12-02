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



# Dockerized-FedpyLot
This original project, FedPyLot, was initially designed to run on a physical MPI cluster. By containerizing the project using Docker, we've enhanced its portability and scalability. The Dockerized application can now be deployed on various platforms without requiring significant modifications. This approach simplifies the deployment process and enables efficient resource utilization, as well as better simulation of heterogeneous resource environments in federated learning settings.
### Automated Installation Workflow
1- conda env create -f environment.yml
  conda activate my_env

2- Install pip dependencies:
  pip install -r requirements.txt
  
3- Install system dependencies:
  sudo apt-get install -y libgl1-mesa-glx
