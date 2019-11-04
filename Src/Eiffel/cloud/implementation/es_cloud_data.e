note
	description: "Summary description for {ES_CLOUD_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_DATA

feature -- Access

	installation: detachable READABLE_STRING_8 assign set_installation

	active_account: detachable ES_ACCOUNT assign set_active_account
			-- Active account if logged in, otherwise Void.

	guest_mode_ending_date: detachable DATE_TIME assign set_guest_mode_ending_date

	guest_mode_loging_count: INTEGER assign set_guest_mode_loging_count

	session_heartbeat: NATURAL assign set_session_heartbeat
			-- <Precursor>

feature -- Element change

	set_installation (v: like installation)
		do
			installation := v
		end

	set_active_account (v: like active_account)
		do
			active_account := v
		end

	set_guest_mode_ending_date (v: like guest_mode_ending_date)
		do
			guest_mode_ending_date := v
		end

	set_guest_mode_loging_count (v: like guest_mode_loging_count)
		do
			guest_mode_loging_count := v
		end

	set_session_heartbeat (v: like session_heartbeat)
		do
			session_heartbeat := v
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
