indexing

	description: 
		"Run time value representing a character.";
	date: "$Date$";
	revision: "$Revision $"

class CHARACTER_VALUE

inherit
	DEBUG_VALUE [CHARACTER]
		redefine
			append_type_and_value, append_value, type_and_value
		end

	CHARACTER_ROUTINES
		undefine
			is_equal
		end

creation {RECV_VALUE, ATTR_REQUEST}
	make, make_attribute

feature -- Output

	append_type_and_value (st: STRUCTURED_TEXT) is 
		do 
			dynamic_class.append_name (st)
			st.add_string (" = ");
			st.add_char ('%'');
			st.add_string (char_text (value));
			st.add_char ('%'')
		end;

	append_value (st: STRUCTURED_TEXT) is 
		do 
			st.add_string (char_text (value))
		end;

	type_and_value: STRING is
			-- Return a string representing `Current'.
		do
			create Result.make (30)
			Result.append (dynamic_class.name_in_upper)
			Result.append (Equal_slash)
			Result.append (value.code.out)
			Result.append (Slash_colon)
			Result.append (char_text (value))
			Result.append (Quote)
		end

	Equal_slash: STRING is " = /"
	Slash_colon: STRING is "/ : %'"
	Quote: STRING is "%'"

end -- class CHARACTER_VALUE
