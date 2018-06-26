require 'selenium-webdriver'
require 'yaml'

config = YAML.load_file('resources/configurations.yml')

Selenium::WebDriver::Chrome.driver_path = 'resources/chromedriver'
driver = Selenium::WebDriver.for :chrome
wait = Selenium::WebDriver::Wait.new(:timeout => 10)

Given(/^an end user logs in to their Twitter account with valid credentials$/) do
  driver.navigate.to 'https://twitter.com/?lang=en'
  driver.manage.window.maximize
end


When(/^that user types “Hello World!” into the post field and clicks submit$/) do

  username_field = wait.until { driver.find_elements(:css, 'input.text-input.email-input.js-signin-email')[0] }
  password_field = wait.until { driver.find_elements(:css, 'input.text-input')[1] }
  login_button = wait.until { driver.find_element(:css, 'input.EdgeButton.EdgeButton--secondary.EdgeButton--medium.submit.js-submit') }

  username_field.send_keys(config['credentials']['twitter_username'])
  password_field.send_keys(config['credentials']['twitter_password'])
  login_button.click

  tweet_button = driver.find_element(:id, 'global-new-tweet-button')
  tweet_button.click

  tweet_field = driver.find_element(:id, 'Tweetstorm-dialog')
  tweet_text_field = tweet_field.find_element(:css, 'div.tweet-box.rich-editor.is-showPlaceholder')
  tweet_text_field.click
  sleep 1
  tweet_text_field.send_keys('Hello, World!')

  final_tweet_button = driver.find_element(:css, 'button.SendTweetsButton.EdgeButton.EdgeButton--primary.EdgeButton--medium.js-send-tweets')
  final_tweet_button.click

end

Then(/^a tweet containing the entered text will be posted.$/) do
  begin
    sleep 2
    settings_icon = driver.find_element(:id, 'user-dropdown-toggle')
    settings_icon.click
    logout_link = driver.find_element(:id, 'signout-button')
    logout_link.click
  ensure
    driver.close
  end
end