export LOCATION=centraluseuap
export GROUP=rg-ngmin-network-0
export FLEET=fleet
az group create -l ${LOCATION} -g ${GROUP}
az fleet create -l ${LOCATION} -g ${GROUP} -n ${FLEET} --dns-name-prefix ${FLEET} --debug
echo "Fleet properties"
az fleet show -n $FLEET -g $GROUP
echo "Join kubernetes network plugin cluster"
export CLUSTER_1=kubenetworkcluster
az aks create -g ${GROUP} -n ${CLUSTER_1} --network-plugin kubenet
export MEMBER_RESOURCE_ID_1=$(az aks show -g ${GROUP} -n ${CLUSTER_1} --query id --output tsv)
echo "Joining cluster id ${MEMBER_RESOURCE_ID_1}"
az fleet member create -g ${GROUP} -f ${FLEET} --member-cluster-id=${MEMBER_RESOURCE_ID_1} -n ${CLUSTER_1}
echo "Join azure network plugin cluster"
export CLUSTER_2=azureplugincluster
az aks create -g ${GROUP} -n ${CLUSTER_2} --network-plugin azure
export MEMBER_RESOURCE_ID_2=$(az aks show -g ${GROUP} -n ${CLUSTER_2} --query id --output tsv)
echo "Joining cluster id ${MEMBER_RESOURCE_ID_2}"
az fleet member create -g ${GROUP} -f ${FLEET} --member-cluster-id=${MEMBER_RESOURCE_ID_2} -n ${CLUSTER_2}
echo "List all members of fleet"
az fleet member list -g ${GROUP} -n ${FLEET}
