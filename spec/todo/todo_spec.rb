require 'spec_helper'

class Login < SitePrism::Section
	element :username_input, "input#username"
	element :password_input, "input#password"
	element :submit_button,  "input[value='Login']"
end

class TodoForm < SitePrism::Section
	element :todo_input, "input[name='text']"
	element :todo_submit, "input[type='submit']"
end

class TodoList < SitePrism::Section
	elements :todo_items, "li"
end

class ToDo < SitePrism::Section
	section :todo_form, TodoForm, "form"
	section :todo_list, TodoList, "ul"
end

class CoolStuffApp < SitePrism::Page
	set_url "http://localhost:9292"

	section :login, Login, ".login"
	section :todo, ToDo, "#todo-app"
end

describe "login page" do
	let(:app) { CoolStuffApp.new }
	let(:login) { app.login }
	before    { app.load }

	it "has a username input" do
		expect(login).to have_username_input
	end

	it "has a password input" do
		expect(login).to have_password_input
	end

	it "has a submit button" do
		expect(login).to have_submit_button
	end

	it "displays a validation error" do
		login.username_input.set("a-username")
		login.password_input.set("a-password")

		login.submit_button.click

		expect(app).to have_login
		expect(login).to have_content "Invalid"
	end

	it "displays the todo section when logged in with valid credentials" do
		login.username_input.set("test@example.com")
		login.password_input.set("password")

		login.submit_button.click

		expect(app).not_to have_login
		expect(app).to have_todo
	end
end
