if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] ;then
	echo Usage: $0 projectName expose-port git-repo
	echo Example: $0 test123 5000 git@github.com:xxx/xxx.git
	exit 1
fi

echo --- Stopping and Removing old container with same name: $1
docker stop $1
docker rm $1
docker rmi $1
docker rmi registry.home:6000/"$1"
echo --- Building container: $1
docker build --rm -t "$1" $3
echo docker tag "$1" registry.home:6000/"$1"
docker tag "$1" registry.home:6000/"$1"
echo Pushing...
echo docker push registry.home:6000/"$1"
docker push registry.home:6000/"$1"
docker rmi "$1"
docker rmi registry.home:6000/"$1"
echo --- Running container: $1
echo docker run --restart=always --name="$1" -d -p $2:5001 registry.home:6000/"$1"
docker run --restart=always --name="$1" -d -p $2:5001 registry.home:6000/"$1"
echo --- Container $1 started.
docker ps | grep $1
echo --- Done
