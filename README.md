# AKS-VNET

az acr login --name myacr321012ulan

docker tag my-python-appulan:7.7.7 myacr321012ulan.azurecr.io/my-python-appulan:7.7.7

docker push myacr321012ulan.azurecr.io/my-python-appulan:7.7.7

# You can verify that the image has been successfully pushed to ACR by listing the repositories:
az acr repository list --name myacr321012ulan --output table

# And to check the tags for a specific repository:
az acr repository show-tags --name myacr321012ulan --repository my-python-appulan --output table    


#  Helm Chart 
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helm version

helm repo add stable https://charts.helm.sh/stable

helm repo update

helm install my-python-appulan-release ./my-python-appulan-chart-0.1.0.tgz

helm list

az aks update -n K8S --resource-group aks_rg --attach-acr myacr321012ulan

