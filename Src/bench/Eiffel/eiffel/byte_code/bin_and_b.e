class BIN_AND_B 

inherit
	B_AND_THN_BL
		redefine
			is_and
		end
		
feature -- Status report

	is_and: BOOLEAN is True
			-- Current is a plain `and' expression.

end -- class BIN_AND_B
