class LOOP_I 

inherit

	CHECK_I
		redefine
			check_loop, generation_value, byte_code
		end
	
feature 

	check_loop: BOOLEAN is
			-- Must loop assertions be checked ?
		do
			Result := True;
		end;

	generation_value: STRING is
			-- Generation value associated to the current assertion
			-- level
		do
			Result := "AS_LOOP";
		end; -- generation_value

	byte_code: CHARACTER is
			-- Byte code value
		do
			Result := As_loop;
		end; -- byte_code

end
