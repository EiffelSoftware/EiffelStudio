indexing

	description: 
		"Error for precompiled systems that cannot be succesfully%
		%retrieved.";
	date: "$Date$";
	revision: "$Revision $"

class VD41

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature -- Property

	path: STRING;
			-- Path of precompiled project

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Precompiled path: ");
			ow.put_string (path);
			ow.new_line
		end;

feature {PRECOMP_R} -- Setting

	set_path (s: STRING) is
			-- Assign `s' to `path'.
		do
			path := s;
		end;

end -- class VD41
