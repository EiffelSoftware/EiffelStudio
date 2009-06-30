note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	XRPC_STRUCT

inherit
	XRPC_VALUE

create
	make

feature {NONE} -- Initailization

	make
			-- Initialize the struct.
		do
			create internal_members.make (3)
			internal_members.compare_objects
		end

feature -- Access

	members: ARRAY [READABLE_STRING_8]
			-- Names of all the members in the struct.
		do
			Result := internal_members.current_keys
		ensure
			result_attached: attached Result
		end

feature -- Access

	type: XRPC_TYPE
			-- <Precursor>
		once
			Result := {XRPC_TYPE}.struct
		end

feature -- Status report

	is_valid: BOOLEAN
			-- <Precursor>
		local
			l_members: like internal_members
			l_cursor: CURSOR
		do
			Result := True
			l_members := internal_members
			l_cursor := l_members.cursor
			from l_members.start until l_members.after or not Result loop
				Result := attached l_members.item_for_iteration as l_item and then l_item.is_valid
				l_members.forth
			end
			l_members.go_to (l_cursor)
		ensure then
			internal_members_unmoved: internal_members.cursor ~ old internal_members.cursor
		end

feature -- Query

	item (a_name: READABLE_STRING_8): XRPC_VALUE
			-- Retrieve a value from a member name.
			--
			-- `a_name': The name of member to retrieve the value for.
			-- `Result': A XML RPC value.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
			has_member_a_name: has_member (a_name)
		local
			l_result: detachable XRPC_VALUE
		do
			l_result := internal_members.item (a_name)
			check l_result_attached: attached l_result end
			Result := l_result
		end

feature -- Status report

	has_member (a_name: READABLE_STRING_8): BOOLEAN
			-- Detemines if the struct has a member.
			--
			-- `a_name': Name of the member.
			-- `Result': True if the stuct has the member; False otherwise.
		require
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
		do
			Result := internal_members.has (a_name)
		ensure
			internal_members_has_a_name: Result implies internal_members.has (a_name)
		end

feature -- Extension

	put (a_value: XRPC_VALUE; a_name: READABLE_STRING_8)
			--
		require
			a_value_attached: attached a_value
			a_name_attached: attached a_name
			not_a_name_is_empty: not a_name.is_empty
		do
			internal_members.force (a_value, a_name.string)
		ensure
			has_member_a_name: has_member (a_name)
			item_set: item (a_name) = a_value
		end

feature -- Basic operations: Visitor

	visit (a_visitor: XRPC_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_struct (Current)
		end

feature {NONE} -- Implementation: Internal cache

	internal_members: HASH_TABLE [XRPC_VALUE, READABLE_STRING_8]
			-- Mutable version of `members'

invariant
	internal_members_attached: attached internal_members
	internal_members_object_comparison: internal_members.object_comparison
	is_complex: is_complex

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
