indexing

	description: 
		"Error for an non-existent cluster path, or%
		%a cluster path which doesn't correspond to a%
		%directory or a readable directory";
	date: "$Date$";
	revision: "$Revision $"

class VD01

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature -- Properties

	path: STRING;
			-- Invalid path

	cluster_name: STRING;
			-- Cluster name that is not readable

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			st.add_string ("Cluster name: ");
			st.add_string (cluster_name);
			st.add_string ("%NPath name: ");
			st.add_string (path);
			st.add_new_line
		end;

feature {CLUSTER_I} -- Setting

	set_path (s: STRING) is
			-- Assign `s' to `path'.
		do
			path := s;
		end;

	set_cluster_name (s: STRING) is
		do
			cluster_name := s;
		end;

end -- class VD01
