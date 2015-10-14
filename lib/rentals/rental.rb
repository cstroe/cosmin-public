class Rental
	attr_accessor :movie, :customer, :days_rented

	def initialize(movie, customer, days_rented)
		self.movie = movie
		self.customer = customer
		self.days_rented = days_rented
	end

	def cost
		if movie.type == Movie::NEW_RELEASE
			amount = 2.0

			if days_rented > 2
				amount += (days_rented - 2) * 1.5
			end

			return amount
		elsif movie.type == Movie::CHILDRENS
			amount = 1.5

			if days_rented > 3
				amount += (days_rented - 3) * 1.5
			end

			return amount
		else
			return days_rented * 3.0
		end
	end

	private

	def _daily_cost_after_min_days(initial_cost, threshold, daily_cost)
		if days_rented > threshold
			return initial_cost + ((days_rented - threshold) * daily_cost)
		end

		return initial_cost
	end
end
