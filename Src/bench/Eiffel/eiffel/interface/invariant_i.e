class INVARIANT_I 

inherit

	ENSURE_I
		redefine
			check_invariant, generation_value, byte_code
		end
	
feature 

	check_invariant: BOOLEAN is
			-- Must invariant be checked ?
		do
			Result := True;
		end;

	generation_value: STRING is
			-- Generation value associated to the current assertion
			-- level
		do
			Result := "AS_INVARIANT";
		end;

	byte_code: CHARACTER is
			-- Byte code value
		do
			Result := As_invariant;
		end;

end
