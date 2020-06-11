note
	description: "Summary description for {ES_CLOUD_OBSERVER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_OBSERVER

feature -- Event

	on_session_state_changed (sess: ES_ACCOUNT_SESSION)
		do
		end

	on_cloud_available (a_is_available: BOOLEAN)
		do
		end

	on_account_signed_in (acc: ES_ACCOUNT)
		do
		end

	on_account_license_issue (lic: detachable ES_ACCOUNT_LICENSE; acc: ES_ACCOUNT)
		do
		end

	on_account_signed_out
		do
		end

	on_account_updated (acc: detachable ES_ACCOUNT)
		do
		end

	on_session_heartbeat_updated (a_new_hearbeat: NATURAL_32)
			-- New hearbeat expressed in seconds.
		do
		end

note
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
