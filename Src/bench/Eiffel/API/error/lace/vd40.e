-- Error for removing the kernel cluster

class VD40

inherit

	CLUSTER_ERROR

feature

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_cluster_name (ow);
			put_cluster_path (ow);
		end;

end
