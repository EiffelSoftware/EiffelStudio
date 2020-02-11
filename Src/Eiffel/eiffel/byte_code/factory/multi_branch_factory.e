note
	description	: "An abstract factory to build byte nodes for multi-branch constructs."

deferred class MULTI_BRANCH_FACTORY

feature -- Factory

	new_construct (e: EXPR_B; a: INSPECT_ABSTRACTION_AS [CASE_ABSTRACTION_AS [detachable AST_EIFFEL], detachable AST_EIFFEL]): ABSTRACT_INSPECT_B [ABSTRACT_CASE_B [BYTE_NODE], BYTE_NODE]
			-- Create a new byte node for an inspect construct with inspect expression `e`
			-- based on the AST construct `a`.
		deferred
		end

	new_case_list (n: like new_case_list.count): BYTE_LIST [ABSTRACT_CASE_B [BYTE_NODE]]
			-- Create a list of case byte nodes with estimated number of nodes `n`.
		deferred
		end

	new_case (i: BYTE_LIST [INTERVAL_B]; b: detachable BYTE_NODE): ABSTRACT_CASE_B [BYTE_NODE]
			-- Create a new byte node for a multi-branch case with intervals specified by `i`
			-- and associated content `b`.
		deferred
		end

note
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
