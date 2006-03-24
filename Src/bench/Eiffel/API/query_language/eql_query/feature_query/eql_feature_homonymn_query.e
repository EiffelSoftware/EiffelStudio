indexing
	description: "Object that represents a query for homonymns of a feature"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_FEATURE_HOMONYMN_QUERY

inherit
	EQL_QUERY
		redefine
			last_result
		end

	SHARED_EIFFEL_PROJECT

feature -- Result

	last_result: EQL_SCOPE_RESULT [EQL_FEATURE]
			-- Last Result	


feature{NONE} -- Implementation

	execute_over_single_scope (a_single_scope: EQL_SINGLE_SCOPE; a_criterion: EQL_CRITERION) is
			-- Execute over `a_single_scope' with `a_criterion'.
			-- If successful, store result in `last_result'.
		local
			l_feature: EQL_FEATURE
			clusters: ARRAYED_LIST [CLUSTER_I]
			classes: HASH_TABLE [CLASS_I, STRING]
			e_class: CLASS_C
			feat: E_FEATURE
			feature_name: STRING
			class_name: STRING
			l_ctxt: EQL_CONTEXT
		do
			if a_single_scope.is_feature_scope then
				l_feature ?= a_single_scope
				feature_name := l_feature.e_feature.name
				clusters := Eiffel_universe.clusters
				create l_ctxt
				from
					clusters.start
				until
					clusters.after
				loop
					classes := clusters.item.classes;
					from
						classes.start
					until
						classes.after
					loop
						e_class := classes.item_for_iteration.compiled_class
						if e_class /= Void and e_class.has_feature_table then
							feat := e_class.feature_with_name (feature_name)
							if feat /= Void then
								l_ctxt.set_e_feature (feat)
								if a_criterion.evaluate (l_ctxt) then
									last_result.extend (
										create{EQL_TREE_NODE [EQL_FEATURE]}.make_with_data (last_result,
											create{EQL_FEATURE}.make_with_feature (feat)))
								end
							end
						end
						classes.forth
					end
					clusters.forth
				end
			end
		end

end
