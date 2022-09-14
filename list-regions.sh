reg=()
while read object; do
    regionNames=($(az account list-locations --query "[? displayName == '${object}'].name" --output tsv))
    #echo "region ${regionNames[0]}"
    reg+=("${regionNames[0]}")
done < <(az provider show -n Microsoft.ContainerService | jq -r '.resourceTypes[] | select(.resourceType=="managedClusters") | .locations[]')
echo "Number of aks regions ${#reg[@]}"
echo "List of regions ${reg[@]}"