indexing

	description: 
		"rror when the root cluster name is not in cluster list.";
	date: "$Date$";
	revision: "$Revision $"

class VD19

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature -- Property

	root_cluster_name: STRING;
			-- Invalid cluster name

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Unknown cluster name: ");
			ow.put_string (root_cluster_name);
			ow.new_line
		end;

feature {ROOT_SD} -- Setting

	set_root_cluster_name (s: STRING) is
			-- Assign `s' to `root_cluster_name'.
		do
			root_cluster_name := s;
		end;

end -- class VD19
