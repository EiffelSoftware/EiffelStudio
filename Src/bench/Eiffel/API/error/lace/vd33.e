indexing

	description: 
		"Error for unknown language name in generate clause.";
	date: "$Date$";
	revision: "$Revision $"

class VD33

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature -- Property

	language_name: STRING;
			-- Option name

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Invalid language name: ");
			st.add_string (language_name);
			st.add_new_line
		end;

feature {LANG_GEN_SD} -- Setting

	set_language_name (s: STRING) is
			-- Assign `s' to `language_name'
		do
			language_name := s
		end;

end -- class VD33
