-- Error when the root cluster name is not in cluster list

class VD19

inherit

	LACE_ERROR
		redefine
			build_explain
		end;

feature

	root_cluster_name: STRING;
			-- Invalid cluster name

	set_root_cluster_name (s: STRING) is
			-- Assign `s' to `root_cluster_name'.
		do
			root_cluster_name := s;
		end;

	build_explain is
		do
			put_string ("Unknown cluster name: ");
			put_string (root_cluster_name);
			new_line
		end;
end
