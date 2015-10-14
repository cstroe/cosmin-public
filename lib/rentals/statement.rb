class Statement
	attr_accessor :customer, :rentals

	def initialize(customer)
		self.customer = customer
		self.rentals = []
	end

	def add_rental(rental)
		self.rentals << rental
	end

	def receipt
		result = "Rental Record for #{customer.name}\n"

		total_amount = 0
		total_points = 0

		rentals.each { |rental|
			total_amount += rental.cost
			total_points += 1
		}

		result << "Owes: #{sprintf('%.2f', total_amount)}\nEarned: #{total_points} points"

		return result
	end
end
