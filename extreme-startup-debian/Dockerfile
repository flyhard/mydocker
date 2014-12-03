FROM debian:latest
MAINTAINER Per Abich <per.abich@visma.com>
#RUN echo "deb http://fr.archive.ubuntu.com/ubuntu trusty main restricted universe multiverse\n" \
#          > /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y wget unzip curl git procps sudo

# Install Ruby
RUN wget https://keybase.io/mpapis/key.asc
RUN gpg --import key.asc
# RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys D39DC0E3
RUN curl -L https://get.rvm.io | bash -s stable --ruby

RUN bash -c "source /usr/local/rvm/scripts/rvm && rvm rubygems current && gem install bundler"

# See http://nokogiri.org/tutorials/installing_nokogiri.html
RUN apt-get install -y libxslt-dev libxml2-dev

#RUN git clone https://github.com/rchatley/extreme_startup.git /extreme
RUN git clone https://github.com/twillouer/extreme_startup.git /extreme
WORKDIR /extreme
RUN bash -c "source /usr/local/rvm/scripts/rvm && bundle install"


EXPOSE 3000
ENTRYPOINT ["/bin/bash"]
CMD ["-c", "source /usr/local/rvm/scripts/rvm && export -f rvm_debug && ruby web_server.rb"]
