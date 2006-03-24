indexing
	description: "Object that represents a cluster item from a resultset of a certain EQL query"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_CLUSTER

inherit
	EQL_SOFTWARE_SINGLE_SCOPE
		rename
			data as cluster_i
		end


	EQL_CLUSTER_CELL
		undefine
			is_equal
		end

create
	make_with_cluster_i

feature -- Context

	context: EQL_CONTEXT is
			-- Context containing information of current
		do
			create Result.make_with_cluster_i (cluster_i)
		end

invariant
	cluster_i_not_void: cluster_i /= Void

end
