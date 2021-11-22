docker push registry.home:6000/$NAME:latest
echo --- Removing local image
docker rmi registry.home:6000/$NAME:latest

echo --- Cloning repo: $1
git clone $1

echo --- Re/starting deployment: $1 from manifest.yaml
kubectl apply -f $1/manifest.yaml
kubectl rollout -n $2 restart deployment/$NAME
#kubectl rolling-update -n $3 $1
echo --- Removing local repo: $1
rm -rf $1
echo Deployed: $NAME, ns: $2, image: $NAME:latest
echo ""
echo To revert to previous run: kubectl set -n $2 image deployments/$NAME $NAME=registry.home:6000/$1:"<previous-version>"
echo Or: kubectl rollout undo -n $2 deployments/$NAME
echo --- Done
sleep 2
kubectl -n $2 get all