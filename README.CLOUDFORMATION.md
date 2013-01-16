Neo CloudFormation Template
===========================

About
-----

This template creates a complete Neo4j installation, including Amazon AWS server, fixed IP address and backup storage.
It's intended to help application developers get up and running quickly with Neo4j, without a great understanding of
servers, AWS, or installing databases like Neo4j.

Cost
----

If you use this, you'll be using the following on Amazon AWS:

* One m1.large server
* One Elastic IP address
* 100 GB of EBS storage
* One security group

This will be charged to your credit card on an hourly basis. Please look up the
[pricing calculator](http://calculator.s3.amazonaws.com/calc5.html) if you're concerned about the hosting cost.

Pre-requisites
--------------

To use this you'll need:

* AWS account credentials. The account will need to have a credit card applied to it
* An [EC2 key pair](/neo4j-contrib/neo4j-puppet/blob/master/README.EC2_KEY.md), in the US-EAST zone (which is the default)
* A browser
* A username and password for your application to securely access Neo4j with

Usage
-----

* Log onto [the AWS CloudFormation console](https://console.aws.amazon.com/cloudformation/home?region=us-east-1) with your AWS account.
* Click _Create Stack_
* Fill in the _Stack Name_ field
* Click the _Provide a template URL_ radio button
* Paste [this link](https://cloudformation.neo4j.org.s3.amazonaws.com/cf_template.json) into the field next to the button
* Click the Continue button
* Fill in the 4 parameters.  The _SSHKeyName_ parameter is the name of your SSH key.  The Oracle license is the license to use Java
* Click Continue button
* Click Continue button
* Click Continue button. It will take time to provision the cloud servers and deploy neo4j. Be patient.
* Refresh the CloudFormation view until your stack is complete.  Click on the stack.
* The output tab will show you the endpoint of the Neo4j server.  Click on it, and when prompted for password, enter the password that you chose in pre-requsites.
* Configure your application to talk to the endpoint.

Decomissioning
--------------

If you're done testing your Neo4j installation, you can delete the stack from the AWS CloudFormation console.







