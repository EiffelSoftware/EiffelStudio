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
			put_string ("Cluster 1: `");
			put_string (cluster.cluster_name);
			put_string ("'%NCluster 2: `");
			put_string (second_cluster_name);
			put_string ("'%N");
			put_cluster_path;
		end;

end
