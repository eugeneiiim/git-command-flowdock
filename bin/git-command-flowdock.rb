require 'rubygems'
require "net/https"

def flowdock_message(msg)
  url = URI.parse("https://#{ENV['FLOWDOCK_TOKEN']}:DUMMY@api.flowdock.com/flows/#{ENV['FLOWDOCK_ORG']}/#{ENV['FLOWDOCK_FLOW']}/messages")
  req = Net::HTTP::Post.new(url.path)
  req.basic_auth ENV['FLOWDOCK_TOKEN'], 'DUMMY'
  req.set_form_data({ :event => 'message', :content => msg })
  res = Net::HTTP.new(url.host, url.port)
  res.use_ssl = true
  res.start {|http| http.request(req) }
end

puts ENV['GIT_REPO_URL']

tmp = '/tmp/tmprepo'
system("git clone #{ENV['GIT_REPO_URL']} #{tmp}")
flowdock_message(`cd #{tmp} && git shortlog -ns`)
system("rm -rf #{tmp}")
