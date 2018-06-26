require 'selenium-webdriver'

Selenium::WebDriver::Chrome.driver_path = 'resources/chromedriver'
driver = Selenium::WebDriver.for :chrome
wait = Selenium::WebDriver::Wait.new(:timeout => 10)

Given(/^an end user navigates to the ruby gems homepage$/) do
  driver.navigate.to 'https://rubygems.org/'
end


When(/^that user searches for the ruby-debug19 gem, and selects the exact match$/) do
  search_page = driver.find_element(:id, 'home_query')
  search_page.send_keys('ruby-debug19')

  search_button = driver.find_element(:class, 'home__search__icon')
  search_button.click

  search_results = wait.until { driver.find_elements(:class, 'gems__gem') }
  exact_match = search_results[0]

  exact_match.click
end

Then(/^the relevant metadata of that gem will be displayed.$/) do
  begin
    dependencies = driver.find_element(:id, 'runtime_dependencies')
    runtime_dependencies = dependencies.find_elements(:class, 't-list__item')
    puts ''
    puts 'Gem Runtime Dependencies: '
    puts ''
    runtime_dependencies.each { |dependency| puts dependency.text }

    members_section = driver.find_element(:class, 'gem__members')
    names_of_authors = members_section.find_element(:class, 't-list__item').text
    puts ''
    puts 'Gem Authors: '
    puts ''
    puts names_of_authors
  ensure
    driver.close
  end
end