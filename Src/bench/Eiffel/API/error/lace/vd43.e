-- Warning for incompletely C compiled precompiled system

class VD43

inherit

	WARNING
		redefine
			build_explain
		end;

feature

	code: STRING is "VD43";
			-- Error code

	path: STRING;
			-- path name

	set_path (s: STRING) is
			-- Assign `s' to `path'
		do
			path := s
		end;

	build_explain is
		do
			put_string ("File: ");
			put_string (path);
			new_line;
		end;

end
