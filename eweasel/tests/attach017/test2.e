deferred class
	TEST2

feature
	
	f
		deferred
		ensure
			position: index = old index + 1
		end

	index: INTEGER

end
