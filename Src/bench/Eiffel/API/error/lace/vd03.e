-- Error for an unvalid cluster name specified in an adaptation clause

class VD03

inherit

	ERROR
		redefine
			build_explain
		end

feature

	cluster_name: ID_SD;
			-- Cluster name not valid

	set_cluster_name (s: ID_SD) is
			-- Assign `s' to `cluster_name'.
		do
			cluster_name := s;
		end;

	code: STRING is
			-- Error code
		do
			Result := "VD03";
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string (cluster_name);
			a_clickable.put_string (" is invalid%N");
		end;

end
