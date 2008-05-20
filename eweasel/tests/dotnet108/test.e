class
	TEST
 
create
	make

feature {NONE} -- Initialization

	make is
		do
		end

	new_row: like row_type is
			-- Initialization
		do
			create Result
		end

	row_type: ANY is
		do
		end
      
	new_row2: like row_type2 is
			-- Initialization
		do
			Result ?= io
		end

	row_type2: ANY is
		do
		end

end
