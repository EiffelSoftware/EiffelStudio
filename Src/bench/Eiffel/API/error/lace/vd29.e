-- Error when the root class is in two different clusters
-- and none of them is specified in the ace file

class VD29

inherit

	CLUSTER_ERROR
		redefine
			trace
		end

feature

	code: STRING is "VD29";
			-- Error code

	second_cluster_name: STRING;

	set_second_cluster_name (s: STRING) is
		do
			second_cluster_name := s;
		end;

	root_class_name: STRING;

	set_root_class_name (s: STRING) is
		do
			root_class_name := s;
		end;

	trace is
			-- Debug purpose
		do
			io.error.putstring ("code VD29: the root class ");
			io.error.putstring (root_class_name);
			io.error.putstring (" is in two different clusters: ");
			io.error.putstring (cluster.cluster_name);
			io.error.putstring (" and ");
			io.error.putstring (second_cluster_name);
			io.error.new_line;
		end;

end
