#!/bin/bash
aksRegions=()
while read object; do
    aksRegions+=("${object}")
done < <(az provider show -n Microsoft.ContainerService | jq -r '.resourceTypes[] | select(.resourceType=="managedClusters") | .locations[]')
aksRegions=("${aksRegions[@]:0:4}")
for region in "${aksRegions[@]}"; do
    echo "reg ${region}"
    regionNames=($(az account list-locations --query "[? displayName == '${region}'].name" --output tsv))
    export LOCATION=${regionNames[0]}
    echo "region alias ${LOCATION}"
    echo "Creating fleet"
    export GROUP=sau-${LOCATION}
    export FLEET=fleet
    az group create -l ${LOCATION} -g ${GROUP}
    az fleet create -l ${LOCATION} -g ${GROUP} -n ${FLEET} --dns-name-prefix ${FLEET} --debug
    echo "Joining cluster"
    export CLUSTER=toh-${LOCATION}
    az aks create -g ${GROUP} -n ${CLUSTER}
    export MEMBER_RESOURCE_ID=$(az aks show -g ${GROUP} -n ${CLUSTER} --query id --output tsv)
    echo "Joining cluster id ${MEMBER_RESOURCE_ID}"
    az fleet member create -g ${GROUP} -f ${FLEET} --member-cluster-id=${MEMBER_RESOURCE_ID} -n ${CLUSTER}
    echo "List all members of fleet"
    az fleet member list -g ${GROUP} -f ${FLEET}
done