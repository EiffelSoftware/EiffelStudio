indexing

	description: 
		"Error when adaptation of a cluster contains%
		%a paragraph about itself.";
	date: "$Date$";
	revision: "$Revision $"

class VD05

inherit

	VD03
		redefine
			build_explain
		end;

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Cluster name: ");
			st.add_string (cluster_name);
			st.add_new_line
		end;

end -- class VD05
