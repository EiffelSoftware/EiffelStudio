-- Internal levels used to encode C types
-- Those values have to match with run-time source file "update.h"

class SHARED_C_LEVEL 
	
feature 

	C_void: INTEGER is 0
			-- Internal code for void

	C_char: INTEGER is 1
			-- Internal code for char
	
	C_long: INTEGER is 2
			-- Internal code for long
	
	C_float: INTEGER is 3
			-- Internal code for float
	
	C_double: INTEGER is 4
			-- Internal code for double
	
	C_ref: INTEGER is 5
			-- Internal code for reference

	C_pointer: INTEGER is 6
			-- Internal code for pointer type
	
	C_nb_types: INTEGER is 6
			-- Number of internal C types

end
