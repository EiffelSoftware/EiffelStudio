indexing

	description: 
		"Error when a precompiled file or directory cannot be read.";
	date: "$Date$";
	revision: "$Revision $"

class VD42

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature -- Properties

	path: STRING;
			-- Path of file/directory

	is_directory: BOOLEAN;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			if is_directory then
				st.add_string ("Directory: ")
			else
				st.add_string ("File: ")
			end
			st.add_string (path);
			st.add_new_line
		end;

feature {REMOTE_PROJECT_DIRECTORY} -- Setting

	set_path (s: STRING) is
			-- Assign `s' to `path'.
		do
			path := s;
		end;

	set_is_directory is
		do
			is_directory := True
		end;

end -- class VD42
