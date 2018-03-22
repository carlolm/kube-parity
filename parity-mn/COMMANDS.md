## Create config secret
- Note: the following files should be stored in a folder `secret/`

  1. `config.toml`: parity configs file
  2. `mn-bundle.crt`
  3. `mn-key.key`


```
# Create configmap
kubectl create configmap parity-config \
  --from-file=./secret/config.toml \
  --namespace parity-mn

# Delete configmap
kubectl delete configmap parity-config --namespace parity-mn

# Combined
kubectl delete configmap parity-config --namespace parity-mn && \
kubectl create configmap parity-config \
  --from-file=./secret/config.toml \
  --namespace parity-mn
```

## Create SSL TLS secret

```

# Create secret
kubectl create secret tls mn-tls \
  --key ./secret/mn-key.key \
  --cert ./secret/mn-bundle.crt \
  --namespace parity-mn

# Create secret
kubectl create secret generic tls-dhparam \
  --from-file ./secret/rp-ssl.pem \
  --namespace parity-mn

# Delete secret
kubectl delete secret nginx-ssl --namespace parity-mn

# Combined
kubectl delete secret nginx-ssl --namespace parity-mn && \
kubectl create secret tls nginx-ssl \
  --key ./secret/rp-key.key \
  --cert ./secret/rp-bundle.crt \
  --namespace parity-mn
```

## Create ConfigMap for nginx

```
$ kubectl create configmap nginx-config --from-file=./nginx.conf --namespace parity-mn
```

## Running a deployment

```
# Create the namespace
$ kubectl create -f namespace.yml

# Create the deployment
$ kubectl create -f parity-mn-deployment.yml --namespace parity-mn

# Delete the deployment
$ kubectl delete service parity-node --namespace parity-mn && \
  kubectl delete deployment parity-node --namespace parity-mn

# Restart the deployment
$ kubectl delete service parity-node --namespace parity-mn && \
  kubectl delete deployment parity-node --namespace parity-mn && \
  kubectl create -f parity-mn-deployment.yml --namespace parity-mn

```

## Create ingress / HAProxy

```
$ kubectl create -f parity-ingress.yml && \
  kubectl create -f haproxy-ingress-deployment.yml && \
  kubectl create -f haproxy-ingress-svc.yml

# Delete
$ kubectl delete ingress parity-ingress --namespace parity-mn && \
  kubectl delete deployment haproxy-ingress --namespace parity-mn && \
  kubectl delete service haproxy-ingress --namespace parity-mn

# Restart
$ kubectl delete ingress parity-ingress --namespace parity-mn && \
  kubectl delete deployment haproxy-ingress --namespace parity-mn && \
  kubectl delete service haproxy-ingress --namespace parity-mn && \
  kubectl create -f parity-ingress.yml && \
  kubectl create -f haproxy-ingress-deployment.yml && \
  kubectl create -f haproxy-ingress-svc.yml
```


## Launch service to expose ports

```
# Create the service
$ kubectl create -f parity-mn-service.yml --namespace parity-mn

# Delete the service
$ kubectl delete service parity-mn-service --namespace parity-mn

# Restart the service
$ kubectl delete service parity-mn-service --namespace parity-mn && \
  kubectl create -f parity-mn-service.yml --namespace parity-mn
```

## Monitoring and logging

```
$ watch -n 1 kubectl get ingress --namespace parity-mn
$ watch -n 1 kubectl get deployment parity-node --namespace parity-mn
$ watch -n 1 kubectl get services --namespace parity-mn
$ watch -n 1 kubectl get pods --namespace parity-mn

$ kubectl logs [POD-NAME] -f --namespace parity-mn
```

## Scaling

```
# Scaling deployment
$ kubectl scale --replicas=COUNT -f parity-node-deployment.yml
```

## Exposing Port

```
$ kubectl expose deployment parity-node --type=ClusterIP --name=parity-service --namespace parity-mn
```

## Nginx Reverse Proxy

```
# Create Replciation Controller
$ kubectl create -f 07-nginx-ingress-controller.yml

# Delete controller
$ kubectl delete rc nginx-ingress-controller --namespace parity-mn 
```