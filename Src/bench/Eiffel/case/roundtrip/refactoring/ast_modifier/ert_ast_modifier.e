indexing
	description: "Object for modifying text of an AST node"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ERT_AST_MODIFIER

feature -- Applicability

	can_apply: BOOLEAN is
			-- Can current modifier be applied?
		deferred
		end

	applied: BOOLEAN
			-- Has current modifier been applied?

	apply is
			-- Apply current modifier.
		require
			can_apply: can_apply
			modifier_not_applied: not applied
		deferred
		ensure
			modifier_applied: applied
		end

feature{NONE} -- Implementation

	match_list: LEAF_AS_LIST
			-- Match list used by roundtrip

invariant
	match_list_not_void: match_list /= Void

end
