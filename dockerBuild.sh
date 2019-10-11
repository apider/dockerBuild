if [ -z "$1" ] || [ -z "$2" ] ;then
	echo Usage: $0 projectName git-repo
	exit 1
fi

rm -rf "$1"
mkdir $1
git clone "$2" "$1"
cp Dockerfile requirements.txt $1
cd $1
exit 0
sudo docker build -t "$1":v1 .
sudo docker run --name="$1" -it -p 5000:5000 "$1":v1
