note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XRPC_VALUE

feature -- Access

	type: XRPC_TYPE
			-- Actual type of the value.
		deferred
		end

feature -- Status report

	is_valid: BOOLEAN
			-- Indicates if the set value is valid.
			-- This is useful in determining if a value was incorrectly defined in the RPC
		deferred
		end

	is_integral: BOOLEAN
			-- Indicates if the value is a integral value.
		do
			Result := type.is_integral
		ensure
			not_is_complex: Result implies not is_complex
			type_is_integral: Result implies type.is_integral
		end

	is_complex: BOOLEAN
			-- Indicates if the value is a complex (non-integral) value.
		do
			Result := type.is_complex
		ensure
			not_is_integral: Result implies not is_integral
			type_is_complex: Result implies type.is_complex
		end

feature -- Basic operations: Visitor

	visit (a_visitor: XRPC_VISITOR)
			-- Visits the current node and processes it, via the visitor.
		require
			a_vistor_attached: attached a_visitor
			is_valid: is_valid
		deferred
		end

;note
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
