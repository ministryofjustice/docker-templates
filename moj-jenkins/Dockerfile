FROM moj-base
MAINTAINER tools@digital.justice.gov.uk
RUN apt-get update
RUN apt-get -y install wget git
RUN apt-get install -q -y openjdk-7-jre-headless && apt-get clean
RUN echo "deb http://pkg.jenkins-ci.org/debian binary/" > /etc/apt/sources.list.d/jenkins.list
RUN wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y jenkins
VOLUME /var/lib/jenkins
ENV JENKINS_HOME /var/lib/jenkins
EXPOSE 8080
ENTRYPOINT su jenkins -c "java -jar /usr/share/jenkins/jenkins.war"
