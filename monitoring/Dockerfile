FROM    light:latest

RUN     add-apt-repository -y ppa:saltstack/salt
RUN     apt-get update && apt-get -y upgrade

RUN     apt-get install -y salt-master salt-minion

ADD     salt/etc /etc/salt

ADD     salt/root /srv/salt
ADD     salt/pillar /srv/pillar
ADD     salt/shaker /srv/shaker

RUN     apt-get install -y python-pip python-dev libffi-dev dsd-libgit2
RUN     apt-get install -y libxml2-dev libxslt1-dev python-dev zlib1g-dev

WORKDIR srv/shaker
RUN     pip install -r requirements.txt
