indexing

	description: 
		"Error for removing the kernel cluster.";
	date: "$Date$";
	revision: "$Revision $"

class VD40

inherit

	CLUSTER_ERROR

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_cluster_name (ow);
			put_cluster_path (ow);
		end;

end -- class VD40
