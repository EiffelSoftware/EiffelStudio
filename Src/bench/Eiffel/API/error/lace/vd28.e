-- Error when two clusters have the same path

class VD28

inherit

	CLUSTER_ERROR

feature

	second_cluster_name: STRING;

	set_second_cluster_name (s: STRING) is
		do
			second_cluster_name := s;
		end;

	build_explain is
		do
			put_cluster_path;
			put_string ("First cluster: ");
			put_string (cluster.cluster_name);
			put_string ("%NSecond cluster: ");
			put_string (second_cluster_name);
			new_line;
		end;

end
