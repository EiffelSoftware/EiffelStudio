-- Error when clash name in a cluster

class VSCN


inherit

	CLUSTER_ERROR
		redefine
			build_explain
		end

feature

	first: CLASS_I;
			-- First class in conflict

	second: CLASS_I;
			-- Second class in conflict with first

	set_first (c: CLASS_I) is
			-- Assign `c' to `first'.
		do
			first := c;
		end;

	set_second (c: CLASS_I) is
			-- Assing `c' to `second'.
		do
			second := c;
		end;

	code: STRING is "VSCN";
			-- Error code

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("%TCluster ");
			a_clickable.put_string (cluster.path);
			a_clickable.put_string ("%N%Tfirst class ");
			a_clickable.put_string (first.class_name);
			a_clickable.put_string (" in ");
			a_clickable.put_string (first.cluster.path);
			a_clickable.put_string ("%N%Tsecond class ");
			a_clickable.put_string (second.class_name);
			a_clickable.put_string (" in ");
			a_clickable.put_string (second.cluster.path);
			a_clickable.new_line;
		end;

end
