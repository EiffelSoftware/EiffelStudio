-- Lace compilation context

class LACE_CONTEXT

feature

	current_cluster: CLUSTER_I;
			-- Current analyzed cluster

	current_file_name: STRING;
			-- Current ACE file name analyzed

	set_current_cluster (c: CLUSTER_I) is
			-- Assign `c' to `current_cluster'.
		require
			good_argument: c /= Void;
		do
			current_cluster := c;
		end;

	set_current_file_name (s: STRING) is
			-- Assign `s' to `current_file_name'.
		do
			current_file_name := s;
		end;

end
