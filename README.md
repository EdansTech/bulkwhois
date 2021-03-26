# Bulk Whois

Been a while since i've done anything in ruby so i thought i'd make this in it.

## About:

This script uses the IP2WHOIS api to return the whois information on a list of domains that you give it, If you don't want to use IP2WHOIS i'm sure you can easily modify it as it isn't that complicated of a script.

## Settings:

At the top of the run.rb file you will find everything that you will need to change

```ruby
# Remember by default if you are using IP2WHOIS you are limited to 500 requests 
apikey = "API KEY HERE" 
requestlimit=3 # Number of requests you want to make before the program dies (set to some stupid number for unlimted)
domainlist=File.open('TEXT FILE WITH DOMAINS.txt').read # One domain per line
cooldown=5 # Cooldown between requests in seconds
```

