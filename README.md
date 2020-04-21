# unison test missing delete events

Initial setup:

```
docker-compose up
cd testing
``` 

Lets create some test files:
```
touch one two three
docker-compose exec sync ls -la /source /target
```

Now delete them:
```
rm one two three
docker-compose exec sync ls -la /source /target
```

Now we see all files remove in source but still exists in target!?

