class REQUIRE_I 

inherit
	NO_I
		redefine
			check_precond, generation_value, byte_code
		end
	
feature 

	check_precond: BOOLEAN is True
			-- Must preconditions be checked ?

	generation_value: STRING is
			-- Generation value associated to the current assertion
			-- level
		once
			Result := "AS_REQUIRE"
		end
	
	byte_code: CHARACTER is
			-- Byte code value
		do
			Result := As_require
		end

end
