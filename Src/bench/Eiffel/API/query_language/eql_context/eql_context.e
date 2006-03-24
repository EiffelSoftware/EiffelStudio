indexing
	description: "Object that represents a context used in an EQL query"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_CONTEXT

inherit
	EQL_FEATURE_CELL

	EQL_CLASS_CELL

	EQL_CLUSTER_CELL

	EQL_SYSTEM_CELL

	EQL_INVARIANT_CELL

create
	default_create,
	make_with_feature,
	make_with_class_c,
	make_with_class_i,
	make_with_cluster_i,
	make_with_system_i,
	make_with_invariant

end
