class
	NO_I 

inherit
	ASSERTION_I
	
feature

	generation_value: STRING is
			-- Generation value associated to the current assertion
			-- level
		once
			Result := "AS_NO"
		end

	byte_code: CHARACTER is
		do
			Result := As_no
		end

end
