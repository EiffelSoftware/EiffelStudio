class ENSURE_I 

inherit

	REQUIRE_I
		redefine
			check_postcond, generation_value, byte_code
		end
	
feature 

	check_postcond: BOOLEAN is
			-- Must the postconditions be checked ?
		do
			Result := True;
		end;

	generation_value: STRING is
			-- Generation value associated to the current assertion
			-- level
		do
			Result := "AS_ENSURE";
		end;

	byte_code: CHARACTER is
			-- Byte code value
		do
			Result := As_ensure;
		end;

end
