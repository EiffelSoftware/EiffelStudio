note
	description	: "A factory to build byte nodes for multi-branch expressions."

class MULTI_BRANCH_EXPRESSION_FACTORY

inherit
	MULTI_BRANCH_FACTORY

feature -- Factory

	new_construct (e: EXPR_B; a: INSPECT_ABSTRACTION_AS [CASE_ABSTRACTION_AS [detachable AST_EIFFEL], detachable AST_EIFFEL]): INSPECT_EXPRESSION_B
			-- <Precursor>
		do
			create Result.make (e)
		end

	new_case_list (n: like new_case_list.count): BYTE_LIST [CASE_EXPRESSION_B]
			-- <Precursor>
		do
			create Result.make (n)
		end

	new_case (i: BYTE_LIST [INTERVAL_B]; b: BYTE_NODE): CASE_EXPRESSION_B
			-- <Precursor>
		do
			if attached {EXPR_B} b as e then
				create Result.make (i, e)
			end
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
