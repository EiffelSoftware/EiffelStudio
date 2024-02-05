note
	description: "[
			Client representation of the cloud sign-in challenge (see associated CMS)."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_SIGN_IN_REQUEST

create
	make

feature {NONE} -- Initialization

	make (a_client_id, a_sign_in_url, a_sign_in_request_url: READABLE_STRING_8; a_expiration_date: detachable DATE_TIME)
		do
			client_id := a_client_id
			sign_in_url := a_sign_in_url
			sign_in_request_url := a_sign_in_request_url
			expiration_date := a_expiration_date
		end

feature -- Access

	sign_in_url: IMMUTABLE_STRING_8

	sign_in_request_url: IMMUTABLE_STRING_8

	expiration_date: detachable DATE_TIME

	client_id: IMMUTABLE_STRING_8

feature -- Status	

	is_approved: BOOLEAN
		do
			Result := approved_account /= Void
		end

	has_error: BOOLEAN
		do
			Result := error_message /= Void
		end

feature -- Access/ results

	approved_account: detachable ES_ACCOUNT

	error_message: detachable IMMUTABLE_STRING_32

feature -- Element change

	report_error (m: READABLE_STRING_GENERAL)
		do
			error_message := m
		ensure
			has_error
		end

	mark_is_denied
		do
			report_error ("denied")
		ensure
			has_error
		end

	mark_is_expired
		do
			report_error ("expired")
		ensure
			has_error
		end

	mark_is_approved (acc: ES_ACCOUNT)
		do
			approved_account := acc
			error_message := Void
		ensure
			is_approved
			approved_account /= Void
			not has_error
		end

invariant


note
	copyright: "Copyright (c) 1984-2024, Eiffel Software"
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
