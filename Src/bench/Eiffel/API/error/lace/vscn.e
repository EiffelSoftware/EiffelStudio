indexing

	description: 
		"Error when name clash in a cluster.";
	date: "$Date$";
	revision: "$Revision $"

class VSCN

inherit

	CLUSTER_ERROR

feature -- Properties

	first: CLASS_I;
			-- First class in conflict

	second: CLASS_I;
			-- Second class in conflict with first

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			put_cluster_name (st);
			st.add_string ("First class: ");
			first.append_name (st);
			st.add_new_line;
			st.add_string ("First file: ");
			st.add_string (first.file_name);
			st.add_new_line;
			st.add_string ("Second class: ");
			second.append_name (st);
			st.add_new_line;
			st.add_string ("Second file: ");
			st.add_string (second.file_name);
			st.add_new_line;
		end;

feature {UNIVERSE_I, CLUSTER_I, CLUST_REN_SD} -- Setting

	set_first (c: CLASS_I) is
			-- Assign `c' to `first'.
		do
			first := c;
		end;

	set_second (c: CLASS_I) is
			-- Assing `c' to `second'.
		do
			second := c;
		end;

end -- class VSCN
