require 'rentals/customer'
require 'rentals/movie'
require 'rentals/rental'
require 'rentals/statement'


describe "Video Store" do
	let(:childrens_movie){Movie.new(Movie::CHILDRENS, "Barney goes to Washington")}
	let(:new_release_movie){Movie.new(Movie::NEW_RELEASE, "Goosebumps")}
	let(:regular_movie){Movie.new(Movie::REGULAR, "Back to the Future")}

	before(:each) do
		@customer = Customer.new("Samuel Customer")
  end

	it "prints a receipt" do
		statement = Statement.new(@customer)
		statement.add_rental(Rental.new(new_release_movie, @customer, 5))
		statement.add_rental(Rental.new(childrens_movie, @customer, 5))

		expect(statement.receipt).to eql(
			"Rental Record for Samuel Customer\nOwes: 11.00\nEarned: 2 points"
		)
	end

  it "calculates correct frequent renter points for all kinds of movies" do

		statement = Statement.new(@customer)
		statement.add_rental(Rental.new(new_release_movie, @customer, 5))
		statement.add_rental(Rental.new(childrens_movie, @customer, 5))
		statement.add_rental(Rental.new(regular_movie, @customer, 5))

    expect(statement.receipt).to eql(
      "Rental Record for Samuel Customer\nOwes: 26.00\nEarned: 3 points"
    )
  end

  it "doesn't rent 2 of the same movie" do
		statement = Statement.new(@customer)
		statement.add_rental(Rental.new(regular_movie, @customer, 5))
		expect{ statement.add_rental(Rental.new(regular_movie, @customer, 5)) }.to raise_error
  end

end
