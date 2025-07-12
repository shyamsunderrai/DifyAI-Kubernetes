# PostgreSQL Initialization (Kubernetes Environment)

This document outlines how to operate PostgreSQL in a Kubernetes cluster (assuming it's deployed via StatefulSet), create a `root` user and database, and modify the `pg_hba.conf` file to allow external connections.

## 🧰 Requirements

* A running Kubernetes cluster
* Namespace: `difyai`
* PostgreSQL Pod name: `postgres-0`
* Default PostgreSQL username: `postgres`
* Default PostgreSQL database: `postgres`

## 🚀 Steps

### 1. Create a superuser `root`

```bash
kubectl -n difyai exec -it postgres-0 -- psql -U postgres -d postgres -c "CREATE ROLE root WITH LOGIN SUPERUSER;"
```

### 2. Create a database and assign `root` as the owner

```bash
kubectl -n difyai exec -it postgres-0 -- psql -U postgres -c "CREATE DATABASE root OWNER root;"
```

### 3. List current PostgreSQL roles

```bash
kubectl -n difyai exec -it postgres-0 -- psql -U postgres -d postgres -c "\du"
```

### 4. List all databases

```bash
kubectl -n difyai exec -it postgres-0 -- psql -U postgres -d postgres -c "\l"
```

### 5. Modify `pg_hba.conf`: change authentication method to `md5`

Remove the last line:

```bash
kubectl -n difyai exec -it postgres-0 -- sed -i '$d' /var/lib/postgresql/data/pgdata/pg_hba.conf
```

Append new md5 authentication configuration:

```bash
kubectl -n difyai exec -it postgres-0 -- sh -c "echo 'host    all             all             0.0.0.0/0               md5' >> /var/lib/postgresql/data/pgdata/pg_hba.conf"
```

### 6. Restart the Pod to apply changes

```bash
kubectl -n difyai delete pod postgres-0
```

## 📝 Notes

* Ensure `listen_addresses = '*'` is set in `postgresql.conf`
* If using PVCs for storage, changes to `pg_hba.conf` will persist
* Be cautious when modifying authentication methods to maintain connection security

## 📄 License

This project is unlicensed. You are free to modify and use it as needed.
