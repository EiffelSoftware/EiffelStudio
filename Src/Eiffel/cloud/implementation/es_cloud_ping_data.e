note
	description: "Summary description for {ES_CLOUD_PING_RESPONSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_PING_DATA

feature -- Access

	has_error: BOOLEAN

	error_message: detachable READABLE_STRING_GENERAL

	json: detachable STRING

feature -- Access: session

	heartbeat: NATURAL_32 assign set_heartbeat

	session_state: detachable READABLE_STRING_32 assign set_session_state

	session_state_changed: BOOLEAN assign set_session_state_changed

	license_missing: BOOLEAN assign set_license_missing

	license_invalid: BOOLEAN assign set_license_invalid

	license_expired: BOOLEAN assign set_license_expired

feature -- Element change

	report_error (msg: like error_message)
		do
			if msg /= Void then
				error_message := msg.twin
			else
				error_message := Void
			end
			has_error := True
		end

	set_heartbeat (v: like heartbeat)
		do
			heartbeat := v
		end

	set_license_missing (b: BOOLEAN)
		do
			license_missing := b
		end

	set_license_invalid (b: BOOLEAN)
		do
			license_invalid := b
		end

	set_license_expired (b: BOOLEAN)
		do
			license_expired := b
		end

	set_session_state (v: like session_state)
		do
			if v = Void then
				session_state := Void
			else
				create {IMMUTABLE_STRING_32} session_state.make_from_string (v)
			end
		end

	set_session_state_changed (v: like session_state_changed)
		do
			session_state_changed := v
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
