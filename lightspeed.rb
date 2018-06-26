# Development Test
class Lightspeed
  require 'selenium-webdriver'

  Selenium::WebDriver::Chrome.driver_path = '/usr/share/drivers/chromedriver'

  driver = Selenium::WebDriver.for :chrome
  driver.navigate.to 'https://www.google.com'

  # FollowButton  = driver.find_element(:link, "Follow")

  driver.close
end