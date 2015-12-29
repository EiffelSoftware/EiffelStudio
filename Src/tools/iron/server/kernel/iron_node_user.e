note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	IRON_NODE_USER

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (u: like name)
			-- Initialize `Current'.
		require
			u_is_not_empty: not u.is_empty
		do
			name := u
		end

feature -- Access

	name: READABLE_STRING_32

	password: detachable READABLE_STRING_32

	email: detachable READABLE_STRING_32

	is_administrator: BOOLEAN
			-- Is considered as administrator?

	roles: detachable LIST [IRON_NODE_USER_ROLE]
			-- Associated user roles.

	data: detachable STRING_TABLE [detachable ANY]
			-- Related data

	removed_data: detachable ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- Removed data

	data_item (k: READABLE_STRING_GENERAL): detachable ANY
		do
			if attached data as l_data then
				Result := l_data.item (k)
			end
		end

feature -- Status report

	same_user (other: IRON_NODE_USER): BOOLEAN
			-- Is other same user as Current?
		do
			Result := name.is_case_insensitive_equal (other.name)
		end

	debug_output: READABLE_STRING_GENERAL
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := name
		end

feature -- Change

	set_password (p: like password)
		do
			password := p
		end

	set_email (v: like email)
		do
			email := v
		end

	set_is_administrator (b: BOOLEAN)
		do
			is_administrator := b
		end

	add_role (r: IRON_NODE_USER_ROLE)
		local
			l_roles: like roles
		do
			l_roles := roles
			if l_roles = Void then
				create {ARRAYED_LIST [IRON_NODE_USER_ROLE]} l_roles.make (1)
				l_roles.compare_objects
				roles := l_roles
			end
			l_roles.extend (r)
			if r.name.is_case_insensitive_equal ("administrator") then
				set_is_administrator (True)
			end
		end

	remove_role (r: IRON_NODE_USER_ROLE)
		local
			l_roles: like roles
		do
			l_roles := roles
			if l_roles /= Void then
				check l_roles.object_comparison end
				l_roles.prune_all (r)
			end
			if r.name.is_case_insensitive_equal ("administrator") then
				set_is_administrator (False)
			end
		end

	set_data_item (k: READABLE_STRING_GENERAL; d: like data_item)
		local
			l_data: like data
		do
			l_data := data
			if l_data = Void then
				create l_data.make (1)
				data := l_data
			end
			l_data.force (d, k)
		end

	remove_data_item (k: READABLE_STRING_GENERAL)
		local
			l_removed_data: like removed_data
		do
			if attached data as l_data then
				l_data.remove (k)
				l_removed_data := removed_data
				if l_removed_data = Void then
					create l_removed_data.make (1)
					removed_data := l_removed_data
				end
				l_removed_data.force (k)
			end
		end

invariant
	name_is_not_empty: not name.is_empty

note
	copyright: "Copyright (c) 1984-2015, Eiffel Software"
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
