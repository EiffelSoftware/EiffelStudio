indexing

	description: 
		"Error when two clusters have the same name.";
	date: "$Date$";
	revision: "$Revision $"

class VDCN

inherit

	CLUSTER_ERROR

feature -- Output

	build_explain (ow: OUTPUT_WINDOW) is
		do
			put_cluster_name (ow);
		end;

end -- class VDCN
