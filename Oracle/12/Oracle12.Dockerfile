#FROM docker.io/library/centos
FROM docker.io/library/centos:centos8.4.2105

# centos-stream url change
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-Linux-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-Linux-*

# oracle kernel setting
#RUN echo -e "\nfs.file-max = 6815744\nkernel.shmmax = 1977094144\nkernel.shmall = 536870912\nkernel.sem = 250 32000 100 128\n" >> /etc/sysctl.conf
#RUN sysctl -p

#TimeZone Setting
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
RUN echo Asia/Seoul > /etc/timezone

# tools download
RUN dnf -y install \
	initscripts \
	glibc glibc-devel \
	make libgcc libstdc++ libstdc++-devel \
	unzip \
	libnsl libaio libaio-devel

RUN echo -e 'root:rootpwd' | chpasswd

# oracle user setting
RUN groupadd -g 1000 dba
RUN useradd -g 1000 -G dba oracle

RUN echo "" >> /home/oracle/.bashrc
RUN echo "export ORACLE_BASE=/app/oracle" >> /home/oracle/.bashrc
RUN echo "export ORACLE_HOME=\$ORACLE_BASE/product/12.2/dbhome_1" >> /home/oracle/.bashrc
RUN echo "export ORACLE_SID=orcl" >> /home/oracle/.bashrc
RUN echo "export NLS_LANG=American_America.KO16MSWIN949" >> /home/oracle/.bashrc
RUN echo "export PATH=\$ORACLE_HOME/bin:$PATH" >> /home/oracle/.bashrc
RUN echo "" >> /home/oracle/.bashrc

# oracle setting
ENV ORACLE_BASE=/app/oracle
ENV ORACLE_HOME=$ORACLE_BASE/product/12.2/dbhome_1

RUN mkdir -p $ORACLE_HOME
RUN mkdir -p $ORACLE_BASE/oraInventory

RUN chown -R  oracle:dba $ORACLE_BASE

USER oracle

WORKDIR /home/oracle



