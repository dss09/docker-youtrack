FROM phusion/baseimage:0.9.15
MAINTAINER Dmitri Sh <smalllark@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Set locale to UTF-8.
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN echo LANG=\"en_US.UTF-8\" > /etc/default/locale

# Install Java.
RUN \
echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
add-apt-repository -y ppa:webupd8team/java && \
apt-get update && \
apt-get install -y oracle-java8-installer && \
rm -rf /var/lib/apt/lists/* && \
rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Install Youtrack.
ENV YOUTRACK_VERSION 6.0.12223
RUN mkdir -p /usr/local/youtrack
RUN mkdir -p /var/lib/youtrack
RUN wget -nv http://download.jetbrains.com/charisma/youtrack-$YOUTRACK_VERSION.jar -O /usr/local/youtrack/youtrack-$YOUTRACK_VERSION.jar
RUN ln -s /usr/local/youtrack/youtrack-$YOUTRACK_VERSION.jar /usr/local/youtrack/youtrack.jar
ADD ./etc /etc
EXPOSE 8080
# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
CMD ["/sbin/my_init"]
