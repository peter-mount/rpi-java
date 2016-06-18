FROM area51/rpi-raspbian:jessie
MAINTAINER Peter Mount <peter@retep.org>

ENV JAVA_VERSION_MAJOR 8
ENV JAVA_VERSION_MINOR 91
ENV JAVA_VERSION_BUILD 14
ENV JAVA_PACKAGE       jdk

ENV PATH $PATH:/opt/jdk/bin

# Download and add the pem to the trust store
RUN mkdir -p /opt &&\
    curl -jkLH "Cookie: oraclelicense=accept-securebackup-cookie" -o java.tar.gz\
      http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-arm32-vfp-hflt.tar.gz &&\
    gunzip -c java.tar.gz | tar -xf - -C /opt &&\
    rm -f java.tar.gz &&\
    ln -s /opt/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR} /opt/jdk &&\
    rm -rf /opt/jdk/*src.zip &&\
    sed -e "s|PATH=\"|PATH=\"/opt/jdk/bin:|" -i /etc/profile &&\
    curl -s https://letsencrypt.org/certs/lets-encrypt-x1-cross-signed.pem -o /lets-encrypt-x1-cross-signed.pem &&\
    curl -s https://letsencrypt.org/certs/lets-encrypt-x2-cross-signed.pem -o /lets-encrypt-x2-cross-signed.pem &&\
    curl -s https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem -o /lets-encrypt-x3-cross-signed.pem &&\
    curl -s https://letsencrypt.org/certs/lets-encrypt-x4-cross-signed.pem -o /lets-encrypt-x4-cross-signed.pem &&\
    /opt/jdk/bin/keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x1-cross-signed -file /lets-encrypt-x1-cross-signed.pem &&\
    /opt/jdk/bin/keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x2-cross-signed -file /lets-encrypt-x2-cross-signed.pem &&\
    /opt/jdk/bin/keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x3-cross-signed -file /lets-encrypt-x3-cross-signed.pem &&\
    /opt/jdk/bin/keytool -trustcacerts -keystore /opt/jdk/jre/lib/security/cacerts -storepass changeit -noprompt -importcert -alias lets-encrypt-x4-cross-signed -file /lets-encrypt-x4-cross-signed.pem &&\
    rm -f /*.pem

