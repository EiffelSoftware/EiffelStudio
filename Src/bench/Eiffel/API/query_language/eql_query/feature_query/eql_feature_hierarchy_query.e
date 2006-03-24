indexing
	description: "Object that represents a query for hierarchy information (ancestor/descendant versions) of a feature"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EQL_FEATURE_HIERARCHY_QUERY

inherit
	EQL_QUERY
		redefine
			last_result
		end

	EQL_CLASS_HIERARCHY

feature -- Result

	last_result: EQL_SCOPE_RESULT [EQL_FEATURE]
			-- Last Result

feature{NONE} -- Implementation

	execute_over_single_scope (a_single_scope: EQL_SINGLE_SCOPE; a_criterion: EQL_CRITERION) is
			-- Execute over `a_single_scope' with `a_criterion'.
			-- If successful, store result in `last_result'.
		local
			l_feature: EQL_FEATURE
			l_tree_node: EQL_TREE_NODE [EQL_FEATURE]
			l_classes: LIST [CLASS_C]
			l_ctxt: EQL_CONTEXT
			i: INTEGER
			rout_id_set: ROUT_ID_SET
			rout_id: INTEGER
			l_feat: E_FEATURE
			c: CLASS_C
		do
			if a_single_scope.is_feature_scope then
				l_feature ?= a_single_scope
				l_classes := recursive_classes (l_feature.e_feature.associated_class)
				rout_id_set := l_feature.e_feature.rout_id_set
				create l_ctxt
				from
					i := 1;
				until
					i > rout_id_set.count
				loop
					rout_id := rout_id_set.item (i)
					l_tree_node := Void
					from
						l_classes.start
					until
						l_classes.after
					loop
						c := l_classes.item
						l_feat := c.feature_with_rout_id (rout_id)
						if l_feat /= Void then
							l_ctxt.set_e_feature (l_feat)
							if a_criterion.evaluate (l_ctxt) then
								if l_tree_node = Void then
									create l_tree_node.make (last_result)
								end
								l_tree_node.extend (create{EQL_TREE_NODE [EQL_FEATURE]}.make_with_data (last_result, create{EQL_FEATURE}.make_with_feature (l_feat)))
							end
						end
						l_classes.forth
					end
					if l_tree_node /= Void then
						last_result.extend (l_tree_node)
					end
					i := i + 1
				end
			end
		end

end
