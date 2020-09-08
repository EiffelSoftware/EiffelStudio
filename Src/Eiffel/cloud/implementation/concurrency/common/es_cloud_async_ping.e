note
	description: "Asynchronous call to ping_installation."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ASYNC_PING

inherit
	ES_CLOUD_ASYNC_JOB
		rename
			make as old_make
		end

	SHARED_LOGGER_SERVICE

create
	make

feature {NONE} -- Initialization	

	make (a_service: ES_CLOUD_S; a_token: ES_ACCOUNT_ACCESS_TOKEN; a_session: ES_ACCOUNT_SESSION; params: ES_CLOUD_API_SESSION_PARAMETERS; cfg: ES_CLOUD_CONFIG)
		require
			a_session /= Void
		do
			old_make (a_service, cfg)
			create token.make_from_string (a_token.token)
			session := a_session

			create parameters.make (params.installation_id, params.session_id)
			across
				params as ic
			loop
				parameters [ic.key.twin] := ic.item.twin
			end
			if attached a_session.title as l_title then
				parameters ["session_title"] := create {IMMUTABLE_STRING_32}.make_from_string_general (l_title)
			end
		end

feature -- Access: Current

	session: ES_ACCOUNT_SESSION

feature {NONE} -- Access: after thread completed

	is_cloud_available: BOOLEAN

	is_cloud_available_updated: BOOLEAN

	session_state_changed: BOOLEAN

	session_heartbeat: NATURAL_32

	license_expired: BOOLEAN

	error_message: detachable READABLE_STRING_GENERAL

feature {NONE} -- Access: worker thread

	token: IMMUTABLE_STRING_8

	parameters: ES_CLOUD_API_SESSION_PARAMETERS

feature -- Execution

	execute
		local
			wapi: ES_CLOUD_API
			d: ES_CLOUD_PING_DATA
		do
			wapi := web_api
			is_cloud_available := wapi.is_available
			if not is_cloud_available then
				wapi.get_is_available
				is_cloud_available := wapi.is_available
				is_cloud_available_updated := is_cloud_available
			end
			if is_cloud_available then
				create d
				wapi.ping_installation (token, parameters, d)
				is_cloud_available := wapi.is_available
				is_cloud_available_updated := not is_cloud_available
				session_state_changed := d.session_state_changed
				if attached d.error_message as errmsg then
					error_message := errmsg
				end
				if d.heartbeat > 0 then
					session_heartbeat := d.heartbeat
				end
				if d.license_expired then
					license_expired := d.license_expired
				end
			end
		end

	pre_execute
		do
			session_state_changed := False
			error_message := Void
			license_expired := False
			is_cloud_available_updated := False
		end

	post_execute
		local
			l_issue: ES_ACCOUNT_LICENSE_ISSUE
		do
			debug ("es_cloud")
				if attached logger_s.service as logger_service then
						-- Log error.
					logger_service.put_message_format_with_severity (
						"Cloud service pong {1} [{2}]",
						[parameters.installation_id, create {DATE_TIME}.make_now],
						{ENVIRONMENT_CATEGORIES}.cloud,
						{PRIORITY_LEVELS}.low)
				end
			end
			if session_heartbeat > 0 then
				service.on_session_heartbeat_updated (session_heartbeat)
			end
			if session_state_changed then
				service.on_session_state_changed (session)
			end
			if license_expired then
				create l_issue.make (session.account)
				l_issue.set_license_expired
				if attached error_message as errmsg then
					l_issue.set_reason (errmsg)
				end
				service.on_account_license_issue (l_issue)
			elseif attached error_message as errmsg then
				create l_issue.make (session.account)
				l_issue.set_reason (errmsg)
				service.on_account_license_issue (l_issue)
			end
			if is_cloud_available_updated then
				service.on_cloud_available (is_cloud_available)
			end
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
