FROM smalllark/java
MAINTAINER Dmitri Sh <smalllark@gmail.com>

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
