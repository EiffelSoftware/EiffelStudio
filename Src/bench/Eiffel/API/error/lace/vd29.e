-- Error when the root class is in two different clusters
-- and none of them is specified in the ace file

class VD29

inherit

	CLUSTER_ERROR
		redefine
			build_explain
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

	build_explain (a_clickable: CLICK_WINDOW) is
		do
			a_clickable.put_string ("%Tthe root class ");
			a_clickable.put_string (root_class_name);
			a_clickable.put_string (" is in two different clusters: ");
			a_clickable.put_string (cluster.cluster_name);
			a_clickable.put_string (" and ");
			a_clickable.put_string (second_cluster_name);
			a_clickable.new_line;
		end;

end
