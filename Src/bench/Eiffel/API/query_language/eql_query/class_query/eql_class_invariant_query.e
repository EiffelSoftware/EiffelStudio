indexing
	description: "Object that represents a query for (direct and indirect) invariant parts of a classes"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_CLASS_INVARIANT_QUERY
inherit
	EQL_QUERY
		redefine
			last_result
		end

	EQL_CLASS_ANCESTORS

feature -- Result

	last_result: EQL_SCOPE_RESULT [EQL_INVARIANT]
			-- Last result

feature{NONE} -- Implementation

	execute_over_single_scope (a_single_scope: EQL_SINGLE_SCOPE; a_criterion: EQL_CRITERION) is
			-- Execute over `a_single_scope' with `a_criterion'.
			-- If successful, store result in `last_result'.
		local
			l_class: EQL_CLASS
			l_list: LIST [CLASS_C]
			l_inv: INVARIANT_AS
			l_class_c: CLASS_C
		do
			if a_single_scope.is_class_scope then
				l_class ?= a_single_scope
				if l_class.is_class_c_set then
					l_list := recursive_classes (l_class.class_c)
					if not l_list.is_empty then
						from
							l_list.start
						until
							l_list.after
						loop
							l_class_c := l_list.item
							if l_class_c /= Void then
								l_inv := l_list.item.invariant_ast
								if l_inv /= Void then
									last_result.extend (
										create {EQL_TREE_NODE [EQL_INVARIANT]}.make_with_data (last_result,
											create{EQL_INVARIANT}.make_with_invariant (l_inv)))

								end
							end
							l_list.forth
						end
					end
				end
			end
		end

end
