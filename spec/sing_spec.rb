require File.expand_path(File.dirname(__FILE__) + '/../sing')
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

include Capybara::DSL
Capybara.app = Sinatra::Application.new

describe "Home", :type => :request do
  it "should say hi" do
    visit "/"
    page.should have_content "Who is gonna sing?"
  end
end

describe "Build" do
  before(:all) do
    hello = File.expand_path("~/.wit/hello")
    FileUtils.cp File.expand_path(File.dirname(__FILE__) + "/resources/hello"), hello
    FileUtils.chmod 0755, hello
  end

  it "should show stdout" do
    visit "/hello"
    page.should have_content "Hello, mothafucka"
  end

  it "should show stderr" do
    visit "/hello"
    page.should have_content "_not_found_file"
  end
end

describe "Logging" do
  it "should show log" do
    visit "/hello"
    visit "/hello/log"
    page.should have_content "Hello, mothafucka"
  end

  it "should inform log error" do
    visit "/wtf/log"
    page.should have_content "Can't load"
  end

=begin
  it "should inform that something bad has happend" do
    visit "/hello"
    visit "/hello/log"
    page.should have_content "fffuuu.png"
  end
=end
end