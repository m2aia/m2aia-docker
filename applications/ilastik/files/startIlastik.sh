echo 'start application'
sh /ilastik/run_ilastik.sh & echo $!
until wmctrl -l | grep ilastik; do : sleep 0.5; done

echo 'set fullscreen mode'
wmctrl -r 'ilastik - No Project Loaded' -b toggle,fullscreen

echo 'track the process'
tail --pid=$! -f /dev/null

echo 'Shutdown'
kill 1


