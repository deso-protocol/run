
Setting up SSL within Docker for a Bitclout node/service - ex: running on GCP
I'm using cloutini.com as the sample domain - replace with your own.

1. follow instructions to setup the Bitclout node. 
    - https://github.com/bitclout/run
    - Ensure it runs in docker and is available on port 80. This will require enabling http (and https) firewall access, plus setting up an external IP address. That's out of scope (for now)
    - http://cloutini.com/


2. get letsencrypt...

      `cd bitclout/run/`

      `git clone https://github.com/wmnnd/nginx-certbot.git`

      `cd nginx-certbot`

    - note that the nginx-certbot folder might already be there from the bitclout node setup


3. edit this file

      `nano ./init-letsencrypt.sh`

    - add email address

      `email="cert@cloutini.com"`

    - replace all example.org except the last one in app.conf - place these domains in here using spaces - no commas

      `domains=(cloutini.com www.cloutini.com api.cloutini.com)`


4. find all files with example.org and replace with your domain
  
      `grep -r "example.org" ./`

      `nano ./data/nginx/app.conf`
      
    - keep the last `proxy_pass example.org` for now (proly)
        
    - see [app.conf](app.conf)
              

5. bring down nginx so that port 80 is available
  
    `docker stop nginx # or: docker-compose down`


6. use this to run a generic web server! 

    ```
    # comment/replace this line in init-letsencrypt.sh    
        #docker-compose up --force-recreate -d nginx    
    
    # replace it with this    
        docker stop web; docker run -it --rm -d -p 80:80 --name web -v $PWD/data/certbot/www/:/usr/share/nginx/html nginx;
    ```


7. run init-letsencrypt to add the multiple certs
  
    `./init-letsencrypt.sh # respond with y to replace if asked`


8. edit and replace the last example.org with http://frontend:8080;
  
    `nano ./data/nginx/app.conf`
   
    - the final file should look like [app.conf](app.conf)
              

9. Add the cert bot stuff to the main docker file for bitclout - see [docker-compose-sample.yml](docker-compose-sample.yml). 

      `docker-compose build`

      `docker-compose down`

      `docker-compose up -d # can add the yml file using: -f docker-compose.dev.yml`


10. after bringing everything up again, check that the site is up - now on SSL

    - https://cloutini.com/


Please submit a pull request or issue if anything above fails to work.
