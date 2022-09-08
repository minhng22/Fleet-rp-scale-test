allCluster=($(az aks list --output tsv --query "[? !(contains(id, 'resourcegroups/e2erg'))].id"))
echo "Getting all cluster ids"
echo "One cluster available to join"
echo ${allCluster[0]}
echo ${#allCluster[@]}
echo "Getting first 100 members"
clusters=("${allCluster[@]:0:100}")
echo ${#clusters[@]}
echo "Joining first 100 member clusters"
for cluster in ${clusters[@]}
do
    echo "Joining cluster member. Cluster id $cluster"
    az fleet member join --member-cluster-id $cluster -n $FLEET -g $GROUP
done