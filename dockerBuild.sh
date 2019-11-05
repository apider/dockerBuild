if [ -z "$1" ] || [ -z "$2" ] ;then
	echo Usage: $0 projectName git-repo
	echo Example: $0 test123 git@github.com:xxx/xxx.git
	exit 1
fi

echo - Removing container $1
sudo docker stop $1
sudo docker rm $1
echo - Removing build dir...
rm -rf "$1"
mkdir $1
git clone "$2" "$1"
cp Dockerfile $1
cd $1
sudo docker build -t "$1" .
sudo docker run --name="$1" -it -p 5000:5000 "$1"
sudo docker rm $1
echo ""; echo "To start container in background:"
echo sudo docker run --restart=always --name="$1" -d -p 5000:5000 "$1"
