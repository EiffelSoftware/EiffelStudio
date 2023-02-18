note
	description: "[
		A XML-RPC struct {XRPC_STRUCT} member.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_MEMBER

inherit
	XRPC_VALUE

	DEBUG_OUTPUT

create
	make,
	make_with_value

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_32)
			-- Initializes a struct member with a name.
			--
			-- `a_name': Name of the member.
		require
			a_name_attached: attached a_name
		do
			create name.make_from_string (a_name)
		ensure
			name_set: name.same_string (a_name)
		end

	make_with_value (a_name: READABLE_STRING_32; a_value: like value)
			-- Initializes a struct member with a name and value.
			--
			-- `a_name': Name of the member.
			-- `a_value': Value associated with the member.
		require
			a_name_attached: attached a_name
			a_value_attached: attached a_value
		do
			make (a_name)
			value := a_value
		ensure
			name_set: name.same_string (a_name)
			value_set: value ~ a_value
		end

feature -- Access

	name: IMMUTABLE_STRING_32
			-- Member name.

	value: XRPC_VALUE assign set_value
			-- Member value.
		attribute
			create {XRPC_DEFAULT_VALUE} Result
		end

	type: XRPC_TYPE
			-- <Precursor>
		do
			Result := {XRPC_TYPE}.member
		end

feature -- Element change

	set_value (a_value: like value)
			-- Sets a new value for the member.
			--
			-- `a_value': A new value.
		require
			a_value_attached: attached a_value
		do
			value := a_value
		ensure
			value_set: value ~ a_value
		end

feature -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		do
			Result := not name.is_empty and then value.is_valid
		ensure then
			not_name_is_empty: Result implies not name.is_empty
			value_is_valid: Result implies value.is_valid
		end

feature -- Status report

	debug_output: STRING_32
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make_from_string ("name=" + name)
		end

feature -- Basic operations: Visitor

	visit (a_visitor: XRPC_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_member (Current)
		end

invariant
	name_attached: name /= Void

;note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
