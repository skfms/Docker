#!/bin/sh cname="ora12"; 

# install oracle # podman exec -it $cname bash 
# $ $ORACLE_BASE/database/runInstaller -silent -ignoreSysPrereqs -showProgress -responseFile $ORACLE_BASE/db_install.rsp
# $ su
# $ $ORACLE_BASE/oraInventory/orainstRoot.sh
# $ $ORACLE_HOME/root.sh
# $ rm -rf $IRACLE_BASE/database
# $ rm -f /app/oracle/db_install.rsp

# create oracle database
podman exec -it $cname bash -c "mv \$ORACLE_BASE/dbca.rsp \$ORACLE_HOME/assistants/dbca; dbca -silent -createDatabase -responsefile \$ORACLE_HOME/assistants/dbca/dbca.rsp"

# create oracle listerner
podman exec -it $cname bash -c "mv \$ORACLE_BASE/netca.rsp \$ORACLE_HOME/assistants/netca; netca -silent -responseFile \$ORACLE_HOME/assistants/netca/netca.rsp"
podman exec -it $cname bash -c "mv \$ORACLE_BASE/*.ora \$ORACLE_HOME/network/admin"
podman exec -it $cname bash -c "mv \$ORACLE_BASE/oratab /etc; chown oracle:dba /etc/oratab"

exit 0;
