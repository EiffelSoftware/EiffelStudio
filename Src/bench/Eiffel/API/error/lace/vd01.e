-- Error for an non-existent cluster path, or a cluster path which doesn't
-- correpond to a directory or a readable directory

class VD01

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature

	path: STRING;
			-- Invalid path

	set_path (s: STRING) is
			-- Assign `s' to `path'.
		do
			path := s;
		end;

	cluster_name: STRING;

	set_cluster_name (s: STRING) is
		do
			cluster_name := s;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Cluster name: ");
			ow.put_string (cluster_name);
			ow.put_string ("%NPath name: ");
			ow.put_string (path);
			ow.new_line
		end;

end
