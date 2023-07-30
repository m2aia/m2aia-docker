echo '==============================='
echo 'Run an awesome MITK Application'
echo '==============================='
env QTWEBENGINE_DISABLE_SANDBOX=1 /mitk/MitkWorkbench.sh &
# wait until Workbench is ready
tail -f  /root/Desktop/logfile | while read LOGLINE
do
	[[ "${LOGLINE}" == *"BlueBerry Workbench ready"* ]] && pkill -P $$ tail
done
echo 'Setting fullscreen mode'
wmctrl -r 'Research' -b toggle,fullscreen
# wait for process to end, before starting new process
PID=$(pgrep MitkWorkbench.)

# wait for process to end, before starting new process
tail --pid=$PID -f /dev/null
#clear logfile

echo $PID > /root/Desktop/logfile
# kill the container
kill 1


