-- Error for precompiled systems that cannot be succesfully
-- retrieved.

class VD41

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature

	path: STRING;
			-- Path of precompiled project

	set_path (s: STRING) is
			-- Assign `s' to `path'.
		do
			path := s;
		end;

	build_explain is
		do
			put_string ("Precompiled path: ");
			put_string (path);
			new_line
		end;

end
