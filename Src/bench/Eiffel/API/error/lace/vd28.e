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

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_cluster_path (ow);
			ow.put_string ("First cluster: ");
			ow.put_string (cluster.cluster_name);
			ow.put_string ("%NSecond cluster: ");
			ow.put_string (second_cluster_name);
			ow.new_line;
		end;

end
