# DifyAI on Kubernetes

This project provides a complete Kubernetes deployment for [Dify](https://github.com/langgenius/dify), an open-source LLMOps platform. It includes all necessary components such as PostgreSQL, Redis, Weaviate, and Dify application modules like API, Web UI, Workers, and Plugin Daemon.

## 📁 Project Structure

```
.
├── api
│   ├── service.yaml
│   └── statefulset.yaml
├── configmap
│   ├── difyai-configmap.yaml
│   ├── genconfig.sh
│   ├── nginx-configmap-0.yaml
│   ├── nginx-configmap-1.yaml
│   ├── nginx-configmap-2.yaml
│   ├── nginx-configmap-3.yaml
│   ├── nginx-configmap-4.yaml
│   ├── nginx-configmap-5.yaml
│   ├── sandbox-configmap-0.yaml
│   ├── sandbox-configmap-1.yaml
│   ├── ssrf-proxy-configmap-0.yaml
│   └── ssrf-proxy-configmap-1.yaml
├── LICENSE
├── nginx
│   ├── deployment.yaml
│   └── service.yaml
├── persistentvolumeclaim
│   └── difyai.yaml
├── plugin-daemon
│   ├── deployment.yaml
│   └── service.yaml
├── postgresql
│   ├── README.md
│   ├── service.yaml
│   └── statefulset.yaml
├── README.md
├── redis
│   ├── service.yaml
│   └── statefulset.yaml
├── sandbox
│   ├── deployment.yaml
│   └── service.yaml
├── ssrf-proxy
│   ├── deployment.yaml
│   └── service.yaml
├── weaviate
│   ├── service.yaml
│   └── statefulset.yaml
├── web
│   ├── deployment.yaml
│   └── service.yaml
└── worker
    ├── service.yaml
    └── statefulset.yaml
```

Total: **13 directories, 36 files**

## 🚀 Features

* Full deployment of Dify backend components on Kubernetes
* Support for persistent volumes and configuration via ConfigMaps
* Modular and extensible structure
* Custom Nginx reverse proxy and sandbox environment included
* External integrations: PostgreSQL, Redis, Weaviate

## ⚙️ Prerequisites

* Kubernetes cluster (v1.20+)
* StorageClass for Persistent Volumes (e.g., Longhorn)

## 🏗️ Setup Guide

### 1. **Clone the Repository:**

   ```bash
   git clone https://github.com/your-org/DifyAI-Kubernetes.git
   cd DifyAI-Kubernetes
   ```

### 2. **Create Persistent Volume Claims:**

   ```bash
   kubectl create -f persistentvolumeclaim/difyai.yaml
   ```

### 3. **Create ConfigMaps:**

   ```bash
   kubectl create -f configmap/difyai-configmap.yaml -f configmap/nginx-configmap-0.yaml -f configmap/nginx-configmap-1.yaml -f configmap/nginx-configmap-2.yaml -f configmap/nginx-configmap-3.yaml -f configmap/nginx-configmap-4.yaml -f configmap/nginx-configmap-5.yaml -f configmap/sandbox-configmap-0.yaml -f configmap/sandbox-configmap-1.yaml -f configmap/ssrf-proxy-configmap-0.yaml -f configmap/ssrf-proxy-configmap-1.yaml
   ```

### 4. Create Core Services:

* **PostgreSQL**

  ```bash
  kubectl create -f postgresql/service.yaml -f postgresql/statefulset.yaml
  ```

* **Redis**

  ```bash
  kubectl create -f redis/service.yaml -f redis/statefulset.yaml
  ```

* **Weaviate**

  ```bash
  kubectl create -f weaviate/service.yaml -f weaviate/statefulset.yaml
  ```

### 5. Create Dify Components:

* **API**

  ```bash
  kubectl create -f api/service.yaml -f api/statefulset.yaml
  ```

* **Web UI**

  ```bash
  kubectl create -f web/deployment.yaml -f web/service.yaml
  ```

* **Worker**

  ```bash
  kubectl create -f worker/service.yaml -f worker/statefulset.yaml
  ```

* **Plugin Daemon**

  ```bash
  kubectl create -f plugin-daemon/deployment.yaml -f plugin-daemon/service.yaml
  ```

* **Nginx**

  ```bash
  kubectl create -f nginx/deployment.yaml -f nginx/service.yaml
  ```

* **Sandbox**

  ```bash
  kubectl create -f sandbox/deployment.yaml -f sandbox/service.yaml
  ```

* **SSRF Proxy**

  ```bash
  kubectl create -f ssrf-proxy/deployment.yaml -f ssrf-proxy/service.yaml
  ```

## 📌 Notes

* Configuration files can be customized under `configmap/`
* Ensure that the correct environment variables are set in the Dify ConfigMap
* You may use `configmap/genconfig.sh` to generate the ConfigMap from a `.env` file


## 📜 License

This project is licensed under the [MIT License](./LICENSE).

## 🙏 Acknowledgements

* [Dify](https://github.com/langgenius/dify)
* [Weaviate](https://weaviate.io/)
* [PostgreSQL](https://www.postgresql.org/)
* [Redis](https://redis.io/)
