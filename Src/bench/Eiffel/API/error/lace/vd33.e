-- Error for unknown language name in generate clause

class VD33

inherit

	ERROR
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

	code: STRING is
			-- Error code
		do
			Result := "VD33";
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("%TUndefined name in Generate clause: ");
			a_clickable.put_string (language_name);
			a_clickable.new_line;
		end;

end
