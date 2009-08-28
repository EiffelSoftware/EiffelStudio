note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	DEMOAPPLICATION_CONTROLLER

inherithalo?

	ANY
		undefine
			default_create
		end

	G_SHARED_DEMOAPPLICATION_GLOBAL_STATE
		undefine
			default_create
		end

	XWA_CONTROLLER


create

	default_create

feature {NONE} -- Initialization	

feature -- Status Repost

	authenticated: BOOLEAN
			-- Tests if session contains authenticated flag.
		do
			Result := False
			if attached session.item ("auth") as item then
				Result := True
			end
		end

	authenticated_admin: BOOLEAN
			-- Tests if session contains authenticated flag and user is admin
		do
			Result := False
			if attached {USER} session.item ("auth") as session_user then
				if session_user.is_admin then
					Result := True
				end
			end
		end

	not_authenticated: BOOLEAN
			-- Helper
		do
			Result := not authenticated
		end

	not_authenticated_admin: BOOLEAN
			-- Helper
		do
			Result := not authenticated_admin
		end

	username: STRING
			-- Gets username of logged in user
		do
			Result := ""
			if attached {USER} session.item ("auth") as user then
				Result := user.name
			end

		ensure
			Result_attached: Result /= Void
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
