class
	TEST

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
		end
		
feature -- Actions
	
	single_santa: separate TEST1 is
			-- create a single Instance of a santa
		once
			create Result.make (3, 9)
		end

end 
