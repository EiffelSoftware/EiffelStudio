class REQUIRE_I 

inherit

	LOOP_I
		redefine
			check_precond, generation_value, byte_code
		end
	
feature 

	check_precond: BOOLEAN is
			-- Must preconditions be checked ?
		do
			Result := True;
		end;

	generation_value: STRING is
			-- Generation value associated to the current assertion
			-- level
		do
			Result := "AS_REQUIRE";
		end;
	
	byte_code: CHARACTER is
			-- Byte code value
		do
			Result := As_require;
		end;

end
