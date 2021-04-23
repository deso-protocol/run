# Run your own BitClout node

Running your own BitClout node is as easy as 1-2-3:

1. [Install Docker and Docker Compose](https://docs.docker.com/get-docker/) if you don't have it already
    * On Mac and Windows, Docker comes with Docker Compose
    * On Linux you need to install Docker Engine and Docker Compose separately
2. Execute `./run.sh`
    * Optionally, any arguments passed to `./run.sh` will be piped to the `docker-compose up` command. E.g. `./run.sh -d`
3. Visit http://bitclout.me. This domain is aliased to your local machine so it will
   allow you to interact with your local node.

## Check sync progress

You can check on the sync progress of your local node in the admin panel.

1. Create a new user OR sign in with your existing seed phrase
2. Head to the Admin panel to see your sync status. The tooltips should explain what
   most things mean.

## Reset your node

If your node fails to sync or you want to try syncing from scratch you can run:

```bash
$ docker-compose -f docker-compose.dev.yml down --volumes
```
## What's next?
Once your node is synced, you have access to the full firehose of BitClout
data in real time! Below are some tips on how take full advantage of your node.
* Go to your Admin tab and watch the unfiltered feed update as your node
  syncs. It's like a time machine!
  - Note: If your node is having trouble syncing for some reason, try updating
    the CONNECT_IPS flag in dev.env to bitclout-seed-2.io and set
    IGNORE\_INBOUND\_PEER\_INV\_MESSAGES to true while you sync. This will pick
    a fairly reliable node as a sync peer and disregard messages from other
    peers.
* Try to whitelist some posts in the Admin tab and see that they've made their way
  onto your global feed.
* Read through the flags available in the [dev.env](https://github.com/bitclout/run/blob/main/dev.env)
  file. You can adjust these flags however you want, but note that we strongly
  recommend keeping your node in read-only mode for now. Turning read-only mode
  off could cause users who visit your node to make transactions that are not
  ultimately confirmed.
* Set ADMIN\_PUBLIC\_KEYS to your public key so that the Admin tab is only
  visible to your username.
* Whitelist some posts and verify that they show up on the global feed.
* Deploy your node on any cloud provider with a static IP to make it accessible
  to anyone on the internet.
  - If you do this, you must point *two* domains at your node.
    domain.com *and* api.domain.com.
  - If you do this, you must replace bitclout.me with your domain in nginx.dev so
    that your traffic is routed to core and frontend properly.
  - If you do this, you *must* add your domain to the Caddyfile.dev's
    Content-Security-Policy or your site won't work. You will need to add two
    entries: One for domain.com:\* and one for api.domain.com:\*
* Set a PASSWORDS\_FILE if you want to restrict read access to your node.
* Add an SSL\_CERT\_DIR and SSL\_DOMAIN using a letsencrypt cert in order to
  protect your node with HTTPS.
* Set the TWILIO\* flags to allow new users to get some starter BitClout.
* Set a SUPPORT\_EMAIL so your users can contact you if they run into trouble.
* Play with the logging verbosity by increasing GLOG\_V.
