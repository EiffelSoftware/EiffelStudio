-- Error when a precompiled file or directory cannot be read

class VD42

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

	build_explain is
		do
			if is_directory then
				put_string ("Directory: ")
			else
				put_string ("File: ")
			end
			put_string (path);
			new_line
		end;

end
