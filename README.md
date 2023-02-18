# iac-vaultwarden

## Migration

If you used this to establish a Bitwarden_rs server, you will have to terraform apply and then scale down the deployment.
Attach a pod to the config folder and use an app like croc to send the database files.
Then remove the shim pod and scale the vaultwarden server up as needed.

> Vaultwarden cannot be running when the database files are copied over.
