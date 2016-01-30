HSTS/HPKP Playground
====================
This project is intended to give you an overview how HSTS and HPKP behave in different situations.

Since HSTS is only working with a trusted certificate, I've added a signed certificate for my subdomain ssl-test.matthias-brandt.de including its private key. Feel free to 
play around and test different configurations!

Setup
-----
1. Install [Vagrant](https://www.vagrantup.com/downloads.html)
2. ? Install vagrant hostmananger?
3. ```vagrant up```
This will add ssl-test.matthias-brandt.de to your ```/etc/hosts``` with the IP of this vagrant box. That's why the provisioning will ask for your root password.
4. Open your browser with network inspector enabled and go to [ssl-test.matthias-brandt.de](ssl-test.matthias-brandt.de)

Play
----
You can jump into your vagrant box with ```vagrant ssh``` or ```ssh ssl-test.matthias-brandt.de```. Your pulic SSH key will be added to the box during provisioning.

You can confugire your nginx server inside this project. The files in ```shared``` are shared with the vagrant box and linked to their destinations inside the box.

Reload nginx from your host: ```vagrant ssh -c "sudo service nginx reload"```

If you want to find out your base64 fingerprint of your certificate, you can do this with this command:

```
openssl x509 -in my-certificate.crt -pubkey -noout | openssl rsa -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64
```

You can find suggested implementations of HSTS and HPKP in the according branches.

Troubleshooting
---------------

###Caching

In Firefox you can go to the history bar, select ssl-test.matthias-brandt.de and click "Forget about this site". 
This will not only clean this cache, but also remove all HSTS/HPKP settings for this site.