indexing
	description: "Information about integer and natural type in Eiffel"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_NATURAL_INFORMATION

feature
	max_integer_type: INTEGER_64
			-- INTEGER type of max word length
			
	max_natural_type: NATURAL_64
			-- NATURAL type of max word length
			
	type_count: INTEGER is 4
			-- Number of types of integer/natural in Eiffel
	
	type_no_limitation: INTEGER is 0	
	type_integer_8:  INTEGER is 1
	type_integer_16: INTEGER is 2
	type_integer, type_integer_32: INTEGER is 3
	type_integer_64: INTEGER is 4	
	type_integer_natural_separator: INTEGER is 10
	type_natural_8: INTEGER is 11
	type_natural_16: INTEGER is 12
	type_natural, type_natural_32: INTEGER is 13
	type_natural_64: INTEGER is 14
			-- Type indicators
	
feature
	integer_type_valid (type: INTEGER): BOOLEAN is
			-- Is `type' a valid integer type?
		do
			Result := (type = type_integer_8) or
					  (type = type_integer_16) or
					  (type = type_integer_32) or
					  (type = type_integer_64)
		end
		
	natural_type_valid (type: INTEGER): BOOLEAN is
			-- Is `type' a valid natural type?
		do
			Result := (type = type_natural_8) or
					  (type = type_natural_16) or
					  (type = type_natural_32) or
					  (type = type_natural_64)			
		end
		
	type_valid (type: INTEGER): BOOLEAN is
			-- Is `type' a valid integer/natural type?
		do
			Result := (type = type_no_limitation) or
					  (type = type_integer_8) or
					  (type = type_integer_16) or
					  (type = type_integer_32) or
					  (type = type_integer_64) or
					  (type = type_natural_8) or
					  (type = type_natural_16) or
					  (type = type_natural_32) or
					  (type = type_natural_64)					  
		end
	
end
