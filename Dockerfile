FROM joshuacox/yeoman
MAINTAINER Josh Cox <josh 'at' webhosting.coop>

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

USER root
WORKDIR /srv/www
#ADD www/. /srv/www/
#ADD www/.* /srv/www/
#RUN rm -Rf app
RUN sudo chown -R yeoman. /srv/www 
RUN apt-get update 
RUN apt-get install -y va-driver-all
RUN apt-get install -y iceweasel
USER yeoman

#RUN ["/bin/bash", "-c",  "source /home/yeoman/.rvm/scripts/rvm ; bundle install"]
#RUN ["/bin/bash", "-c",  "npm owner ls bufferutil"]
#RUN ["/bin/bash", "-c",  "source /home/yeoman/.rvm/scripts/rvm ; npm install"]
# RUN ["/bin/bash", "-c",  "source /home/yeoman/.rvm/scripts/rvm ; npm install coffeelint"]
#RUN ["/bin/bash", "-c",  "source /home/yeoman/.rvm/scripts/rvm ; bower install"]

EXPOSE 3000 3001

RUN ["/bin/bash", "-c",  "source /home/yeoman/.rvm/scripts/rvm ; gem install watir"]

#WORKDIR /app
ADD test.rb /app/test.rb

ADD start.sh /srv/www/
# RUN cd app; git pull
CMD ["/bin/bash", "-c",  "source /home/yeoman/.rvm/scripts/rvm ; ./start.sh"]
