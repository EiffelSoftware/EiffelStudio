note
	description: "[
		{XEL_EXPRESSION}.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XEL_EXPRESSION

inherit
	XEL_SERVLET_ELEMENT

feature -- Initialization

	make (a_expr: STRING)
		require
			a_expr_valid: attached a_expr and then not a_expr.is_empty
		do
			expr := a_expr
		ensure
			expr_attached: attached expr
			expr_set: expr = a_expr
		end

feature -- Access

	expr: STRING
			-- The expression which should be printed

feature -- Implementation

	serialize (a_buf: XU_INDENDATION_FORMATTER)
			-- <Precursor>
		do
			a_buf.put_string ("response.append (" + expr_for_concatenation + ")")
		end

	is_plain_string: BOOLEAN
			-- Does statement just output strings to the response?
		do
			Result := False
		end

	expr_for_concatenation: STRING
			-- Formatted expression to be added in the append feature of the response
		deferred
		ensure
			result_attached: attached Result
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
