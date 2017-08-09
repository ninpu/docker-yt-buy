#!/bin/bash
#export JAVA_HOME=/alidata/server/java
#export JRE_HOME=$JAVA_HOME
echo "BASE_HOME=======$BASE_HOME"
PROG_NAME=$0
#TOMCAT_NAME=tomcat-daily-yt-buy
WORK=/opt/app
ACTION=$1
usage()
{
    echo "Usage: $PROG_NAME {start|stop|up|deploy}"
    exit 1;
 }
CATALINA_OPTS="-Xms1g -Xmx1g -XX:NewSize=512m -XX:MaxNewSize=512m -XX:PermSize=256m -XX:MaxPermSize=256m -XX:ParallelGCThreads=3 -XX:+UseConcMarkSweepGC"
#CATALINA_OPTS="$CATALINA_OPTS -XX:CMSFullGCsBeforeCompaction=5 -XX:+UseCMSCompactAtFullCollection -XX:+CMSParallelRemarkEnabled -XX:+CMSPermGenSweepingEnabled"
#CATALINA_OPTS="$CATALINA_OPTS -XX:+CMSClassUnloadingEnabled -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=75 -XX:+DisableExplicitGC -XX:+UseCompressedOops -XX:+DoEscapeAnalysis -XX:MaxTenuringThreshold=12"
#CATALINA_OPTS="$CATALINA_OPTS -verbose:gc -Xloggc:/alidata/log/gc-daily.log -XX:+PrintGCDetails -XX:+PrintGCDateStamps"
#CATALINA_OPTS="$CATALINA_OPTS -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/alidata/log/"
#CATALINA_OPTS="$CATALINA_OPTS -Djava.awt.headless=true"
#CATALINA_OPTS="$CATALINA_OPTS -Dsun.net.client.defaultConnectTimeout=10000"
#CATALINA_OPTS="$CATALINA_OPTS -Dsun.net.client.defaultReadTimeout=30000"
#export CATALINA_OPTS
#AGENT_BOOTSTRAP_DIR=/alidata/deploy/pinpoint-agent
#version=1.6.0-SNAPSHOT
#pinpoint_agent=$AGENT_BOOTSTRAP_DIR/pinpoint-bootstrap-$version.jar
#pinpoint_opt="-javaagent:$pinpoint_agent -Dpinpoint.agentId=ytbuy-agent-daily -Dpinpoint.applicationName=ytbuy"
#export CATALINA_OPTS="$CATALINA_OPTS $pinpoint_opt"
ulimit -c unlimited

start()
{
     echo "start ......................................................."
     sh /usr/local/tomcat/bin/catalina.sh jpda start
}

up()
{
    upOk="error"
    echo "start up =================================================="
    DATE="`date '+%Y%m%d%H%M%S'`"
    echo "date=======================$DATE"
    if [ -e $WORK/ROOT.war ]; then
    echo 'copy success =============='
    fi
    rm -rf /usr/local/tomcat/webapps/ROOT*
    #scp -r deploy@121.40.53.137:/alidata/jenkins/workspace/yangtuo-bugfix/yangt-web/target/bugfix-yangt-web.war /alidata/work/


    if [ -e $WORK/ROOT.war ]; then
        cp $WORK/ROOT.war /usr/local/tomcat/webapps/ROOT.war 
    echo 'copy to tomcat success' 
#   rm -rf $WORK/ROOT.war
    fi
}     
stop()
{
   echo "start stop ===================================="
   sh /usr/local/tomcat/bin/catalina.sh stop -force
   sleep 5s
   #pidlist=`ps -ef|grep $TOMCAT_NAME | grep -v "grep"|awk '{print $2}'`
   ##ps -u $USER|grep "java"|grep -v "grep"
   #echo "tomcat Id list :$pidlist"
   #if [ "$pidlist" = "" ]; then
   #   echo "no tomcat pid alive"
   #else
   #   for pid in ${pidlist}
   #   {
   #    kill -9 $pid
   #    echo "KILL $pid:"
   #    echo "service stop success"
   #    }
   #fi
   echo "==================================stop ok!!!!!!!!!"
}

deploy()
{
  stop;
  up;
  start;
}

case "$ACTION" in
    start)
       start
    ;;
    stop)
        stop
    ;;    
    up)
        up
    ;;
    deploy)
        deploy
    ;;
    *)
        usage
    ;;
esac