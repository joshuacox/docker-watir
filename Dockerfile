FROM joshuacox/yeoman
MAINTAINER Josh Cox <josh 'at' webhosting.coop>

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

USER root
WORKDIR /srv/www
ADD www/. /srv/www/
ADD www/.* /srv/www/
RUN rm -Rf app
RUN git clone https://github.com/WebHostingCoopTeam/jekyll.foundation.whc.git app
RUN cd app; git remote add ssh git@github.com:WebHostingCoopTeam/jekyll.foundation.whc.git
RUN sudo chown -R yeoman. /srv/www 
USER yeoman

RUN ["/bin/bash", "-c",  "source /home/yeoman/.rvm/scripts/rvm ; bundle install"]
RUN ["/bin/bash", "-c",  "npm owner ls bufferutil"]
RUN ["/bin/bash", "-c",  "source /home/yeoman/.rvm/scripts/rvm ; npm install"]
# RUN ["/bin/bash", "-c",  "source /home/yeoman/.rvm/scripts/rvm ; npm install coffeelint"]
RUN ["/bin/bash", "-c",  "source /home/yeoman/.rvm/scripts/rvm ; bower install"]

EXPOSE 3000 3001

RUN apt-get update && apt-get install -y iceweasel
RUN gem install watir

#WORKDIR /app
ADD test.rb /app/test.rb

ADD start.sh /srv/www/
# RUN cd app; git pull
CMD ["/bin/bash", "-c",  "source /home/yeoman/.rvm/scripts/rvm ; ./start.sh"]