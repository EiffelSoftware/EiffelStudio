-- Error for removing the kernel cluster

class VD40

inherit

	CLUSTER_ERROR

feature

	build_explain is
		do
			put_cluster_name;
			put_cluster_path;
		end;

end
