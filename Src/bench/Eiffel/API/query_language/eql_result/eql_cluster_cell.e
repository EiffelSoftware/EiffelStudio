indexing
	description: "Cell for store a cluster_i object in EQL"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_CLUSTER_CELL

feature{NONE} -- Initialization

	make_with_cluster_i (a_cluster_i: CLUSTER_I) is
			-- Initialize `cluster_i' with `a_cluster_i'.
		do
			set_cluster_i (a_cluster_i)
		end

feature -- Status reporting

	is_cluster_i_set: BOOLEAN is
			-- Is `cluster_i' set?
		do
			Result := cluster_i /= Void
		ensure
			good_result: Result implies cluster_i /= Void
		end

feature -- Access

	cluster_i: CLUSTER_I
			-- Cluster in current context

feature -- Setting

	set_cluster_i (cl: CLUSTER_I) is
			-- Assign `cl' to `cluster_i'.
		do
			cluster_i := cl
		end

end
