class V9RD inherit

	LACE_ERROR

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
		end;

end
