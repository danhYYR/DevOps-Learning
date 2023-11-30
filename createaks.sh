source ./venv/az.env
az aks create --resource-group $GRPNAME --name $AKSNAME
az aks get-credentials --resource-group $GRPNAME --name $AKSNAME