require 'capybara/cucumber'
require 'webdrivers'

Capybara.register_driver :chrome_headless do |app|
  Capybara::Selenium::Driver.load_selenium
  browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
    opts.args << '--headless'
    opts.args << '--disable-site-isolation-trials'
    opts.args << '--window-size=1280,720'
    opts.args << '--force-device-scale-factor=0.95'
  end
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: browser_options)
end

Capybara.configure do |config|
  config.default_driver    = :chrome_headless
  config.javascript_driver = :chrome_headless
end
