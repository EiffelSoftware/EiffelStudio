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

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Class name: ");
			st.add_string (class_name);
			st.add_new_line;
		end;

feature {UNIVERSE_I} -- Setting

	set_class_name (s: STRING) is
			-- Assign `s' to `class_name'.
		do
			class_name := s;
		end;

end -- class VD23
