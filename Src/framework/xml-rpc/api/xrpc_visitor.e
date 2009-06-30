note
	description: "[
		Visitor pattern implementation for visiting XML-RPC types.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XRPC_VISITOR

feature -- Processing operations

	process_array (a_array: XRPC_ARRAY)
			-- Processes a XML-RPC array.
			--
			-- `a_array': An array to process.
		require
			a_array_attached: attached a_array
		local
			i, nb: NATURAL
		do
			from
				i := 1
				nb := a_array.count
			until
				i > nb
			loop
				if attached a_array[i] as l_item then
					l_item.visit (Current)
				end
				i := i +1
			end
		end

	process_boolean (a_boolean: XRPC_BOOLEAN)
			-- Processes a XML-RPC boolean.
			--
			-- `a_boolean': A boolean to process.
		require
			a_boolean_attached: attached a_boolean
		do
		end

	process_double (a_double: XRPC_DOUBLE)
			-- Processes a XML-RPC double.
			--
			-- `a_double': A double to process.
		require
			a_double_attached: attached a_double
		do
		end

	process_integer (a_integer: XRPC_INTEGER)
			-- Processes a XML-RPC integer.
			--
			-- `a_integer': An integer to process.
		require
			a_integer_attached: attached a_integer
		do
		end

	process_member (a_member: XRPC_MEMBER)
			-- Processes a XML-RPC struct member.
			--
			-- `a_member': A member to process.
		require
			a_member_attached: attached a_member
		do
			a_member.value.visit (Current)
		end

	process_string (a_string: XRPC_STRING)
			-- Processes a XML-RPC string.
			--
			-- `a_string': A string to process.
		require
			a_string_attached: attached a_string
		do
		end

	process_struct (a_struct: XRPC_STRUCT)
			-- Processes a XML-RPC struct.
			--
			-- `a_struct': A struct to process.
		require
			a_struct_attached: attached a_struct
		local
			l_members: LINEAR [XRPC_MEMBER]
		do
			l_members := a_struct.members
			from l_members.start until l_members.after loop
				if attached l_members.item as l_member then
					l_member.visit (Current)
				end
				l_members.forth
			end
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
