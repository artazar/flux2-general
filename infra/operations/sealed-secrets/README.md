Main doc: [Sealed Secrets](https://fluxcd.io/docs/guides/sealed-secrets/)

Brief how to to encrypt secrets:

1. Create a new secret definition in a YAML file

```
kubectl -n default create secret generic basic-auth \
--from-literal=user=admin \
--from-literal=password=change-me \
--dry-run=client \
-o yaml > basic-auth.yaml
```

2. Encrypt the secret to make it sealed:

```
kubeseal --format=yaml --cert=pub-sealed-secrets.pem \
< basic-auth.yaml > basic-auth-sealed.yaml
```

3. Remove the original non-encrypted version:

```
rm -f basic-auth.yaml
```

4. Store the encrypted version in Git. Sealed-Secrets controller in Kubernetes will take care of the secret decryption.
