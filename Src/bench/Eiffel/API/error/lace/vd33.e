-- Error for unknown language name in generate clause

class VD33

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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Invalid language name: ");
			ow.put_string (language_name);
			ow.new_line
		end;

end
