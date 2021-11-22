if [ -z "$1" ] || [ -z "$2" ] ;then
        # echo Usage: $0 deploymentName git-repo nameSpaceName version
        echo Usage: $0 git-repo nameSpaceName
        # echo Example: $0 test123 git@github.com:xxx/xxx.git dev v1
        echo Example: $0 git@github.com:xxx/xxx.git my-namespace
        exit 1
fi

NAME=`echo $1 | awk 'match($0,/\/(.+)\.git/,a){print a[1]}'`

echo --- Building container: $NAME
docker build --rm -t registry.home:6000/$NAME:latest $1
echo --- Pushing...
docker push registry.home:6000/$NAME:latest
echo --- Removing local image
docker rmi registry.home:6000/$NAME:latest

echo --- Cloning repo: $1
git clone $1

echo --- Re/starting deployment: $1 from manifest.yaml
#kubectl delete -f $1/manifest.yaml
kubectl apply -f $NAME/manifest.yaml
# kubectl set -n $3 image deployments/$1 $1=registry.home:6000/$1:latest
kubectl rollout -n $2 restart deployment/$NAME
#kubectl rolling-update -n $3 $1
echo --- Removing local repo: $1
rm -rf $NAME
echo ""
echo --- Done
echo --- Deployed: $NAME, ns: $2, image: $NAME:latest
echo ""
echo --- To revert to previous run: kubectl set -n $2 image deployments/$NAME $NAME=registry.home:6000/$1:"<previous-version>"
echo --- Or: kubectl rollout undo -n $2 deployments/$NAME
echo ""
sleep 2
kubectl -n $2 get all