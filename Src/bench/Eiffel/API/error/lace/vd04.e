-- Error when unvalid class name in renaming clause of a cluster
-- adaptation

class VD04

inherit

	ERROR
		redefine
			trace
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

	trace is
			-- Debug purpose
		do
			io.error.putstring (code);
			io.error.putstring (": cluster of path ");
			io.error.putstring (cluster.path);
			io.error.putstring (" has to class named ");
			io.error.putstring (old_name);
			io.error.new_line;
		end;

end
