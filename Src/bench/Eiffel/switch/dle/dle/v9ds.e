-- Error for DC-set's base systems that cannot be succesfully
-- retrieved.

class V9DS

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature

	path: STRING;
			-- Path of static project

	set_path (s: STRING) is
			-- Assign `s' to `path'.
		do
			path := s;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Extending path: ");
			ow.put_string (path);
			ow.new_line
		end;

end
