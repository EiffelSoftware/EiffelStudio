-- Error for an invalid cluster name specified in an adaptation clause

class VD03

inherit

	LACE_ERROR
		redefine
			build_explain
		end

feature

	cluster_name: ID_SD;
			-- Cluster name not valid

	set_cluster_name (s: ID_SD) is
			-- Assign `s' to `cluster_name'.
		do
			cluster_name := s;
		end;

	build_explain is
		do
			put_string ("Cluster name: `");
			put_string (cluster_name);
			put_char ('%'');
			new_line
		end;

end
