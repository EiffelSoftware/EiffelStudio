deferred class 
	PARENT [G -> COMPARABLE]

feature -- Status report

	failure (y_a, y_b: G) is
		deferred
		ensure
			lower: y_a >= y_b
		end
		
end -- class PARENT
