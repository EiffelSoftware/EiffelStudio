note
	description: "Asynchronous call to ping_installation."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ASYNC_PING

inherit
	EV_SHARED_APPLICATION

create
	make

feature {NONE} -- Initialization

	make (a_service: ES_CLOUD_S; a_token: ES_ACCOUNT_ACCESS_TOKEN; a_installation: ES_ACCOUNT_INSTALLATION; a_session: ES_ACCOUNT_SESSION; a_server_url: READABLE_STRING_8)
		require
			a_session /= Void
		do
			service := a_service
			create token.make_from_string (a_token.token)
			installation_id := a_installation.id
			session := a_session
			session_id := a_session.id
			create server_url.make_from_string (a_server_url)
			if attached a_session.title as l_title then
				create opts.make (1)
				opts["session_title"] := create {IMMUTABLE_STRING_32}.make_from_string_general (l_title)
			end
		end

feature -- Access: Current

	service: ES_CLOUD_S

	session: ES_ACCOUNT_SESSION

feature {NONE} -- Access: thread synchro

	completed: BOOLEAN

feature {NONE} -- Access: after thread completed

	session_state_changed: BOOLEAN

feature {NONE} -- Access: worker thread

	token: IMMUTABLE_STRING_8

	installation_id: IMMUTABLE_STRING_8

	session_id: IMMUTABLE_STRING_32

	opts: detachable STRING_TABLE [READABLE_STRING_GENERAL]

	server_url: IMMUTABLE_STRING_8

feature -- Access

	check_for_completion
		local
			t: EV_TIMEOUT
		do
			create t
			t.actions.extend (agent (i_t: EV_TIMEOUT)
					do
						if completed then
							i_t.destroy
							on_completion
						else
								-- continue timeout
						end
					end(t)
				)
				t.set_interval (500) -- interval in milliseconds)
		end

	on_completion
		local
			sess: ES_ACCOUNT_SESSION
		do
			debug ("es_cloud")
				print ("ping done%N")
			end
			if session_state_changed then
				reset
				service.on_session_state_changed (session)
			end
		end

	reset
		do
			completed := False
			session_state_changed := False
		end

	execute
		local
			wt: WORKER_THREAD
		do
			reset
			create wt.make (agent ping_installation)
			ev_application.add_idle_action_kamikaze (agent check_for_completion)
			wt.launch
		end

	ping_installation
		local
			wapi: ES_CLOUD_API
		do
			create wapi.make (server_url)
			debug ("es_cloud")
				print ("Pinging...")
			end
			wapi.ping_installation (token, installation_id, session_id, opts)
			session_state_changed := wapi.session_state_changed
			completed := True
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
