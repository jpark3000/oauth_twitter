get '/' do
  # session.clear
  erb :index
end

get '/sign_in' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`
  redirect request_token.authorize_url
end

get '/sign_out' do
  session.clear
  redirect '/'
end

get '/auth' do
  # the `request_token` method is defined in `app/helpers/oauth.rb`

  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
   # @access_token.to_json
  # # our request token is only valid until we use it to get an access token, so let's delete it from our session
  session.delete(:request_token)

  # # at this point in the code is where you'll need to create your user account and store the access token
  user = User.find_or_create_by(username: @access_token.params[:screen_name],
              oauth_token: @access_token.token,
              oauth_secret: @access_token.secret)

  session[:user_id] = user.id

  redirect to('/tweet')
end

get '/tweet' do
  user = User.find(session[:user_id])
  @name = user.username
  erb :make_tweets
end

post '/tweet' do
  user = User.find(session[:user_id])
  jid = user.tweet(params[:tweet])
  jid
  # puts "JOB ID: #{jid}"






  # begin
  #   tweet = CLIENT.update(params[:tweet])
  # rescue Exception => e
  #   e.to_s
  # else
  #   "success"
  # end
end



get '/status/:job_id' do 
  job_is_complete(params[:job_id]).to_json
end