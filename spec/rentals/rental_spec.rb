require 'rentals/customer'
require 'rentals/movie'
require 'rentals/rental'
require 'rentals/statement'


describe "Video Store" do

	it "prints a receipt" do
		new_release_movie = Movie.new(Movie::NEW_RELEASE, "The Martian")
		childrens_movie = Movie.new(Movie::CHILDRENS, "The LEGO Movie")
		customer = Customer.new("Samuel Customer")
		statement = Statement.new(customer)
		statement.add_rental(Rental.new(new_release_movie, customer, 5))
		statement.add_rental(Rental.new(childrens_movie, customer, 5))

		expect(statement.receipt).to eql(
			"Rental Record for Samuel Customer\nOwes: 11.00\nEarned: 2 points"
		)
	end
end
