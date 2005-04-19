indexing
	description: "Get unique constant of ATOMIC_AS nodes"
	date: "$Date$"
	revision: "$Revision$"

class
	AST_UNIQUE_CONSTANT

inherit
	AST_NULL_VISITOR
		redefine
			process_static_access_as,
			process_id_as
		end

feature -- Access

	unique_constant (a_feat_tbl: FEATURE_TABLE; a_node: ATOMIC_AS): UNIQUE_I is
			-- Associated UNIQUE_I instance of `a_node' if `a_node' represents a unique constant.
		require
			a_feat_tbl_not_void: a_feat_tbl /= Void
		do
			current_feature_table := a_feat_tbl
			a_node.process (Current)
			Result := last_unique_constant
			last_unique_constant := Void
			current_feature_table := Void
		end

feature {NONE} -- Implementation

	last_unique_constant: UNIQUE_I
			-- Last computed unique constant

	current_feature_table: FEATURE_TABLE
			-- Feature table in which we resolve `unique_constant'

	process_static_access_as (l_as: STATIC_ACCESS_AS) is
		do
			last_unique_constant ?= current_feature_table.item (l_as.feature_name)
		end

	process_id_as (l_as: ID_AS) is
		do
			last_unique_constant ?= current_feature_table.item (l_as)
		end

end
