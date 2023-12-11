source ../venv/az.env

# Create the virtual network
az network vnet create \
    --resource-group $GRPNAME \
    --name $VNET \
    --address-prefixes $VNET_PREFIX

# Create the subnets
az network vnet subnet create \
    --resource-group $GRPNAME \
    --vnet-name $VNET \
    --name $SVC_SUBNET \
    --address-prefixes $SVC_CIDR

az network vnet subnet create \
    --resource-group $GRPNAME \
    --vnet-name $VNET \
    --name $POD_SUBNET \
    --address-prefixes $POD_CIDR

az network vnet subnet create \
    --resource-group $GRPNAME \
    --vnet-name $VNET \
    --name $NODE_SUBNET \
    --address-prefixes $NODE_CIDR

