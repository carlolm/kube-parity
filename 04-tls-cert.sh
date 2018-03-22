kubectl create secret tls tls-mainnet \
  --key ./parity-mn/secret/mn-key.key \
  --cert ./parity-mn/secret/mn-bundle.crt \
  --namespace mainnet && \
kubectl create secret tls tls-ropsten \
  --key ./parity-rp/secret/rp-key.key \
  --cert ./parity-rp/secret/rp-bundle.crt \
  --namespace ropsten