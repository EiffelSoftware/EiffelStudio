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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			if is_directory then
				ow.put_string ("Directory: ")
			else
				ow.put_string ("File: ")
			end
			ow.put_string (path);
			ow.new_line
		end;

end
