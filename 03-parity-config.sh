kubectl create secret generic parity-config --namespace mainnet \
--from-file=config.toml=parity-mn/secret/config.toml &&
kubectl create secret generic parity-config --namespace ropsten \
--from-file=config.toml=parity-rp/secret/config.toml