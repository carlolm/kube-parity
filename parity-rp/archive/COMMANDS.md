## Create config secret
- Note: the following files should be stored in a folder `secret/`

  1. `config.toml`: parity configs file
  2. `rp-bundle.crt`
  3. `rp-key.key`

- This file should be in the `parity-rp/` folder
  1. `nginx.conf`

```
# Create configmap
kubectl create configmap parity-config \
  --from-file=./secret/config.toml \
  --namespace parity-rp

# Delete configmap
kubectl delete configmap parity-config --namespace parity-rp

# Combined
kubectl delete configmap parity-config --namespace parity-rp && \
kubectl create configmap parity-config \
  --from-file=./secret/config.toml \
  --namespace parity-rp
```

## Create SSL TLS secret

```

# Create secret
kubectl create secret tls nginx-ssl \
  --key ./secret/rp-key.key \
  --cert ./secret/rp-bundle.crt \
  --namespace parity-rp

# Delete secret
kubectl delete secret nginx-ssl

# Combined
kubectl delete secret nginx-ssl && \
kubectl create secret tls nginx-ssl \
  --key ./secret/rp-key.key \
  --cert ./secret/rp-bundle.crt
```

## Create ConfigMap for nginx

```
$ kubectl create configmap nginx-config --from-file=./nginx.conf --namespace parity-rp
```

## Running a deployment

```
# Create the namespace
$ kubectl create -f namespace.yml

# Create the deployment
$ kubectl create -f parity-rp-deployment.yml --namespace parity-rp

# Delete the deployment
$ kubectl delete deployment parity-rp-deployment --namespace parity-rp

# Restart the deployment
$ kubectl delete deployment parity-rp-deployment --namespace parity-rp && \
  kubectl create -f parity-rp-deployment.yml --namespace parity-rp

```

## Launch service to expose ports

```
# Create the service
$ kubectl create -f parity-rp-service.yml --namespace parity-rp

# Delete the service
$ kubectl delete service parity-rp-service --namespace parity-rp

# Restart the service
$ kubectl delete service parity-rp-service --namespace parity-rp && \
  kubectl create -f parity-rp-service.yml --namespace parity-rp
```

## Monitoring and logging

```
$ watch -n 1 kubectl get services --namespace parity-rp
$ watch -n 1 kubectl get deployment parity-rp-deployment --namespace parity-rp
$ watch -n 1 kubectl get pods --namespace parity-rp

$ kubectl logs [POD-NAME] -f --namespace parity-rp
```