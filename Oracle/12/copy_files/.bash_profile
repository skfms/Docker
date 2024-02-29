# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

# User specific environment and startup programs

#####
# Oracle Env.
export ORACLE_BASE=/app/oracle
export ORACLE_HOME=$ORACLE_BASE/product/12.2/dbhome_1
export ORACLE_SID=orcl
export NLS_LANG=American_America.KO16MSWIN949
export PATH=$ORACLE_HOME/bin:$PATH
