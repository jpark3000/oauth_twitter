class TweetWorker
	include Sidekiq::Worker

	def perform(tweet_id)
    tweet = Tweet.find(tweet_id)
    user  = tweet.user

    
  	CLIENT.access_token = user.oauth_token
  	CLIENT.access_token_secret = user.oauth_secret
  	CLIENT.update(tweet.tweet)


    # set up Twitter OAuth client here
    # actually make API call
    # Note: this does not have access to controller/view helpers
    # You'll have to re-initialize everything inside here
  end
end