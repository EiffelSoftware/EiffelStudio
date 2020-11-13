note
	description: "Summary description for {ACCOUNT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ACCOUNT

create
	make

feature {NONE} -- Creation

	make (a_username: READABLE_STRING_GENERAL)
		do
			create username.make_from_string_general (a_username)
		end

feature -- Access

	username: IMMUTABLE_STRING_32

	user_id: INTEGER_64

	access_token: detachable ES_ACCOUNT_ACCESS_TOKEN

feature -- Status report

	is_expired: BOOLEAN
		do
			if attached access_token as tok then
				Result := tok.is_expired
			else
				Result := True
			end
		end

feature -- Element change

	set_access_token (tok: detachable ES_ACCOUNT_ACCESS_TOKEN)
		do
			access_token := tok
		end

	set_user_id (uid: INTEGER_64)
		do
			user_id := uid
		end

feature -- Comparison

	same_as	(other: detachable ES_ACCOUNT): BOOLEAN
		do
			if other /= Void then
				Result := username.same_string (other.username)
			end
		end

;note
	copyright: "Copyright (c) 1984-2020, Eiffel Software"
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
