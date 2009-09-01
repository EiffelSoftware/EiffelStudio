note
	description: "[
		no comment yet
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	USER

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER; a_name: STRING; a_password: STRING; a_is_admin: BOOLEAN)
			-- Initialization for `Current'.
		require
			not_a_password_is_detached_or_empty: a_password /= Void and then not a_password.is_empty
			not_a_name_is_detached_or_empty: a_name /= Void and then not a_name.is_empty
		do
			id := a_id
			name:= a_name
			password:= a_password
			is_admin:= a_is_admin
		ensure
			name_attached: name /= Void
			password_attached: password /= Void
		end

feature -- Access

	id: INTEGER
	name: STRING
	password: STRING
	is_admin: BOOLEAN

invariant
	name_attached: name /= Void
	password_attached: password /= Void
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
