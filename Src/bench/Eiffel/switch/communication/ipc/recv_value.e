-- Facilities to receive DEBUG_VALUEs from application.
-- Those volues might be arguments, local entities or once function result.

class RECV_VALUE

feature -- External routines

	c_recv_value (c: like Current) is
		external
			"C"
		end;

	c_pass_recv_routines (d_int, d_bool, d_char, d_real, d_double, 
						d_ref, d_point, d_bits, d_error, d_void: POINTER) is
		external
			"C"
		end;		

feature	{} -- Initialization of the C/Eiffel interface

	init_recv_c is
			-- Pass routine addresses to C.
		once
			c_pass_recv_routines ($set_int, $set_bool, $set_char, $set_real, 
					$set_double, $set_ref, $set_point, 
					$set_bits, $set_error, $set_void)
		end;

	set_error is
			-- An error occurred.
		do
			error := True
		end;
		
	set_int (v: INTEGER) is
			-- Receive an integer value.
		do
			!INTEGER_VALUE! item.make (v)
		end;

	set_bool (v: BOOLEAN) is
			-- Receive a boolean value.
		do
			!BOOLEAN_VALUE! item.make (v)
		end;

	set_char (v: CHARACTER) is
			-- Receive a character value.
		do
			!CHARACTER_VALUE! item.make (v)
		end;

	set_real (v: REAL) is
			-- Receive a real value.
		do
			!REAL_VALUE! item.make (v)
		end;

	set_double (v: DOUBLE) is
			-- Receive a double value.
		do
			!DOUBLE_VALUE! item.make (v)
		end;
	
	set_ref (ref: POINTER; type: INTEGER) is
			-- Receive a reference value.
		do
			!REFERENCE_VALUE! item.make (ref, type + 1)
		end;

	set_point (v: POINTER) is
			-- Receive a pointer value.
		do
			!POINTER_VALUE! item.make (v)
		end;

	set_bits (ref: POINTER; size: INTEGER)  is
			-- Receive a bit value.
		do
			!BITS_VALUE! item.make (ref, size)
		end;

	set_void is
			-- Set `item' to Void.
		do
			item := Void;
		end;

feature -- Status report

	error: BOOLEAN;
			-- Did an error occurr?

feature {NONE} -- internal

	item: DEBUG_VALUE;
			-- Last received value

end -- class RECV_VALUE
