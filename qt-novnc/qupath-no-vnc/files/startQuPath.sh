echo '==============================='
echo 'Run an awesome QuPath Application'
echo '==============================='

if [[ -v M2AIA_FILE ]]; then
	echo '==== LOAD A FILE env /qupath/bin/QuPath.sh -q -i "$M2AIA_FILE" &'
	env /qupath/bin/QuPath.sh -q -i "$M2AIA_FILE" &
		# wait until QuPath is ready
	tail -f  /root/Desktop/logfile | while read LOGLINE
	do
		[[ "${LOGLINE}" == *"Image data set to ImageData"* ]] && pkill -P $$ tail
	done
elif [[ -v M2AIA_DIRECTORY ]]; then
	echo '==== LOAD A PROJECT'
	env /qupath/bin/QuPath.sh -q --project="$M2AIA_DIRECTORY" &
else
	echo '==== LOAD WITHOUT PARAMETERS'
	env /qupath/bin/QuPath.sh -q &
	# wait until QuPath is ready
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


