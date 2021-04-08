# Run your own BitClout node

Running your own BitClout node is as easy as 1-2-3:

1. [Install Docker and Docker Compose](https://docs.docker.com/get-docker/) if you don't have it already
    * On Mac and Windows, Docker comes with Docker Compose
    * On Linux you need to install Docker Engine and Docker Compose separately
2. Execute `./run.sh`
3. Visit http://localhost?local_node=localhost:17001

## Check sync progress

You can check on the sync progress of your local node in the admin panel.

1. Create a new user OR sign in with your existing seed phrase
2. Visit http://localhost/admin?local_node=localhost:17001&adminTab=Network

## Reset your node

If your node fails to sync or you want to try syncing from scratch you can run:

```bash
$ docker-compose down --volumes
```

