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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Cluster name: ");
			ow.put_string (cluster_name);
			ow.put_string ("%NPath name: ");
			ow.put_string (path);
			ow.new_line
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
