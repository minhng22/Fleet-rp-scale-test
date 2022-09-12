export LOCATION=centraluseuap
export GROUP=rg-ngmin-leave-after-delete-0
export FLEET=fleet
az group create -l ${LOCATION} -g ${GROUP}
az fleet create -l ${LOCATION} -g ${GROUP} -n ${FLEET} --dns-name-prefix ${FLEET} --debug
echo "Fleet properties"
az fleet get -n $FLEET -g $GROUP
export CLUSTER_1=member1
az aks create -g ${GROUP} -n ${CLUSTER_1}
export MEMBER_RESOURCE_ID_1=$(az aks show -g ${GROUP} -n ${CLUSTER_1} --query id --output tsv)
echo "Joining cluster id ${MEMBER_RESOURCE_ID_1}"
az fleet member join -g ${GROUP} -n ${FLEET} --member-cluster-id=${MEMBER_RESOURCE_ID_1}
sleep 5m #make sure fleet join finished.
echo "Checking member list"
az fleet member list -g ${GROUP} -n ${FLEET}
az aks delete -g ${GROUP} -n ${CLUSTER_1}
sleep 5m #make sure delete cluster finished.
az fleet member remove -g ${GROUP} -n ${FLEET} --member-cluster-id=${MEMBER_RESOURCE_ID_1}
echo "Checking member list"
az fleet member list -g ${GROUP} -n ${FLEET}
