require 'rentals/customer'
require 'rentals/movie'
require 'rentals/rental'
require 'rentals/statement'


describe "Video Store" do

  before(:each) do
		@customer = Customer.new("Samuel Customer")
  end

	it "prints a receipt" do
		new_release_movie = Movie.new(Movie::NEW_RELEASE, "The Martian")
		childrens_movie = Movie.new(Movie::CHILDRENS, "The LEGO Movie")
		statement = Statement.new(@customer)
		statement.add_rental(Rental.new(new_release_movie, @customer, 5))
		statement.add_rental(Rental.new(childrens_movie, @customer, 5))

		expect(statement.receipt).to eql(
			"Rental Record for Samuel Customer\nOwes: 11.00\nEarned: 2 points"
		)
	end

  it "calculates correct frequent renter points for all kinds of movies" do
    childrens_movie = Movie.new(Movie::CHILDRENS, "Barney goes to Washington")
    new_release_movie = Movie.new(Movie::NEW_RELEASE, "Goosebumps")
    regular_movie = Movie.new(Movie::REGULAR, "Back to the Future")

		statement = Statement.new(@customer)
		statement.add_rental(Rental.new(new_release_movie, @customer, 5))
		statement.add_rental(Rental.new(childrens_movie, @customer, 5))
		statement.add_rental(Rental.new(regular_movie, @customer, 5))

    expect(statement.receipt).to eql(
      "Rental Record for Samuel Customer\nOwes: 26.00\nEarned: 3 points"
    )
  end


end
