-- Error when two different basic classes in two clusters

class VD24

inherit

	CLASS_ERROR
		redefine
			build_explain
		end;

feature

	other_cluster: CLUSTER_I;
			-- Other cluster involved

	set_other_cluster (c: CLUSTER_I) is
			-- Assign `c' to `other_cluster'.
		do
			other_cluster := c;
		end;

	build_explain is
		do
			put_string ("Conflicting clusters: `");
			put_string (other_cluster.cluster_name);
			put_string ("' and `");
			put_string (cluster.cluster_name);
			put_string ("';%N");
			put_class_name;
		end;

end
