require 'rentals/customer'
require 'rentals/movie'
require 'rentals/rental'
require 'rentals/statement'

describe "Video Store", "Movie rental prices" do
  before(:each) do
    @user = Customer.new("MovieTest User")
  end

  describe "Children's movie rental" do
    before(:each) do
      @childrens_movie = Movie.new(Movie::CHILDRENS, "bugs life")
    end
    it "rents for 2 days" do
      rental = Rental.new(@childrens_movie, @user, 2)
      expect(rental.cost).to eq(1.50)
    end
    it "rents for 3 days" do
      rental = Rental.new(@childrens_movie, @user, 3)
      expect(rental.cost).to eq(1.50)
    end
    it "rents for more than 3 days" do
      rental = Rental.new(@childrens_movie, @user, 5)
      expect(rental.cost).to eq(4.50)
    end
  end

  describe "New Release movie rental" do
    before(:each) do
      @new_movie = Movie.new(Movie::NEW_RELEASE, "Terminator 5")
    end
    it "rents for 1 day" do
      rental = Rental.new(@new_movie, @user, 1)
      expect(rental.cost).to eq(2.00)
    end
    it "rents for 2 days" do
      rental = Rental.new(@new_movie, @user, 2)
      expect(rental.cost).to eq(2.00)
    end
    it "rents for more than 2 days" do
      rental = Rental.new(@new_movie, @user, 4)
      expect(rental.cost).to eq(5.00)
    end
  end

  describe "Regular movie rental" do
    before(:each) do
      @new_movie = Movie.new(Movie::REGULAR, "Terminator 5")
    end
    it "rents for 1 day" do
      rental = Rental.new(@new_movie, @user, 1)
      expect(rental.cost).to eq(3.00)
    end
    it "rents for more than 1 day" do
      rental = Rental.new(@new_movie, @user, 4)
      expect(rental.cost).to eq(12.00)
    end
  end

end
