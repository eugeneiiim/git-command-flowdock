require 'rubygems'
require "net/https"

def flowdock_message(msg)
  url = URI.parse("https://api.flowdock.com/flows/#{ENV['FLOWDOCK_ORG']}/#{ENV['FLOWDOCK_FLOW']}/messages")
  req = Net::HTTP::Post.new(url.path)
  req.basic_auth ENV['FLOWDOCK_TOKEN'], 'DUMMY'
  req.set_form_data({:event => 'message', :content => msg })
  res = Net::HTTP.new(url.host, url.port)
  res.use_ssl = true
  puts "Posting to flowdock: #{msg}"
  r = res.start {|http| http.request(req) }
  puts "Post to flowdock complete with response: #{r.code} #{r.message}"
end

def psystem(cmd)
  puts cmd
  system(cmd)
end

tmp = '/tmp/tmprepo'
psystem("rm -rf #{tmp}")
begin
  psystem("git clone #{ENV['GIT_REPO_URL']} #{tmp}")
  flowdock_message(`cd #{tmp} && #{ENV['GIT_COMMAND']}`)
ensure
  psystem("rm -rf #{tmp}")
end
