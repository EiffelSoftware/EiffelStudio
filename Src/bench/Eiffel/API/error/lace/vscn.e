-- Error when clash name in a cluster

class VSCN


inherit

	CLUSTER_ERROR
		redefine
			trace
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

	trace is
			-- Debug purpose
		do
			io.error.putstring ("code VSCN: cluster ");
			io.error.putstring (cluster.path);
			io.error.putstring ("\n\tfirst class ");
			io.error.putstring (first.class_name);
			io.error.putstring (" in ");
			io.error.putstring (first.cluster.path);
			io.error.putstring ("\n\tsecond class ");
			io.error.putstring (second.class_name);
			io.error.putstring (" in ");
			io.error.putstring (second.cluster.path);
			io.error.new_line;
		end;

end
