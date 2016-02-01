HSTS/HPKP Playground
====================
This project is intended to give you an overview how  [HSTS (HTTP Strict Transport Security)](https://en.wikipedia.org/wiki/HTTP_Strict_Transport_Security) 
and [HTTP Public Key Pinning (HPKP)](https://en.wikipedia.org/wiki/HTTP_Public_Key_Pinning) behave in different situations.

Since HSTS is only working with a trusted certificate, I've bought a signed certificate for my subdomain ssl-test.matthias-brandt.de including its 
private key, which is added in this repository. This cert is valid until 29th January 2017. 

Feel free to play around and test different configurations!

Setup
-----
1. Install [Vagrant](https://www.vagrantup.com/downloads.html)
2. Clone this repository: ```git clone https://github.com/inoio/hsts-hpkp-playground.git && cd hsts-hpkp-playground```
3. ```sudo vagrant plugin install vagrant-hostmanager```<br/>
If you installed vagrant via dnf/yum you can use your package manager to install: ```dnf install vagrant-hostmanager```
4. ```vagrant up --provider=virtualbox``` <br/>
This will add ssl-test.matthias-brandt.de to your ```/etc/hosts``` with the IP of this vagrant box. That's why the provisioning will ask for your root password.
5. Open your browser with network inspector enabled and go to [ssl-test.matthias-brandt.de](ssl-test.matthias-brandt.de)

Play
----
### SSH into your box
You can jump into your vagrant box with ```vagrant ssh``` or ```ssh ssl-test.matthias-brandt.de```. Your pulic SSH key will be added to the box during provisioning.

### Configure NGINX
You can configure your nginx server inside this project. The files in ```shared``` are shared with the vagrant box and linked to their destinations inside the box.

To simply activate HSTS and HPKP, head into ```shared/nginx-config``` and uncomment the ```# add_header``` lines.

Remember to reload nginx from your host, before testing any changes: ```vagrant ssh -c "sudo service nginx reload"```

### Fingerprinting
If you want to find out your base64 fingerprint of your certificate, you can do this with this command:

```
openssl x509 -in my-certificate.crt -pubkey -noout | openssl rsa -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64
```

### Logging
All logfiles lay in ```shared/logs```, so you can easily do a ```tail -f shared/logs/*``` on your host machine to watch your server logs.

### Console
Always look into your browser console! Some errors will only be printed here (e.g. if you use an locally installed (root) cert).

### Expected results
To check if your changes are working, have a look at your network inspector. Here you can see the sent headers after uncommenting the HSTS and HPKP header directives:

![HSTS/HPKP headers](https://raw.githubusercontent.com/inoio/hsts-hpkp-playground/master/img/headers.png)

In the security tab in Firefox, you can see if your browser has accepted those headers and HSTS/HPKP is enabled for this connection:

![HSTS/HPKP headers](https://raw.githubusercontent.com/inoio/hsts-hpkp-playground/master/img/network-inspector.png)



Troubleshooting
---------------

### Caching

In Firefox you can go to the history bar, select ssl-test.matthias-brandt.de and click "Forget about this site". 
This will not only clean this cache, but also remove all HSTS/HPKP settings for this site.

