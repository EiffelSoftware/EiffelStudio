indexing

	description: 
		"Error when a use file of a cluster does not exist.";
	date: "$Date$";
	revision: "$Revision $"

class VD02

inherit

	CLUSTER_ERROR

feature -- Property

	use_name: STRING;
			-- Class name

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			put_cluster_name (st);
			st.add_string ("File name: ");
			st.add_string (use_name);
			st.add_new_line;
		end;

feature {CLUST_PROP_SD} -- Setting

	set_use_name (s: STRING) is
			-- Assign `s' to `use_name'.
		do
			use_name := s;
		end;

end -- class VD02
