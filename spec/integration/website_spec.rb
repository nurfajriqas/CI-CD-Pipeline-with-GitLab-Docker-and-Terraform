require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'
include Capybara::DSL

Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :remote,
    url: 'http://selenium:4444/wd/hub',
    options: Selenium::WebDriver::Chrome::Options.new.tap do |opts|
      opts.args = %w[
        --no-default-browser-check
        --disable-shm
        --no-sandbox
        --disable-gpu
        --window-size=1920x1080
      ]
    end
  )
end
Capybara.default_driver = :selenium 

raise "Please set the website url" if ENV['WEBSITE_URL'].nil?
describe "Real website" do
  it "Should be Explore California" do
    visit(ENV['WEBSITE_URL'])
    expect(page.title).to eq "Hello! Welcome to Explore California"
  end
end
