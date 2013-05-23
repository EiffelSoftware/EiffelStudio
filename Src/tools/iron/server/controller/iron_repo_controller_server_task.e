note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	IRON_REPO_CONTROLLER_SERVER_TASK

inherit
	IRON_REPO_CONTROLLER_TASK

create
	default_create,
	make_with_connector

feature {NONE} -- Initialization

	make_with_connector (a_conn: READABLE_STRING_8)
		do
			connector := a_conn
		end

feature -- Access

	name: STRING = "server"

	connector: detachable READABLE_STRING_8

feature -- Execution

	is_available (iron: IRON_REPO): BOOLEAN
		do
			Result := iron.is_available
		end

	execute (iron: IRON_REPO)
		local
			server: detachable IRON_REPO_SERVER
		do
			if attached connector as conn then
				if conn.is_case_insensitive_equal ("cgi") then
					create server.make_and_launch_cgi (iron)
				elseif conn.is_case_insensitive_equal ("libfcgi") then
					create server.make_and_launch_libfcgi (iron)
				end
			end
			if server = Void then
				create server.make_and_launch (iron)
			end

		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
