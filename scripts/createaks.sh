source ../venv/az.env
# Get the subnet IDs
vnet_id=$(az network vnet show \
    --resource-group $GRPNAME \
    --name $VNET \
    --query id -o tsv)

pod_subnet_id=$(az network vnet subnet show \
    --resource-group $GRPNAME \
    --vnet-name $VNET \
    --name $POD_SUBNET \
    --query id -o tsv)

service_subnet_id=$(az network vnet subnet show \
    --resource-group $GRPNAME \
    --vnet-name $VNET \
    --name $SVC_SUBNET \
    --query id -o tsv)

node_subnet_id=$(az network vnet subnet show \
    --resource-group $GRPNAME \
    --vnet-name $VNET \
    --name $NODE_SUBNET \
    --query id -o tsv)

# Create AKS
az aks create \
    --resource-group $GRPNAME \
    --name $AKSNAME \
    --node-count 2 \
    --network-plugin azure 
    # --vnet-subnet-id $pod_subnet_id \
    # --pod-cidr $POD_CIDR\
    # --service-cidr $SVC_CIDR \
    # --dns-service-ip $VNET_DNS_IP
az aks get-credentials --resource-group $GRPNAME --name $AKSNAME
