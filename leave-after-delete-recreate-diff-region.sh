export LOCATION=centraluseuap
export GROUP=rg-ngmin-ladrdr-4
export FLEET=fleet
az group create -l ${LOCATION} -g ${GROUP}
az fleet create -l ${LOCATION} -g ${GROUP} -n ${FLEET} --dns-name-prefix ${FLEET} --debug
echo "Fleet properties"
az fleet show -n $FLEET -g $GROUP
export CLUSTER_1=member-ladrdr-4
az aks create -g ${GROUP} -n ${CLUSTER_1}
export MEMBER_RESOURCE_ID_1=$(az aks show -g ${GROUP} -n ${CLUSTER_1} --query id --output tsv)
echo "Joining cluster id ${MEMBER_RESOURCE_ID_1}"
az fleet member create -g ${GROUP} -f ${FLEET} --member-cluster-id=${MEMBER_RESOURCE_ID_1} -n ${CLUSTER_1}
sleep 300 #make sure fleet join finished.
echo "Checking member list"
az fleet member list -g ${GROUP} -f ${FLEET}
az aks delete -g ${GROUP} -n ${CLUSTER_1}
sleep 300 #make sure delete cluster finished.
echo "Removing cluster id ${MEMBER_RESOURCE_ID_1}"
az fleet member delete -g ${GROUP} -f ${FLEET} -n ${CLUSTER_1}
echo "Checking member list"
az fleet member list -g ${GROUP} -f ${FLEET}
echo "Create rg in different region"
export LOCATION_1=centraluseuap
export GROUP_1=rg-ngmin-ladrdr-n-1
az group create -l ${LOCATION_1} -g ${GROUP_1}
echo "Create new member cluster"
az aks create -g ${GROUP_1} -n ${CLUSTER_1}
export MEMBER_RESOURCE_ID_1=$(az aks show -g ${GROUP_1} -n ${CLUSTER_1} --query id --output tsv)
echo "Joining cluster id ${MEMBER_RESOURCE_ID_1}"
az fleet member create -g ${GROUP} -f ${FLEET} --member-cluster-id=${MEMBER_RESOURCE_ID_1} -n ${CLUSTER_1}
sleep 300 #make sure fleet join finished.
echo "Checking member list"
az fleet member list -g ${GROUP} -f ${FLEET}