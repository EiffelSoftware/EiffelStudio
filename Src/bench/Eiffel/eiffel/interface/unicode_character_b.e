indexing
	description: "Unicode character class representation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNICODE_CHARACTER_B

inherit
	CLASS_B
		redefine
			actual_type, generate_cecil_value, cecil_value
		end

creation
	make
	
feature 

	actual_type: UNICODE_CHARACTER_A is
			-- Actual character type
		once
			Result := Unicode_character_type;
		end;

	generate_cecil_value is
			-- Generate Cecil type value
		do
			generation_buffer.putstring ("SK_WCHAR");
		end;

	cecil_value: INTEGER is
			-- Cecil value
		do
			Result := Sk_wchar
		end;

end -- class UNICODE_CHARACTER_B
