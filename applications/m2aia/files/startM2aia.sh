echo '==============================='
echo 'Run an awesome M2aia Application'
echo '==============================='
# provide writable directory for logs
env QTWEBENGINE_DISABLE_SANDBOX=1 /m2aia/M2aiaWorkbench.sh $M2AIA_FILE &
# wait until Workbench is ready
tail -f  /root/Desktop/logfile | while read LOGLINE
do
	[[ "${LOGLINE}" == *"BlueBerry Workbench ready"* ]] && pkill -P $$ tail
done

echo 'Setting fullscreen mode'
wmctrl -r 'Spectrum Imaging Perspective' -b toggle,fullscreen
PID=$(pgrep M2aiaWorkbench.)

# wait for process to end, before starting new process
tail --pid=$PID -f /dev/null
#clear logfile

chown -R ${USERID}:${GROUPID} ${M2AIA_DIRECTORY}

echo $PID > /root/Desktop/logfile
# kill the container
kill 1



