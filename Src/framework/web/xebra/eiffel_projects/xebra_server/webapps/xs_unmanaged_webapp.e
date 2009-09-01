note
	description: "[
			Represents an unmanaged webapp.
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_UNMANAGED_WEBAPP

inherit
	XS_WEBAPP

	XS_SHARED_SERVER_OUTPUTTER

	XS_SHARED_SERVER_CONFIG

create
	make_with_attributes

feature {NONE} -- Initialization

	make_with_attributes (a_name: STRING; a_host: STRING; a_port: INTEGER)
			-- Initialization for `Current'.
			-- Initializes the actions. The action chain is:
			-- -> SEND
			--
			-- `a_name': The name of the webapp
			-- `a_host': The host address of the webapp
			-- `a_post': The port of the webapp
		local
			l_config: XC_WEBAPP_CONFIG
		do
			create l_config.make_empty
			l_config.set_name (a_name)
			l_config.set_webapp_host (a_host)
			l_config.set_port (a_port)
			make_with_config (l_config)
			current_request := create {XCWC_EMPTY}.make
			create action_send
			action_send.set_webapp (current)
			is_running := True
		ensure then
			action_send_attached: action_send /= Void
		end

feature -- Actions

	send (a_request: XC_WEBAPP_COMMAND): XC_COMMAND_RESPONSE
			-- <Precursor>	
		do
			current_request := a_request
			if is_disabled then
				Result := (create {XER_DISABLED}.make(app_config.name)).render_to_command_response
			else
				action_send.execute
				Result := action_send.last_response
			end
		end

	get_sessions: BOOLEAN
			-- Retrieves the count of sessions from the webapp
		do
			Result := True
			current_request :=  create {XCWC_GET_SESSIONS}.make
			action_send.execute
			if attached {XCCR_GET_SESSIONS} action_send.last_response as l_response then
				sessions := l_response.sessions
			else
				Result := False
			end
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
