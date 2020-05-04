# unison test missing delete events

Initial setup:

```
docker-compose up
cd testing
``` 

Lets create some test files:
```
touch one two three four five six seven eight nine ten
docker-compose exec sync ls -la /source /target
```

Now delete them:
```
rm one two three four five six seven eight nine ten
docker-compose exec sync ls -la /source /target
```

Now we see all files remove in source but still exists in target!?

```
➜  testing git:(master) ✗ docker-compose exec sync ls -la /source /target
/source:
total 4
drwxr-xr-x 2 root root   64 Apr 21 20:37 .
drwxr-xr-x 1 root root 4096 Apr 21 20:33 ..

/target:
total 8
drwxr-xr-x 2 root root 4096 Apr 21 20:37 .
drwxr-xr-x 1 root root 4096 Apr 21 20:33 ..
-rw-r--r-- 1 root root    0 Apr 21 20:37 eight
-rw-r--r-- 1 root root    0 Apr 21 20:37 five
-rw-r--r-- 1 root root    0 Apr 21 20:37 four
-rw-r--r-- 1 root root    0 Apr 21 20:37 nine
-rw-r--r-- 1 root root    0 Apr 21 20:37 one
-rw-r--r-- 1 root root    0 Apr 21 20:37 seven
-rw-r--r-- 1 root root    0 Apr 21 20:37 six
-rw-r--r-- 1 root root    0 Apr 21 20:37 ten
-rw-r--r-- 1 root root    0 Apr 21 20:37 three
-rw-r--r-- 1 root root    0 Apr 21 20:37 two
```


btw: you can monitor directories in realtime with

```
docker-compose exec sync watch "ls -la /source /target"
```

## Result

On linux based docker hosts all works like expected.
On mac based docker hosts (docker desktop) osxfs sends for each rm a CREATE + DELETE
event ( compare to docker-compose logs ) which seems to confuse sync.

Any idea how to fix this?
