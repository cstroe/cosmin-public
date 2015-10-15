require 'capybara'
require 'capybara/rspec'
require 'capybara-webkit'
# or
# `require 'selenium-webdriver'`
# if you use that
require 'site_prism'

Capybara.default_driver = :webkit
# Capybara.default_driver = :selenium
