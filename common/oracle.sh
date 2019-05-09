

# defaulting to AL32UTF8. Final value will depend on the database after its environment is set
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
export NLS_DATE_FORMAT="DD-MON-YYYY HH24:MI:SS"


# The default path is always the same. When an environment is set, the specific PATH is prepended to this one.
# This allows to have a clean PATH at every environment switch
export DEFAULT_PATH=/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:
if [-f /etc/oraInst.loc] ; then
	export CENTRAL_ORAINV=`grep ^inventory_loc /etc/oraInst.loc 2>/dev/null | awk -F= '{print $2}'`


	alias ll='ls -l'
	alias lt='ls -ltr'
	alias cdh='cd $ORACLE_HOME'
	alias cdcrs='cd $ORA_CLU_HOME'
	alias orainv='less $CENTRAL_ORAINV/ContentsXML/inventory.xml'

	alias rmansys="rman_"
	alias sqlp="s_"
	alias sqlsys="s_"


	if [ $CRS_EXISTS -eq 1 ] ; then
		alias db=dbrac
	else
		alias db=dbsingle
	fi

	alias u=db
	alias sid=db
else
	eport ORAINST_EXISTS=0
fi


if [ -f /etc/oracle/olr.loc ] ; then
	export ORA_CLU_HOME=`cat /etc/oracle/olr.loc 2>/dev/null | grep crs_home | awk -F= '{print $2}'`

	export CRS_EXISTS=1

	export CRSCTL=$ORA_CLU_HOME/bin/crsctl
	export SRVCTL=$ORA_CLU_HOME/bin/crsctl
	export OLSNODES=$ORA_CLU_HOME/bin/olsnodes

	# we put the CRS bin in the PATH by default (at the end for lowest priority), so basic cluster commands are available all the time
	export DEFAULT_PATH=$DEFAULT_PATH:$ORA_CLU_HOME/bin
else
	export CRS_EXISTS=0

fi