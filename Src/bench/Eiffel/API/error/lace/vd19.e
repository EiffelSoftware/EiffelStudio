-- Error when the root cluster name is unvalid

class VD19

inherit

	ERROR

feature

	root_cluster_name: STRING;
			-- Invalid cluster name

	set_root_cluster_name (s: STRING) is
			-- Assign `s' to `root_cluster_name'.
		do
			root_cluster_name := s;
		end;

	code: STRING is "VD19";
			-- Error code

end
