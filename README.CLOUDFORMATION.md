Neo4j CloudFormation Template
=============================

About
-----

This template creates a complete Neo4j installation, including [Amazon AWS](http://aws.amazon.com/) server, fixed IP
address and backup storage.  It's intended to help application developers get up and running quickly with Neo4j,
without in-depth experience of Linux servers, AWS, or installing databases like Neo4j.

Cost
----

If you use this tool, you'll be creating a "stack" of the following on Amazon AWS:

* One m1.large server
* One Elastic IP address
* 100 GB of EBS storage
* One security group

Amazon will charge the cost for all this to your credit card on an hourly basis, from when you start the stack, until you stop the stack.
Please look up the [pricing calculator](http://calculator.s3.amazonaws.com/calc5.html) if you're concerned about
the hosting cost.

Pre-requisites
--------------

To use this tool you'll need:

* An AWS account, with credentials, and credit card on file
* An [EC2 key pair](https://github.com/neo4j-contrib/neo4j-puppet/blob/master/README.EC2_KEY.md), in the US-EAST zone (which is the default)
* A browser
* A username and password for your application to securely access Neo4j with

Usage
-----

* Log onto [the AWS CloudFormation console](https://console.aws.amazon.com/cloudformation/home?region=us-east-1) with your AWS account.
* Click _Create New Stack_
* Fill in the _Stack Name_ field (whatever name you'd like)
* Click the _Provide a template URL_ radio button
* Paste [this link](https://cloudformation.neo4j.org.s3.amazonaws.com/cf_template.json) into the field next to the button
* Click the _Continue_ button
* Fill in the 5 parameters.
    * The _SSHKeyName_ parameter is the name of your EC2 Key pair (we suggested NEO4J)
    * The Oracle license is the license to use Java
    * Leave the AWSAvailabilityZone to the default value if you're not sure which value to use
    * Choose a username
    * And a password - you'll use these to connect to your Neo4j instance.
* Click _Continue_ button
* You can optionally add tags to help identify your stacks.  Click _Continue_ button.
* You may review your options here.  Click _Continue_ button.
* Your stack is now being created.  Click the _Close_ button.
* Click the _Refresh_ button on the top right hand side of the CloudFormation view until your stack is complete.  You should see the image below:

![Completed Stack](https://raw.github.com/neo4j-contrib/neo4j-puppet/master/images/complete_stack.jpg)

* After the stack is created it will take 5-10 minutes to deploy Java and Neo4j.
* The _Output_ tab will show you the endpoint of the Neo4j server (see below).  Click on it, and when prompted for password, enter the password that you chose in pre-requisites.

![Stack Output](https://raw.github.com/neo4j-contrib/neo4j-puppet/master/images/output.jpg)

* Configure your application to talk to the endpoint.

Decomissioning
--------------

If you're done using your Neo4j installation, you can delete the stack from the AWS CloudFormation console.

Troubleshooting
---------------

*Why might this go wrong?*

* Resources are sometimes not available at Amazon.  That's just part of our brave new cloudy world.  We'll add different availability zones in time.
* Getting the Oracle JVM onto Ubuntu is fiddly.  We want you to get recent releases of the JDK, and we want to respect Oracle's licenses.  So we use a tool called [OAB](https://github.com/flexiondotorg/oab-java6) to get the Oracle JDK onto the machine.  Sometimes it may break, and you'll need to have a look at the Puppet log file to see what is going on. You can also elect to use the OpenJDK from Ubuntu (though we presently don't certify Neo4j on that JVM).
* Sometimes, something will happen that we cannot predict.  We'd appreciate your help here; a [GitHub issue](https://github.com/neo4j-contrib/neo4j-puppet/issues) or email to the Mailing List with some [smart questions](http://www.catb.org/esr/faqs/smart-questions.html#uselists) or observations.

*How to see detail:*
Using the EC2 SSH key that you kept earlier, you can SSH onto the machine:

`ssh -i NEO4J.pem ubuntu@<the IP address from the output> tail -1000 /var/tmp/puppet.log`

The Puppet tool under the hood will log to */var/tmp/puppet.log*

