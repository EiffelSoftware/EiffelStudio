class
	LOOP_I 

inherit
	INVARIANT_I
		redefine
			check_loop, generation_value, byte_code
		end
	
feature 

	check_loop: BOOLEAN is True
			-- Must loop assertions be checked ?

	generation_value: STRING is
			-- Generation value associated to the current assertion
			-- level
		once
			Result := "AS_LOOP"
		end

	byte_code: CHARACTER is
			-- Byte code value
		do
			Result := As_loop
		end

end
