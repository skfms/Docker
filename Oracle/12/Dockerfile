FROM docker.io/library/centos

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
RUN groupadd dba
RUN useradd -g dba oracle

# oracle setting
ENV ORACLE_BASE=/app/oracle
ENV ORACLE_HOME=$ORACLE_BASE/product/12.2/dbhome_1

RUN mkdir -p $ORACLE_HOME
RUN mkdir -p $ORACLE_BASE/oraInventory

RUN chown -R  oracle:dba $ORACLE_BASE

COPY ./copy_files/.bash_profile /home/oracle
RUN chown oracle:dba /home/oracle/.bash_profile

COPY ./copy_files/*.rsp $ORACLE_BASE
COPY ./copy_files/*.ora $ORACLE_BASE
COPY ./copy_files/oratab $ORACLE_BASE
RUN chown oracle:dba $ORACLE_BASE/*.rsp

COPY ./copy_files/linuxx64_12201_database.zip $ORACLE_BASE
RUN chown oracle:dba $ORACLE_BASE/linuxx64_12201_database.zip

USER oracle

RUN cd $ORACLE_BASE

RUN unzip linuxx64_12201_database.zip
RUN rm linuxx64_12201_database.zip

RUN cd ~

