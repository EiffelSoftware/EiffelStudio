-- Error for an non-existent cluster path, or a cluster path which doesn't
-- correpond to a directory or a readable directory

class VD01

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature

	path: STRING;
			-- Invalid path

	set_path (s: STRING) is
			-- Assign `s' to `path'.
		do
			path := s;
		end;

	build_explain is
		do
			put_string ("Path: `");
			put_string (path);
			put_char ('%'');
			new_line
		end;

end
