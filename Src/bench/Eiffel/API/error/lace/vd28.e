-- Error when two clusters have the same path

class VD28

inherit

	CLUSTER_ERROR
		redefine
			build_explain
		end

feature

	code: STRING is "VD28";
			-- Error code

	second_cluster_name: STRING;

	set_second_cluster_name (s: STRING) is
		do
			second_cluster_name := s;
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("%Tcluster ");
			a_clickable.put_string (cluster.cluster_name);
			a_clickable.put_string (" and cluster ");
			a_clickable.put_string (second_cluster_name);
			a_clickable.put_string (" have the same path ");
			a_clickable.put_string (cluster.path);
			a_clickable.new_line;
		end;

end
