note
	description: "[
		Login controller
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_CONTROLLER

inherit
	XWA_CONTROLLER

create
	default_create

feature {NONE} -- Access

feature -- Access

	is_logged_in: BOOLEAN
			-- Is a user logged in?
		do
			Result := attached session as l_current and then attached l_current.item (authentication_key)
		end

	is_not_logged_in: BOOLEAN
			-- Is a user not logged in?
		do
			Result := not is_logged_in
		end

	login
		do
			if attached session as l_current then
				l_current.put ("user", authentication_key)
			end
		end

	logout
		do
			if attached session as l_current then
				l_current.remove (authentication_key)
			end
		end

	user_name: STRING
		do
			Result := "UserTodo"
		end

feature -- Constants

	authentication_key: STRING = "auth"

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
