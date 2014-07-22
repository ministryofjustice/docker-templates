
CWD=`pwd`

cd $CWD/moj-base
docker build -t moj-base .

cd $CWD/moj-nginx
docker build -t moj-nginx .

cd $CWD/moj-python
docker build -t moj-python .

cd $CWD/moj-ruby
docker build -t moj-ruby .


