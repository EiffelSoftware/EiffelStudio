-- Error when two clusters have the same path

class VD28

inherit

	CLUSTER_ERROR
		redefine
			trace
		end

feature

	code: STRING is "VD28";
			-- Error code

	second_cluster_name: STRING;

	set_second_cluster_name (s: STRING) is
		do
			second_cluster_name := s;
		end;

	trace is
			-- Debug purpose
		do
			io.error.putstring ("code VD28: cluster ");
			io.error.putstring (cluster.cluster_name);
			io.error.putstring (" and cluster ");
			io.error.putstring (second_cluster_name);
			io.error.putstring (" have the same path ");
			io.error.putstring (cluster.path);
			io.error.new_line;
		end;

end
