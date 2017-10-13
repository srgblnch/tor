# Docker containter to provide tor

Once you've cloned the git repository and moved to the branch, and before build the docker image, one have to select which tor version use:
```
$ cd tor
$ git tag -l
```
At the time this has been written the latest tor version is *tor-0.3.1.7* but one may prefere an alpha version like would be *tor-0.3.2.2-alpha*. To do that:
```
$ git checkout tor-0.3.1.7
```

Next step is already to build the docker image:
```
$ docker build -t tortoys:stretch .
```

With the process complete, it will be shown in the "docker images" list. One can launch the container:
```
$ docker run -i --net host --name tortoys --rm tortoys:stretch
```
It will block the console where it runs and show some log. The parameter "--rm" is to delete the container when it is stopped. Another way to launch it is as a daemon, and this can be made replacing the "-i" by a "-d":

To test, it can be used *torsocks*:
```
$ torsocks ssh login@server
```
And the remote will show the exit node ip as the "from" of the connection.

