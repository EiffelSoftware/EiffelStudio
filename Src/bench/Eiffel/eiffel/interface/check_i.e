class CHECK_I 

inherit

	LOOP_I
		redefine
			check_check, generation_value, byte_code
		end
	
feature 

	check_check: BOOLEAN is
			-- Must the check assertions be verified ?
		do
			Result := True;
		end;

	generation_value: STRING is
			-- Generation value associated to the current assertion
			-- level
		do
			Result := "AS_CHECK";
		end;

	byte_code: CHARACTER is
			-- Byte code value
		do
			Result := As_check;
		end;

end
