class REQUIRE_I 

inherit

	NO_I
		redefine
			check_precond, generation_value, byte_code,
			has_checking
		end
	
feature 

	has_checking: BOOLEAN is
			-- Is there any assertion checking?
		do
			Result := True
		end;

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
