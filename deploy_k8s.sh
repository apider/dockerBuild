if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ];then
        echo Usage: $0 deploymentName git-repo nameSpaceName
        echo Example: $0 test123 git@github.com:xxx/xxx.git dev
        exit 1
fi

echo --- Building container: $1
docker build --rm -t localhost:32000/"$1":latest $2
echo --- Pushing...
docker push localhost:32000/"$1":latest
echo --- Removing local image
docker rmi localhost:32000/"$1"

echo --- Cloning repo: $2
git clone $2

echo --- Re/starting deployment: $1
kubectl delete -f $1/manifest.yaml
kubectl apply -f $1/manifest.yaml

echo --- Removing repo: $2
rm -rf $1
#echo --- kubectl rollout -n $3 restart deployment/$1
#kubectl rollout -n $3 restart deployment/$1

#kubectl get all -n $3
echo --- Done
