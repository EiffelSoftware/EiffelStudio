-- Error for unknown language name in Externals clause

class VD34

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature

	language_name: STRING;
			-- Option name

	set_language_name (s: STRING) is
			-- Assign `s' to `language_name'
		do
			language_name := s
		end;

	build_explain is
		do
			put_string ("Language name: `");
			put_string (language_name);
			put_char ('%'');
			new_line
		end;

end
