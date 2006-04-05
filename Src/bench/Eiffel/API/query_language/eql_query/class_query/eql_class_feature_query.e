indexing
	description: "Object that represents an EQL query for certain features in a class"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQL_CLASS_FEATURE_QUERY

inherit
	EQL_QUERY
		redefine
			last_result
		end

feature -- Result

	last_result: EQL_SCOPE_RESULT [EQL_FEATURE]

feature{NONE} -- Implementation

	execute_over_single_scope (a_single_scope: EQL_SINGLE_SCOPE; a_criterion: EQL_CRITERION) is
			-- Execute over `a_single_scope' with `a_criterion'.
			-- If successful, store result in `last_result'.
		local
			l_class: EQL_CLASS
			feature_table: E_FEATURE_TABLE
			l_context: EQL_CONTEXT
			e_feature: E_FEATURE
		do
			if a_single_scope.is_class_scope then
				l_class ?= a_single_scope
				if l_class.is_class_c_set then
						-- Only execute if `a_single_scope' is a class scope that represents a compiled class.
					feature_table := l_class.class_c.api_feature_table
					if feature_table /= Void then
						create l_context.default_create
						from
							feature_table.start
						until
							feature_table.after
						loop
							e_feature := feature_table.item_for_iteration
							l_context.set_e_feature (e_feature)
							if a_criterion.evaluate (l_context) then
								last_result.extend (create {EQL_TREE_NODE [EQL_FEATURE]}.make_with_data (last_result,  create{EQL_FEATURE}.make_with_feature (e_feature)))
							end
							feature_table.forth
						end
					end
				end
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end
