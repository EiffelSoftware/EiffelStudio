indexing
	description: "Internal representation of an override cluster"
	date: "$Date$"
	revision: "$Revision$"

class
	OVERRIDE_I

inherit
	CONF_OVERRIDE
		rename
			name as cluster_name,
			parent as parent_cluster,
			children as sub_clusters
		redefine
			classes,
			parent_cluster,
			sub_clusters
		end

	CLUSTER_I
		undefine
			process,
			is_group_equivalent,
			is_override
		redefine
			classes,
			parent_cluster,
			sub_clusters
		end

create
	make

feature -- Attributes

	classes: HASH_TABLE [EIFFEL_CLASS_I, STRING]
			-- Classes available in the cluster: key is the declared
			-- name and entry is the class

	parent_cluster: CLUSTER_I
			-- Parent cluster of Current cluster
			-- (Void implies it is a top level cluster)

	sub_clusters: ARRAYED_LIST [CLUSTER_I]
			-- List of sub clusters for Current cluster

end
