-- Error when a use file of a cluster doens't exist

class VD02

inherit

	ERROR

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

end
