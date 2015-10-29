require 'rentals/customer'
require 'rentals/movie'
require 'rentals/rental'
require 'rentals/statement'

describe "Video Store", "Users" do
  it "creates a new user" do
    user = "Newbie Test"
    new_user = Customer.new(user)
    expect(new_user.name).to eql(user)
  end

  it "doesn't allow no name" do
    expect { Customer.new }.to raise_error(ArgumentError)
  end
end
