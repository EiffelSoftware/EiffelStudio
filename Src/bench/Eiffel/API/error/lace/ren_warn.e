-- Warning for rename clause in Ace

class REN_WARN

inherit

	WARNING
		redefine
			build_explain
		end

feature

	code: STRING is "VD35";
			-- Error code

	cluster_name: STRING;

	set_cluster_name (s: STRING) is
		do
			cluster_name := s;
		end;

	build_explain is
		do
			put_string ("Cluster name: `");
			put_string (cluster_name);
			put_string ("%'%N");
		end;

end
