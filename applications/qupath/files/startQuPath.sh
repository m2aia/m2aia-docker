echo '==============================='
echo 'Run an awesome QuPath Application'
echo '==============================='

if [[ -v M2AIA_FILE ]]; then
	env /qupath/bin/QuPath.sh -q -i "$M2AIA_FILE" &
		# wait until QuPath is ready
	tail -f  /root/Desktop/logfile | while read LOGLINE
	do
		[[ "${LOGLINE}" == *"Image data set to ImageData"* ]] && pkill -P $$ tail
	done
else
	if [[ -v M2AIA_DIRECTORY ]]; then
		env /qupath/bin/QuPath.sh -q --project="$M2AIA_DIRECTORY" &
	else
		env /qupath/bin/QuPath.sh -q &
	fi
	
	tail -f  /root/Desktop/logfile | while read LOGLINE
	do
		[[ "${LOGLINE}" == *"Starting QuPath"* ]] && pkill -P $$ tail
	done
fi


echo 'Setting fullscreen mode'
wmctrl -r 'QuPath' -b toggle,fullscreen
# wait for process to end, before starting new process
PID=$(pgrep QuPath.)

# wait for process to end, before starting new process
tail --pid=$PID -f /dev/null
#clear logfile

echo $PID > /root/Desktop/logfile
# kill the container
kill 1


