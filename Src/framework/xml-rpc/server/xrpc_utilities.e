note
	description: "[
		General purpose utilized for use with XML-RPC.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XRPC_UTILITIES

feature -- Access

	namespace_separator: CHARACTER = '.'
			-- Separator used to segregate namespaces.

feature -- Query

	full_method_name (a_name: READABLE_STRING_8; a_delegate: XRPC_DELEGATE): STRING_32
			-- Retrieves the full name of a method call, using the supplied delegate.
			--
			-- `a_name': A method name.
			-- `a_delegate': The object the method will be delegated to.
			-- `Result': The full name of the method.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			a_delegate_attached: attached a_delegate
		local
			l_prefix: detachable IMMUTABLE_STRING_32
		do
			l_prefix := a_delegate.namespace
			if attached l_prefix and then not l_prefix.is_empty then
				create Result.make (1 + l_prefix.count + a_name.count)
				Result.append (l_prefix)
				Result.append_character (namespace_separator)
				Result.append (a_name)
			else
				create Result.make_from_string (a_name)
			end
		end

	split_method_name (a_name: READABLE_STRING_32): TUPLE [name: STRING_32; namespace: detachable STRING_32]
			-- Splits a full method name into its [namespace.]name parts.
			--
			-- `a_name': The full method name.
			-- `Result': The method name and its namespace, if it has one.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
		local
			l_count, i: INTEGER
			l_string: STRING_32
		do
			l_count := a_name.count
			i := a_name.last_index_of ('.', a_name.count)
			if i > 1 and then i < l_count then
				l_string := a_name.string
				Result := [l_string.substring (i + 1, l_count), l_string.substring (1, i - 1)]
			else
				Result := [create {STRING_32}.make_from_string (a_name), Void]
			end
		ensure
			result_attached: attached Result
			result_name_attached: attached Result.name
			not_result_name_is_empty: not Result.name.is_empty
			not_result_namespace_is_empty: attached Result.namespace as l_namespace implies not l_namespace.is_empty
		end

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
