-- Error when unvalid class name in renaming clause of a cluster
-- adaptation

class VD04

inherit

	ERROR
		redefine
			build_explain
		end

feature

	old_name: ID_SD;
			-- Class name involved

	cluster: CLUSTER_I;
			-- Cluster which doesn't know a class named `old_name'

	set_old_name (s: ID_SD) is
			-- Assign `s' to `old_name'.
		do
			old_name := s;
		end;

	set_cluster (c: CLUSTER_I) is
			-- Assign `c' to `cluster'.
		do
			cluster := c;
		end;

	code: STRING is "VD04";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
			-- Debug purpose
		do
			a_clickable.put_string ("%Tcluster of path ");
			a_clickable.put_string (cluster.path);
			a_clickable.put_string (" has no class named ");
			a_clickable.put_string (old_name);
			a_clickable.new_line;
		end;

end
