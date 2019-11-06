if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ] ;then
	echo Usage: $0 projectName expose-port git-repo
	echo Example: $0 test123 5000 git@github.com:xxx/xxx.git
	exit 1
fi

echo --- Stopin and Removing old container with same name: $1
sudo docker stop $1
sudo docker rm $1
echo --- Building container: $1
sudo docker build --rm -t "$1" $3
echo --- Running container: $1
sudo docker run --restart=always --name="$1" -d -p $2:5001 "$1"
echo --- Container $1 started.
sudo docker ps | grep $1
echo --- Done
