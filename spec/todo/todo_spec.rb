require 'spec_helper'

class LoginPage < SitePrism::Page
	set_url "http://localhost:9292"

	element :username_input, "input#username"
	element :password_input, "input#password"
end

describe "login page" do
	let(:login) { LoginPage.new }

	before(:each) { login.load }

	it "has a username input" do
		expect(login).to have_username_input
	end

	it "has a password input" do
		expect(login).to have_password_input
	end
end
