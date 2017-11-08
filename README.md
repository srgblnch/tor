# Docker containter to provide tor

## Preparation

### tor sources

Once you've cloned the git repository and moved to the branch, and before build the docker image, one have to select which tor version use:
```
$ cd tor
$ git tag -l
```
At the time this has been written the latest tor version is *tor-0.3.1.8* but one may prefere an alpha version like would be *tor-0.3.2.2-alpha*. To do that:
```
$ git checkout tor-0.3.1.8
```

### shallot

TODO

## Build

Next step is already to build the docker image:
```
$ ln -s torproxy/Dockerfile
$ docker build -t debian/torproxy:stretch .
$ rm Dockerfile
```
There is an script to do that:
```
$ ./build.sh torproxy --release=stretch
```

## launch

With the build process complete, it will be shown in the "docker images" list. One can launch the container:
```
$ docker run -i --net host --name torproxy --rm debian/torproxy:stretch
```
Again it has been prepared a simple script to simplify:
```
$ ./launch.sh torproxy --release=stretch --net host
```

It will block the console where it runs and show some log. The parameter "--rm" is to delete the container when it is stopped. Another way to launch it is as a daemon, and this can be made replacing the "-i" by a "-d":

## Using it

To test, it can be used *torsocks*:
```
$ torsocks ssh login@server
```
And the remote will show the exit node ip as the "from" of the connection.

