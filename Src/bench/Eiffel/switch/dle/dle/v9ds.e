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

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Extending path: ");
			st.add_string (path);
			st.add_new_line
		end;

end
