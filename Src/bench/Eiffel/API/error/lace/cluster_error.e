indexing
	description: "Error for cluster."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CLUSTER_ERROR

inherit
	LACE_ERROR

feature -- Property

	cluster: CLUSTER_I
			-- Cluster involved

feature -- Output

	put_cluster_name (st: STRUCTURED_TEXT) is
			-- Display the cluster name
		do
			if cluster.is_assembly then
				st.add_string ("Assembly cluster name: ")
			else
				st.add_string ("Cluster name: ")			
			end
			st.add_string (cluster.cluster_name)
			st.add_new_line
		end

	put_cluster_path (st: STRUCTURED_TEXT) is
			-- Display the cluster path
		do
			if cluster.is_assembly then
				st.add_string ("Assembly details: ")
			else
				st.add_string ("Cluster path: ")
			end
			cluster.format (st)
			st.add_new_line
		end

feature {AST_LACE, COMPILER_EXPORTER}

	set_cluster (c: CLUSTER_I) is
			-- Assign `c' to `cluster'.
		require
			c_not_void: c /= Void
		do
			cluster := c
		ensure
			cluster_set: cluster = c
		end

end -- class CLUSTER_ERROR
