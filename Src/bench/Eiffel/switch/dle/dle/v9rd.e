-- Error when a DC-set's base system file or directory cannot be read

class V9RD

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature

	path: STRING;
			-- Path of file/directory

	set_path (s: STRING) is
			-- Assign `s' to `path'.
		do
			path := s;
		end;

	is_directory: BOOLEAN;

	set_is_directory is
		do
			is_directory := True
		end;

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

end
