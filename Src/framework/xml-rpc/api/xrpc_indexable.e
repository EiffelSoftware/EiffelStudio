note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XRPC_INDEXABLE [G -> HASHABLE]

inherit
	XRPC_VALUE

feature -- Access

	linear_representation: LINEAR [XRPC_VALUE]
			-- Linear representation of Current's items.
		deferred
		ensure
			result_attached: attached Result
			result_consistent: Result = linear_representation
		end

feature -- Measurement

	count: NATURAL
			-- Number of items in Current
		deferred
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Indicates if Current holds no items.
		do
			Result := count = 0
		ensure
			count_positive: not Result implies count > 0
		end

	is_valid: BOOLEAN
			-- <Precursor>
		local
			l_items: like linear_representation
			l_cursor: detachable CURSOR
		do
			Result := True
			l_items := linear_representation
			if attached {CURSOR_STRUCTURE [XRPC_VALUE]} l_items as l_cs then
				l_cursor := l_cs.cursor
			end
			from l_items.start until l_items.after or not Result loop
				Result := attached l_items.item_for_iteration as l_item and then l_item.is_valid
				l_items.forth
			end
			if attached {CURSOR_STRUCTURE [XRPC_VALUE]} l_items as l_cs then
				check l_cursor_attached: attached l_cursor end
				l_cs.go_to (l_cursor)
			end
		ensure then
			linear_representation_unmoved: linear_representation.index ~ old linear_representation.index
		end

	is_valid_index (a_index: G): BOOLEAN
			-- Determines if a given index is valid for Current.
			--
			-- `a_index': An index to determin validity for.
		deferred
		end

feature -- Query

	item alias "[]" (a_index: G): XRPC_VALUE
			-- Retrieve a value from a member name.
			--
			-- `a_index': The index/name of member to retrieve the value for.
			-- `Result': A XML RPC value.
		require
			is_valid: is_valid
			a_index_is_valid_index: is_valid_index (a_index)
		deferred
		end

--feature -- Status report

--	has_member (a_name: READABLE_STRING_8): BOOLEAN
--			-- Detemines if the struct has a member.
--			--
--			-- `a_name': Name of the member.
--			-- `Result': True if the stuct has the member; False otherwise.
--		require
--			a_name_attached: attached a_name
--			not_a_name_is_empty: not a_name.is_empty
--		do
--			Result := internal_members.has (a_name)
--		ensure
--			internal_members_has_a_name: Result implies internal_members.has (a_name)
--		end

--feature -- Extension

--	put (a_value: XRPC_VALUE; a_name: READABLE_STRING_8)
--			--
--		require
--			a_value_attached: attached a_value
--			a_name_attached: attached a_name
--			not_a_name_is_empty: not a_name.is_empty
--		do
--			internal_members.force (a_value, a_name.string)
--		ensure
--			has_member_a_name: has_member (a_name)
--			item_set: item (a_name) = a_value
--		end

--feature -- Basic operations: Visitor

--	visit (a_visitor: XRPC_VISITOR)
--			-- <Precursor>
--		do
--			a_visitor.process_struct (Current)
--		end

--feature {NONE} -- Implementation: Internal cache

--	internal_members: HASH_TABLE [XRPC_VALUE, READABLE_STRING_8]
--			-- Mutable version of `members'

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
