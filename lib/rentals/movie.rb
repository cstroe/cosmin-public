class Movie
	attr_accessor :type, :title

	NEW_RELEASE = 0
	CHILDRENS = 1
	REGULAR = 2
	CLASSIC = 3 #2.50 FOR 5 DAYS, 1/DAY AFTER

	def initialize(type, title)
		# in real life, do this better
		if  type != NEW_RELEASE and type != CHILDRENS and type != REGULAR and type != CLASSIC
			raise ("Picked an incorrect genre")
		end
		self.type = type
		self.title = title
	end
end
