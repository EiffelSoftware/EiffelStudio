class
	CHECK_I 

inherit
	LOOP_I
		redefine
			check_check, generation_value, byte_code
		end
	
feature 

	check_check: BOOLEAN is True
			-- Must the check assertions be verified ?

	generation_value: STRING is "AS_CHECK"
			-- Generation value associated to the current assertion
			-- level

	byte_code: CHARACTER is
			-- Byte code value
		do
			Result := As_check
		end

end
