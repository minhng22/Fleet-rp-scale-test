export LOCATION=<LOCATION>
export GROUP=<GROUP>
export FLEET=<FLEET_NAME>
az group create -l ${LOCATION} -g ${GROUP}
az fleet create -l ${LOCATION} -g ${GROUP} -n ${FLEET} --dns-name-prefix ${FLEET} --debug
echo "Fleet properties"
az fleet show -n $FLEET -g $GROUP
allCluster=($(az aks list --output tsv --query "[? !(contains(id, 'resourcegroups/e2erg')) && !(contains(id, '-cx-3')) && !(contains(id, '-svc-0')) && !(contains(id, '-cx-1'))].id"))
echo "Getting all cluster ids"
echo "One cluster available to join"
echo ${allCluster[0]}
echo ${#allCluster[@]}
#echo "Getting first 100 members"
#clusters=("${allCluster[@]:0:100}")
#echo ${#clusters[@]}
#echo "Joining first 100 member clusters"
for cluster in ${allCluster[@]}
do
    echo "Joining cluster member. Cluster id $cluster"
    az fleet member create -g ${GROUP} -f ${FLEET} --member-cluster-id=${cluster} -n ${cluster}
done