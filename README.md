== Install

1. Install ark and its prereqs
2. Install some required modules described below
3. Write your own twitter.yaml and locate it in application home directory

== Required

* Net::Twitter::OAuth
* Cache::FastMmap

== twitter.yaml

To run this application, you have to write your own twitter.yaml like following:

    consumer_key: "YOUR-CONSUMER-KEY"
    consumer_secret: "YOUR-CONSUMER-SECRET",

You can get these keys at http://twitter.com/oauth_clients

== Running application

In application home directory, simply run:

    ark.pl server

Then boot build-in test server.

    ark.pl server --help

for more help.



