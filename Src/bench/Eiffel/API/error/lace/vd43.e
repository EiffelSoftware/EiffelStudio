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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("File: ");
			ow.put_string (path);
			ow.new_line;
		end;

end
