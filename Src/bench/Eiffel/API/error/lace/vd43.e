indexing

	description: 
		"Warning for incompletely C compiled precompiled system.";
	date: "$Date$";
	revision: "$Revision $"

class VD43

inherit

	WARNING
		redefine
			build_explain
		end;

feature -- Properties

	code: STRING is "VD43";
			-- Error code

	path: STRING;
			-- path name

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("File: ");
			ow.put_string (path);
			ow.new_line;
		end;

feature {REMOTE_PROJECT_DIRECTORY} -- Setting

	set_path (s: STRING) is
			-- Assign `s' to `path'
		do
			path := s
		end;

end -- class VD43
