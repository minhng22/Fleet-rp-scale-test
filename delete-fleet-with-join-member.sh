export LOCATION=centraluseuap
export GROUP=rg-ngmin-dfwjm-0
export FLEET=fleet
az group create -l ${LOCATION} -g ${GROUP}
az fleet create -l ${LOCATION} -g ${GROUP} -n ${FLEET} --dns-name-prefix ${FLEET} --debug
echo "Fleet properties"
az fleet show -n $FLEET -g $GROUP
echo "Join aad cluster"
export CLUSTER_1=ngmin-dfwjm-cluster-0
az aks create -g ${GROUP} -n ${CLUSTER_1}
export MEMBER_RESOURCE_ID_1=$(az aks show -g ${GROUP} -n ${CLUSTER_1} --query id --output tsv)
echo "Joining cluster id ${MEMBER_RESOURCE_ID_1}"
az fleet member create -g ${GROUP} -f ${FLEET} --member-cluster-id=${MEMBER_RESOURCE_ID_1} -n ${CLUSTER_1}
echo "List all members of fleet"
az fleet member list -g ${GROUP} -n ${FLEET}
echo "Delete fleet"
az fleet delete -g ${GROUP} -n ${FLEET}