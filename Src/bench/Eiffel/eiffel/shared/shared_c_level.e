-- Internal levels used to encode C types
-- Those values have to match with run-time source file "update.h"

class SHARED_C_LEVEL 
	
feature 

	C_void: INTEGER is 0
			-- Internal code for void

	C_char: INTEGER is 1
			-- Internal code for char

	C_int8: INTEGER is 2
			-- Internal code for 8 bits integer

	C_int16: INTEGER is 3
			-- Internal code for 16 bits integer

	C_wide_char: INTEGER is 4
			-- Internal code for unicode char

	C_long: INTEGER is 5
			-- Internal code for long

	C_int32: INTEGER is 5
			-- Internal code for long, same as `C_long'
	
	C_float: INTEGER is 6
			-- Internal code for float

	C_int64: INTEGER is 7
			-- Internal code for 64 bits integer
	
	C_double: INTEGER is 8
			-- Internal code for double
	
	C_ref: INTEGER is 9
			-- Internal code for reference

	C_pointer: INTEGER is 10
			-- Internal code for pointer type
	
	C_nb_types: INTEGER is 11
			-- Number of internal C types

end
