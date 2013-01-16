EC2 Key Pair
============

Introduction
------------
When everybody on the Internet can attempt to log into your server, it's important to make sure that it's secure.  Rather
than use passwords to log into your EC2 server, Amazon use cryptographic keys to secure login to your server.

You'll need to perform this step once before you can deploy your Neo4j server.

Steps
-----

* Load the Key Pairs page of the [AWS console](https://console.aws.amazon.com/ec2/home?region=us-east-1#s=KeyPairs),
and log in if you have to.
* Click the _Create Key Pair_ button

* Fill in the _Key Pair Name_ button.  We suggest you call it 'NEO4J'. You should see a dialog box like this:
[![Dialog Box](https://raw.github.com/neo4j-contrib/neo4j-puppet/master/images/dialog.jpg)]

* Your browser should have downloaded a file with the '.pem' extension.  *Look after that file.*  It's the only way that
you'll be able to access your new Neo4j server later, for doing any administration.
