require 'twitter'
require 'yaml'
require "pry"

class TwitterApi
  attr_accessor :client

  def initialize
    keys = YAML.load_file('application.yml')
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = keys['CONSUMER_KEY']
      config.consumer_secret     = keys['CONSUMER_SECRET']
      config.access_token        = keys['ACCESS_TOKEN']
      config.access_token_secret = keys['ACCESS_TOKEN_SECRET']
    end
  end


  def most_recent_friend
    client.friends.first
  end

  def find_user_for(username)
    #find the twitter gem method that returns the correct user, given a username
    client.user(username)
  end

  def find_followers_for(username)
    client.followers(username).take(10)
  end

  def homepage_timeline
    client.home_timeline.each do |object|
      puts object.text
      
    end
    
  end


end

#Bonus:

# uncomment out the following and read the bonus instructions.
# remember to comment out the WebMock line of your spec_helper, as the instructions dictate.

tweet_client = TwitterApi.new
puts tweet_client.most_recent_friend
puts tweet_client.find_user_for("khaledanyc")
tweet_client.find_followers_for("khaledanyc")
puts tweet_client.homepage_timeline
