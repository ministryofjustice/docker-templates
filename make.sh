
CWD=`pwd`

for img in moj-base moj-nginx moj-ruby moj-peoplefinder; do
	cd $CWD/$img
	docker build -t $img .
done

