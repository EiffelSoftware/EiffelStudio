indexing

	description: 
		"Error for unknown language name in Externals clause.";
	date: "$Date$";
	revision: "$Revision $"

class VD34

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature -- Property

	language_name: STRING;
			-- Option name

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Invalid language name: ");
			ow.put_string (language_name);
			ow.new_line
		end;

feature {LANG_TRIB_SD} -- Setting

	set_language_name (s: STRING) is
			-- Assign `s' to `language_name'
		do
			language_name := s
		end;

end -- class VD34
