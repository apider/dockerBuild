if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] || [ -z "$4" ];then
        echo Usage: $0 deploymentName git-repo nameSpaceName version
        echo Example: $0 test123 git@github.com:xxx/xxx.git dev v1
        exit 1
fi

echo --- Building container: $1
docker build --rm -t registry.home:6000/$1:$4 $2
echo --- Pushing...
docker push registry.home:6000/$1:$4
echo --- Removing local image
docker rmi registry.home:6000/$1:$4

echo --- Cloning repo: $2
git clone $2

echo --- Re/starting deployment: $1 from manifest.yaml
#kubectl delete -f $1/manifest.yaml
kubectl apply -f $1/manifest.yaml
# kubectl set -n $3 image deployments/$1 $1=registry.home:6000/$1:$4
kubectl rollout -n $3 restart deployment/$1
echo --- Removing repo: $2
rm -rf $1
#echo --- kubectl rollout -n $3 restart deployment/$1
#kubectl rollout -n $3 restart deployment/$1
#kubectl rolling-update -n $3 $1
#kubectl get all -n $3
echo Deployed: $1, ns: $3, image: $1:$4
echo ""
echo To revert to previous run: kubectl set -n $3 image deployments/$1 $1=registry.home:6000/$1:"<previous-version>"
echo Or: kubectl rollout undo -n $3 deployments/$1
echo --- Done
sleep 1
kubectl -n $3 get all