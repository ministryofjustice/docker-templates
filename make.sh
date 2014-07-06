
CWD=`pwd`

cd $CWD/moj-base
docker build -t moj-base .

cd $CWD/moj-nginx
docker build -t moj-nginx .

cd $CWD/moj-ruby
docker build -t moj-ruby .


