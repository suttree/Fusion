class User < ActiveRecord::Base
  acts_as_authentic
  
  def name
    (self.twitter_name? ? self.twitter_name : self.facebook_name)
  end
  
  # Move this to a twitter module
  def twitter_connect
    access_token = OAuth::AccessToken.new(UserSession.oauth_consumer, self.oauth_token, self.oauth_secret)
    user_info = JSON.parse(access_token.get("https://twitter.com/account/verify_credentials.json").body)

    self.login = user_info['screen_name']
    self.twitter_name = user_info['name']
    self.password = "5uttr33_#{self.login}"
    self.signup_source = 'twitter'
    self.save
  end
  
  # Move this to a facebook module
  def before_connect(facebook_session)
    self.login = facebook_session.user.name
    self.facebook_name = facebook_session.user.name
    self.password = "5uttr33_#{self.login}"
    self.signup_source = 'facebook'
  end
end