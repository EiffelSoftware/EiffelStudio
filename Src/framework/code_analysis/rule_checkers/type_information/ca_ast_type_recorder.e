note
	description: "Records type information for classes."
	author: "Stefan Zurfluh"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_AST_TYPE_RECORDER

inherit
	SHARED_AST_CONTEXT

	SHARED_STATELESS_VISITOR

create
	make

feature {NONE} -- Initialization

	make
		do
			create node_types.make (100)
		end

feature -- AST Type Analysis

	clear
			-- Clears the recorded type information.
		do
			node_types.wipe_out
		end

	analyze_class (a_class: attached CLASS_C)
			-- Analyzes `a_class' and records the type information of its AST nodes.
		do
			prepare_for_class (a_class)
			across a_class.written_in_features as l_features loop
				internal_analyze_feature (l_features.item.associated_feature_i, a_class)
			end
		end

	analyze_feature (a_feature: attached FEATURE_I; a_class: attached CLASS_C)
			-- Analyzes `a_feature' from `a_class' and records the type information of its AST child
			-- nodes.
		do
			prepare_for_class (a_class)
			internal_analyze_feature (a_feature, a_class)
		end

	type_of_node (a_node: AST_EIFFEL; a_written_class: CLASS_C; a_feature: FEATURE_I; a_class: CLASS_C): TYPE_A
			-- Retrieves the type of the AST node `a_node' written in class
			-- `a_written_class' when evaluated in a feature `a_feature' of class
			-- `a_class'.
		do
			Result := node_types [[a_node.index, a_written_class.class_id, a_feature.rout_id_set.first, a_class.class_id]]
		end

	node_types: HASH_TABLE [TYPE_A, TUPLE [node: INTEGER; written_class: INTEGER; feat: INTEGER; cl: INTEGER]]
		-- Type of the AST node `node' written in class
		-- `written_class' when evaluated in a feature `feature' of class
		-- `class'.

feature {NONE} -- Implementation

	prepare_for_class (a_class: attached CLASS_C)
			-- Initializes type check for class `a_class'.
		do
			context.initialize (a_class, a_class.actual_type)
			feature_checker.init (context)
			feature_checker.set_type_recorder (agent record_node_type)
		end

	internal_analyze_feature (a_feature: attached FEATURE_I; a_class: attached CLASS_C)
			-- Analyzes feature `a_feature' from class `a_class'.
		do
			context.clear_feature_context
			context.initialize (a_class, a_class.actual_type)
			context.set_current_feature (a_feature)
			context.set_written_class (a_feature.written_class)
			feature_checker.type_check_only (a_feature, True, a_feature.written_in /= a_class.class_id, a_feature.is_replicated_directly)
		end

feature {NONE} -- Implementation: Data Structures

	record_node_type (a_type: TYPE_A; a_node: detachable AST_EIFFEL; a_written_class: CLASS_C; a_feature: FEATURE_I; a_class: CLASS_C)
			-- Record type `a_type' of AST node `a_node' written in class `a_written_class'
			-- when evaluated in a feature `a_feature' of class `a_class'.
		do
			if a_node /= Void then
				node_types [[a_node.index, a_written_class.class_id, a_feature.rout_id_set.first, a_class.class_id]] := a_type
			end
		end

end
