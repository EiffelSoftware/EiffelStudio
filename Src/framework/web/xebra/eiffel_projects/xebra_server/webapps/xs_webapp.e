note
	description: "[
			Represents a webapp and provides features to translate, compile and run it
	]"
	legal: "See notice at end of class."
	status: "Community Preview 1.0"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XS_WEBAPP

inherit
	XC_WEBAPP_BEAN

	XS_SHARED_SERVER_OUTPUTTER

	XS_SHARED_SERVER_CONFIG

feature  -- Access

	action_send: XSWA_SEND
		-- The action to send the request to the webapp

	current_request: XC_WEBAPP_COMMAND
		-- The last request received from the xebra server

feature -- Actions

	send (a_request: XC_WEBAPP_COMMAND): XC_COMMAND_RESPONSE
			-- Sends a_request to the webapp.		
		require
			a_request_attached: a_request /= Void
		deferred
		ensure
			Result_attached: Result /= Void
		end

	get_sessions: BOOLEAN
			-- Retrieves the count of sessions from the webapp
		deferred
		end

	fire_off
			-- Sends shutdown signal no matter what
		do
			log.dprint ("Sending shutdown command to '" + app_config.name.value + "'...", log.debug_tasks)
			current_request := 	create {XCWC_SHUTDOWN}.make
			action_send.execute
		end

invariant
	config_attached: config /= Void
	current_request_attached: current_request /= Void
	action_send_attached: action_send /= Void
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
