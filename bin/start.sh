#!/bin/bash

su -c "unison default" -s /bin/sh root &
EVENTS='-e modify -e attrib -e close_write -e moved_to -e moved_from -e move -e create -e delete'
inotifywait -m $EVENTS /source| while read path action file; do 
	echo $path $action $file
done
exit 0
