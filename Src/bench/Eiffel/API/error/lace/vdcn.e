indexing
	description: "Error when two clusters have the same name."
	date: "$Date$"
	revision: "$Revision$"

class VDCN

inherit

	CLUSTER_ERROR

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
		do
			put_cluster_name (st)
		end

end -- class VDCN
