indexing

	description: 
		"Error for removing the kernel cluster.";
	date: "$Date$";
	revision: "$Revision $"

class VD40

inherit

	CLUSTER_ERROR

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			put_cluster_name (st);
			put_cluster_path (st);
		end;

end -- class VD40
