note
	description: "Stores information about current rule checking."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_ANALYSIS_CONTEXT

inherit
	SHARED_SERVER

feature {CA_RULE_CHECKING_TASK} -- Current Rule Checking Context

	set_checking_class (a_class: attached CLASS_C)
			-- Sets the class that is being checked to `a_class'.
		do
			checking_class := a_class
		end

	set_node_types (a_types: attached HASH_TABLE [TYPE_A, TUPLE [node: INTEGER; written_class: INTEGER; feat: INTEGER; cl: INTEGER]])
			-- Sets the hash table mapping AST nodes to type information to `a_types'.
		do
			node_types := a_types
		end

feature {CA_RULE, CA_RULE_VIOLATION} -- Current Rule Checking Context

	checking_class: CLASS_C

	matchlist: detachable LEAF_AS_LIST
			-- The match list of the currently checked class.
		do
			if checking_class /= Void then
				Result := Match_list_server.item (checking_class.class_id)
			end
		end

	node_type (a_node: AST_EIFFEL; a_feature: detachable FEATURE_I): detachable TYPE_A
			-- Type of the AST node `a_node' from feature `a_feature' or from the current class invariant if `a_feature` is `Void`.
		local
			class_id: INTEGER
			routine_id: INTEGER
		do
			if attached a_feature then
					-- Regular feature.
				class_id := a_feature.written_class.class_id
				routine_id := a_feature.rout_id_set.first
			elseif attached checking_class as c then
					-- Class invariant.
				class_id := c.class_id
				routine_id := if attached c.invariant_feature as f then f.rout_id_set.first else 0 end
			end
			if routine_id /= 0 then
				Result := node_types [[a_node.index, class_id, routine_id, class_id]]
			end
		end

feature {NONE} -- Current Rule Checking Context

	node_types: HASH_TABLE [TYPE_A, TUPLE [node: INTEGER; written_class: INTEGER; feat: INTEGER; cl: INTEGER]]
			-- Type of the AST node `node' written in class
			-- `written_class' when evaluated in a feature `feature' of class
			-- `class'.

end
