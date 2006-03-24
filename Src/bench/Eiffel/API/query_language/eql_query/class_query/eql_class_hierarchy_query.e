indexing
	description: "Object that represents an EQL query for information of class hierarchy related to a certain compiled class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQL_CLASS_HIERARCHY_QUERY

inherit
	EQL_QUERY
		redefine
			last_result
		end

	EQL_CLASS_HIERARCHY

feature -- Result

	last_result: EQL_SCOPE_RESULT [EQL_CLASS]
			-- Last result from `execute'

feature{NONE} -- Implementation

	execute_over_single_scope (a_single_scope: EQL_SINGLE_SCOPE; a_criterion: EQL_CRITERION) is
			-- Execute over `a_single_scope' with `a_criterion'.
			-- If successful, store result in `last_result'.
		local
			l_tree_node: EQL_TREE_NODE [EQL_CLASS]
			l_class: EQL_CLASS
		do
			if a_single_scope.is_class_scope then
				l_class ?= a_single_scope
				if l_class.is_class_c_set then
						-- Only execute if `a_single_scope' is a class scope that represents a compiled class.
					create l_tree_node.make_with_data (last_result, l_class.twin)
					if processed_classes /= Void then
						processed_classes.wipe_out
					else
						create processed_classes.make (10)
					end
					rec_process_classes (l_tree_node, a_criterion)
					last_result.extend (l_tree_node)
				end
			end
		end

feature{NONE} -- Implementation

	rec_process_classes (a_tree_node: EQL_TREE_NODE [EQL_CLASS]; a_criterion: EQL_CRITERION) is
			-- process classes in `related_classes' of class information in `a_tree_node' using `a_criterion' and put them into `last_result'.
		require
			processed_classes_not_void: processed_classes /= Void
			a_criterion_not_void: a_criterion /= Void
		local
			l_class_list: LIST [CLASS_C]
			l_class: CLASS_C
			l_node: EQL_TREE_NODE [EQL_CLASS]
			l_context: EQL_CONTEXT
		do
			l_class_list := classes (a_tree_node.data.class_c)
			if not l_class_list.is_empty then
				create l_context
				from
					l_class_list.start
				until
					l_class_list.after
				loop
					l_class := l_class_list.item
					l_context.set_class_c (l_class)
					if a_criterion.evaluate (l_context) then
						if processed_classes.has (l_class) then
							a_tree_node.extend (processed_classes.item (l_class))
						else
							create l_node.make_with_data (last_result, create{EQL_CLASS}.make_with_class_c (l_class))
							a_tree_node.extend (l_node)
							processed_classes.force (l_node, l_class)
							rec_process_classes (l_node, a_criterion)
						end
					end
					l_class_list.forth
				end
			end
		end

feature{NONE} -- Implementation

	processed_classes: HASH_TABLE [EQL_TREE_NODE [EQL_CLASS], CLASS_C]
			-- List of classes which we have met before

end
