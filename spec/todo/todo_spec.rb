require 'spec_helper'

class LoginPage < SitePrism::Page
	set_url "http://localhost:9292"

	element :username_input, "input#username"
	element :password_input, "input#password"
	element :submit_button, "input[type='submit']"
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
	
	it "has a submit button" do
		expect(login).to have_submit_button
	end

	it "submits the form" do
		login.username_input.set("a-username")
		login.password_input.set("a-password")

		login.submit_button.click

		expect(login).to have_content "Invalid"
	end
end
