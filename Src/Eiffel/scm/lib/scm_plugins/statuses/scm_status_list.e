note
	description: "Summary description for {SCM_STATUS_LIST}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SCM_STATUS_LIST

inherit
	ARRAYED_LIST [SCM_STATUS]

create
	make

feature -- Status

	changes_count: INTEGER
		do
			Result := count - unversioned_count
		end

	unversioned_count: INTEGER
		do
			across
				Current as ic
			loop
				if attached {SCM_STATUS_UNVERSIONED} ic.item then
					Result := Result + 1
				end
			end
		end

	status (p: PATH): detachable SCM_STATUS
		do
			across
				Current as ic
			until
				Result /= Void
			loop
				if ic.item.location.same_as (p) then
					Result := ic.item
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
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
end
