export LOCATION=centraluseuap
export GROUP=rg-ngmin-ladr-3
export FLEET=fleet
az group create -l ${LOCATION} -g ${GROUP}
az fleet create -l ${LOCATION} -g ${GROUP} -n ${FLEET} --dns-name-prefix ${FLEET} --debug
echo "Fleet properties"
az fleet get -n $FLEET -g $GROUP
export CLUSTER_1=member-ngmin-ladr-3
az aks create -g ${GROUP} -n ${CLUSTER_1}
export MEMBER_RESOURCE_ID_1=$(az aks show -g ${GROUP} -n ${CLUSTER_1} --query id --output tsv)
echo "Joining cluster id ${MEMBER_RESOURCE_ID_1}"
az fleet member join -g ${GROUP} -n ${FLEET} --member-cluster-id=${MEMBER_RESOURCE_ID_1}
sleep 300 #make sure fleet join finished.
echo "Checking member list"
az fleet member list -g ${GROUP} -n ${FLEET}
az aks delete -g ${GROUP} -n ${CLUSTER_1}
sleep 300 #make sure delete cluster finished.
echo "Removing cluster id ${MEMBER_RESOURCE_ID_1}"
az fleet member remove -g ${GROUP} -n ${FLEET} --member-name=${CLUSTER_1}
echo "Checking member list"
az fleet member list -g ${GROUP} -n ${FLEET}
echo "Recreating member cluster"
az aks create -g ${GROUP} -n ${CLUSTER_1}
export MEMBER_RESOURCE_ID_1=$(az aks show -g ${GROUP} -n ${CLUSTER_1} --query id --output tsv)
echo "Joining cluster id ${MEMBER_RESOURCE_ID_1}"
az fleet member join -g ${GROUP} -n ${FLEET} --member-cluster-id=${MEMBER_RESOURCE_ID_1}
sleep 300 #make sure fleet join finished.
echo "Checking member list"
az fleet member list -g ${GROUP} -n ${FLEET}