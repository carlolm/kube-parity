kubectl delete deploy nginx-ingress-mn-controller --namespace mainnet && \
kubectl delete deploy nginx-ingress-mn-default-backend --namespace mainnet && \
kubectl delete svc nginx-ingress-mn-controller --namespace mainnet && \
kubectl delete svc nginx-ingress-mn-default-backend --namespace mainnet && \
kubectl delete deploy nginx-ingress-rp-controller --namespace ropsten && \
kubectl delete deploy nginx-ingress-rp-default-backend --namespace ropsten && \
kubectl delete svc nginx-ingress-rp-controller --namespace ropsten && \
kubectl delete svc nginx-ingress-rp-default-backend --namespace ropsten