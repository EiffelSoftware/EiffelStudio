deferred class
	ASSERTION_I 

inherit
	AS_CONST
	
feature 

	check_precond: BOOLEAN is
			-- Must preconditions be checked ?
		do
			-- Do nothing
		end

	check_postcond: BOOLEAN is
			-- Must postconditions be checked ?
		do
			-- Do nothing
		end

	check_invariant: BOOLEAN is
			-- must invariant be checked ?
		do
			-- Do nothing
		end

	check_loop: BOOLEAN is
			-- Must loop assertions be checked ?
		do
			-- Do nothing
		end

	check_check: BOOLEAN is
			-- Must check clauses be checked ?
		do
			-- Do nothing
		end

	generate (file: INDENT_FILE) is
			-- Generate assertion value in `file'.
		require
			good_argument: file /= Void
			is_open: file.is_open_write
		do
			file.putstring (generation_value)
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code representation of the assertion
		do
debug ("OPTIONS")
	io.error.putstring ("Make byte code: ")
	trace
end
			ba.append (byte_code)
		end

	byte_code: CHARACTER is
			-- Byte code value
		deferred
		end

	generation_value: STRING is
			-- Generation value associated to the current assertion
			-- level
		deferred
		end

feature -- Debug

	trace is
		do
			io.error.putstring ("Assertion level: ")
			io.error.putstring (generator)
			io.error.new_line
		end

end
