indexing

	description: 
		"No basic class in cluster.";
	date: "$Date$";
	revision: "$Revision $"

class VD23

inherit

	LACE_ERROR

feature -- Property

	class_name: STRING;
			-- Class nam involved

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Class name: ");
			ow.put_string (class_name);
			ow.new_line;
		end;

feature {UNIVERSE_I} -- Setting

	set_class_name (s: STRING) is
			-- Assign `s' to `class_name'.
		do
			class_name := s;
		end;

end -- class VD23
