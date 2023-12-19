Before starting, make sure the secret `cf-tunnel-token-pwgen` exists. If not,
create it as follows:

```
kubectl create secret generic cf-tunnel-token-pwgen --from-literal=token=<VALUE>
```
