indexing
	description: "[
		Facilities to receive DEBUG_VALUEs from application.
		Those volues might be arguments, local entities or once function result.
		]"
	date: "$Date$"
	version: "$Version: $"

class RECV_VALUE

feature	{} -- Initialization of the C/Eiffel interface

	init_recv_c is
			-- Pass routine addresses to C.
		once
			c_pass_recv_routines ($set_int8, $set_int16, $set_int32, $set_int64, $set_bool,
					$set_char, $set_wchar, $set_real, 
					$set_double, $set_ref, $set_point, 
					$set_bits, $set_error, $set_void)
		end

	set_error is
			-- An error occurred.
		do
			error := True
		end

	set_int8 (v: INTEGER_8) is
			-- Receive an integer value.
		do
			create {DEBUG_VALUE [INTEGER_8]} item.make (v)
		end

	set_int16 (v: INTEGER_16) is
			-- Receive an integer value.
		do
			create {DEBUG_VALUE [INTEGER_16]} item.make (v)
		end

	set_int32 (v: INTEGER) is
			-- Receive an integer value.
		do
			create {DEBUG_VALUE [INTEGER]} item.make (v)
		end
		
	set_int64 (v: INTEGER_64) is
			-- Receive an integer value.
		do
			create {DEBUG_VALUE [INTEGER_64]} item.make (v)
		end

	set_bool (v: BOOLEAN) is
			-- Receive a boolean value.
		do
			create {DEBUG_VALUE [BOOLEAN]} item.make (v)
		end

	set_char (v: CHARACTER) is
			-- Receive a character value.
		do
			create {CHARACTER_VALUE} item.make (v)
		end

	set_wchar (v: WIDE_CHARACTER) is
			-- Receive a character value.
		do
			create {DEBUG_VALUE [WIDE_CHARACTER]} item.make (v)
		end

	set_real (v: REAL) is
			-- Receive a real value.
		do
			create {DEBUG_VALUE [REAL]} item.make (v)
		end

	set_double (v: DOUBLE) is
			-- Receive a double value.
		do
			create {DEBUG_VALUE [DOUBLE]} item.make (v)
		end
	
	set_ref (ref: POINTER; type: INTEGER) is
			-- Receive a reference value.
		do
			create {REFERENCE_VALUE} item.make (ref, type + 1)
		end

	set_point (v: POINTER) is
			-- Receive a pointer value.
		do
			create {DEBUG_VALUE [POINTER]} item.make (v)
		end

	set_bits (ref: POINTER; size: INTEGER)  is
			-- Receive a bit value.
		do
			create {BITS_VALUE} item.make (ref, size)
		end

	set_void is
			-- Set `item' to Void.
		do
			item := Void
		end

feature -- Status report

	error: BOOLEAN
			-- Did an error occurr?

feature {NONE} -- internal

	item: ABSTRACT_DEBUG_VALUE
			-- Last received value

feature {NONE} -- External routines

	c_recv_value (c: like Current) is
		external
			"C"
		end

	c_pass_recv_routines (d_int8, d_int16, d_int32, d_int64, d_bool, d_char, d_wchar, d_real, d_double, 
						d_ref, d_point, d_bits, d_error, d_void: POINTER) is
		external
			"C"
		end

end -- class RECV_VALUE
