indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_CLUSTER_I

inherit
	CLUSTER_I
		undefine
			process,
			is_test_cluster
		redefine
			parent_cluster,
			sub_clusters
		end

	CONF_TEST_CLUSTER
		rename
			name as cluster_name,
			parent as parent_cluster,
			children as sub_clusters
		redefine
			parent_cluster,
			sub_clusters
		end

create
	make

feature -- Access

	parent_cluster: CLUSTER_I
			-- <Precursor>

	sub_clusters: ARRAYED_LIST [CLUSTER_I]
			-- <Precursor>

end
