## Create config secret
- Note: the following files should be stored in a folder `secret/`

  1. `config.toml`: parity configs file
  2. `rp-bundle.crt`
  3. `rp-key.key`

```
# Create configmap
kubectl create configmap parity-config-2 \
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
kubectl create secret tls tls-certificate \
  --key ./secret/rp-key.key \
  --cert ./secret/rp-bundle.crt \
  --namespace parity-rp

# Create secret
kubectl create secret generic tls-dhparam \
  --from-file ./secret/rp-ssl.pem \
  --namespace parity-rp

# Delete secret
kubectl delete secret nginx-ssl --namespace parity-rp

# Combined
kubectl delete secret nginx-ssl --namespace parity-rp && \
kubectl create secret tls nginx-ssl \
  --key ./secret/rp-key.key \
  --cert ./secret/rp-bundle.crt \
  --namespace parity-rp
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
$ kubectl delete service parity-node --namespace parity-rp && \
  kubectl delete deployment parity-node --namespace parity-rp

# Restart the deployment
$ kubectl delete service parity-node --namespace parity-rp && \
  kubectl delete deployment parity-node --namespace parity-rp && \
  kubectl create -f parity-rp-deployment.yml --namespace parity-rp

```

## Create ingress / HAProxy

```
$ kubectl create -f parity-ingress.yml && \
  kubectl create -f haproxy-ingress-deployment.yml && \
  kubectl create -f haproxy-ingress-svc.yml

# Delete
$ kubectl delete ingress parity-ingress --namespace parity-rp && \
  kubectl delete deployment haproxy-ingress --namespace parity-rp && \
  kubectl delete service haproxy-ingress --namespace parity-rp

# Restart
$ kubectl delete ingress parity-ingress --namespace parity-rp && \
  kubectl delete deployment haproxy-ingress --namespace parity-rp && \
  kubectl delete service haproxy-ingress --namespace parity-rp && \
  kubectl create -f parity-ingress.yml && \
  kubectl create -f haproxy-ingress-deployment.yml && \
  kubectl create -f haproxy-ingress-svc.yml
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
$ watch -n 1 kubectl get ingress --namespace parity-rp
$ watch -n 1 kubectl get deployment parity-node --namespace parity-rp
$ watch -n 1 kubectl get services --namespace parity-rp
$ watch -n 1 kubectl get pods --namespace parity-rp

$ kubectl logs [POD-NAME] -f --namespace parity-rp
```

## Scaling

```
# Scaling deployment
$ kubectl scale --replicas=COUNT -f parity-node-deployment.yml
```

## Exposing Port

```
$ kubectl expose deployment parity-node --type=ClusterIP --name=parity-service --namespace parity-rp
```

## Nginx Reverse Proxy

```
# Create Replciation Controller
$ kubectl create -f 07-nginx-ingress-controller.yml

# Delete controller
$ kubectl delete rc nginx-ingress-controller --namespace parity-rp 
```