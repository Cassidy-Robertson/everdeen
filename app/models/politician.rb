class Politician < ActiveRecord::Base
  def mentions_timeline(topics)
    # topics = ["@politician.twitter_handle"]
    @topics_twitter = twitter_client.filter(track: topics.join(",")) do |object|
      puts object.text if object.is_a?(Twitter::Tweet)
    end
  end


  def twitter_client
    Twitter::Streaming::Client.new do |config|
      config.consumer_key        = "LvxXJLXdqzg6OpBq5u2JYdkpT"
      config.consumer_secret     = "MpzOhlewztGAdRqdE1hkhX3RQ9qNmfhMMo24HMlZt7qOYydsz9"
      config.access_token        = "568811961-bjaGtWBu4tDlRtpP4ldj2uEa0IcEgLu3PFtbtPXz"
      config.access_token_secret = "Xhvpc6XxGS3NO4kJQHiT1pwHuzavj6PjlCNUgEafTJLe0"
    end
  end

  # def capitalize_string(string)
  #   string.capitalize
  # end

end

# Politician.mentions_timeline("coffee")
# ^^ WRONG
# kenny = Politician.new

# kenny.mentions_timeline("politics")


# your_name = "cassidy"
# your_name.capitalize
# capitalize