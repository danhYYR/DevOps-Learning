source ../venv/az.env
# Set variables
resource_group=$GRPNAME  # Replace with your resource group name

# Get AKS clusters in the resource group and current date
clusters=$(az aks list -g $GRPNAME --query "[].name" -o tsv)


# Iterate through clusters and check creation dates
for cluster in $clusters; do
    echo "Deleting AKS cluster: $cluster"
    az aks delete -g $GRPNAME -n $cluster --yes
done
