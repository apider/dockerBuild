if [ -z "$1" ] || [ -z "$2" ] ;then
	echo Usage: $0 projectName git-repo
	echo Example: $0 test123 git@github.com:xxx/xxx.git
	exit 1
fi

echo --- Stopping and Removing old container with same name: $1
sudo docker stop $1
sudo docker rm $1
sudo docker rmi $1
echo --- Building container: $1
sudo docker build --rm -t "$1" $2
echo --- Running container: $1
sudo docker run --restart=always --name="$1" -d "$1"
echo --- Container $1 started.
sudo docker ps | grep $1
echo --- Done
