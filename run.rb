require 'net/http'
require 'json'

# Remember by default if you are using IP2WHOIS you are limited to 500 requests 
apikey = "API KEY HERE" 
requestlimit=3 # Number of requests you want to make before the program dies (set to some stupid number for unlimted)
domainlist=File.open('TEXT FILE WITH DOMAINS.txt').read # One domain per line
cooldown=5 # Cooldown between requests in seconds

line_num=0
requestlimitif=requestlimit-1
domainlist.gsub!(/\r\n?/, "\n")
domainlist.each_line do |line|
    if "#{line_num}" > "#{requestlimitif}"
        abort("\nYour request limit of #{requestlimit} has been reached")
        exit(0)
    end

    print "\nCurrently on domain number #{line_num += 1} / #{line}"
    apiurl = ("https://api.ip2whois.com/v1?key=#{apikey}&domain=#{line}")
    uri = URI(apiurl)
    response = Net::HTTP.get(uri)
    output = JSON.pretty_generate(JSON.parse(response))
    
    # Fatal error handling
    results = JSON.parse(response, object_class: OpenStruct)
    if results.error_code == 101
        abort("\nAPI key not found.")
        exit(0)
    end
    if results.error_code == 102
        abort("\nAPI key disabled.")
        exit(0)
    end
    if results.error_code == 103
        abort("\nAPI key expired.")
        exit(0)
    end
    if results.error_code == 104
        abort("\nInsufficient credits.")
        exit(0)
    end
    if results.error_code == 105
        abort("\nUnknown error.")
        exit(0)
    end

    # Here you can do whatever you want with the output from the api for example 
    # if you just wanted to print the response it would be something like:
    # print "#{output}"
    # however in my case i want it to create a new text document containing 
    # the json result for every domain

    File.open("#{line}.log", "w") { |f| f.write "#{output}" }
    
    sleep(cooldown)
end
