if [ -z "$1" ] || [ -z "$2" ] ;then
	echo Usage: $0 projectName git-repo
	echo Example: $0 test123 git@github.com:xxx/xxx.git
	exit 1
fi

echo --- Stopping and Removing old container with same name: $1
docker stop $1
docker rm $1
docker rmi $1
echo --- Building container: $1
docker build --rm -t "$1" $2
echo --- Running container: $1
docker run --restart=always --name="$1" -d "$1"
echo --- Container $1 started.
docker ps | grep $1
echo --- Done
