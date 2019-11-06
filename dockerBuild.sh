if [ -z "$1" ] || [ -z "$2" ] ;then
	echo Usage: $0 projectName git-repo
	echo Example: $0 test123 git@github.com:xxx/xxx.git
	exit 1
fi

echo - Stopin and Removing old container: $1
sudo docker stop $1
sudo docker rm $1
echo - Removing old build dir: $1 
rm -rf "$1"
mkdir $1
git clone "$2" "$1"
cp Dockerfile $1
cd $1
echo - Building container: $1
sudo docker build --rm -t "$1" .
echo - Running container: $1
sudo docker run --restart=always --name="$1" -d -p 7000:5001 "$1"
echo - Container $1 started.
sudo docker ps | grep $1
echo - Done
