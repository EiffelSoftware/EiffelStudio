indexing
	description: "Object that query for supplier classes of a class"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_CLASS_SUPPLIER_QUERY

inherit
	EQL_QUERY
		redefine
			last_result
		end


feature -- Result

	last_result: EQL_SCOPE_RESULT [EQL_CLASS]
			-- Last result		

feature{NONE} -- Implementation

	execute_over_single_scope (a_single_scope: EQL_SINGLE_SCOPE; a_criterion: EQL_CRITERION) is
			-- Execute over `a_single_scope' with `a_criterion'.
			-- If successful, store result in `last_result'.
		local
			l_class: EQL_CLASS
			l_suppliers: LIST [CLASS_C]
			l_context: EQL_CONTEXT
		do
			if a_single_scope.is_class_scope  then
				l_class ?= a_single_scope
				if l_class.is_class_c_set then
					l_suppliers := l_class.class_c.suppliers.classes
					create l_context
					from
						l_suppliers.start
					until
						l_suppliers.after
					loop
						l_context.set_class_c (l_suppliers.item)
						if a_criterion.evaluate (l_context) then
							last_result.extend (create {EQL_TREE_NODE [EQL_CLASS]}.make_with_data (last_result, create {EQL_CLASS}.make_with_class_c (l_suppliers.item)))
						end
						l_suppliers.forth
					end
				end
			end
		end


end
