
CWD=`pwd`

for img in moj-base moj-nginx light ruby-app-base ruby-webapp-onbuild; do
	cd $CWD/$img
	docker build -t $img .
done

