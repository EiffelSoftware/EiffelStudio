indexing
	description: "Object that represents a composite metric scope"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_METRIC_COMPOSITE_SCOPE

inherit
	EQL_COMPOSITE_SCOPE
		undefine
			copy,
			is_equal
		end

	EQL_TREE_NODE [EQL_METRIC_SINGLE_SCOPE]

end
