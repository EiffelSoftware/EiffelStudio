-- Error when a use file of a cluster doens't exist

class VD02

inherit

	ERROR
		redefine
			build_explain
		end;

feature

	use_name: STRING;
			-- Class name

	cluster: CLUSTER_I;
			-- Cluster path

	set_use_name (s: STRING) is
			-- Assign `s' to `use_name'.
		do
			use_name := s;
		end;

	set_cluster (s: CLUSTER_I) is
			-- Assign `s' to `cluster'.
		do
			cluster := s;
		end;

	code: STRING is 
			-- Error code
		do
			Result := "VD02";
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("The Use file `");
			a_clickable.put_string (use_name);
			a_clickable.put_string ("' specified in the cluster clause `");
			a_clickable.put_string (cluster.cluster_name);
			a_clickable.put_string ("' does not exist%N");
		end;

end
