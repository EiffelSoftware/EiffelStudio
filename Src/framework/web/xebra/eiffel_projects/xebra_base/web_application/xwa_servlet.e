note
	description: "[
		The {SERVLET} handles a page request.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_SERVLET

feature {XWA_SERVLET} -- Initialization

	base_make
			-- Will be executed by inheritant class
		do
			create current_session.make
		end

feature -- Access

	current_session: XH_SESSION
		-- Represents the session that belongs to the user that has send the current request

feature -- Basic Operations	

	pre_handle_request (a_session_manager: XWA_SESSION_MANAGER; a_request: XH_REQUEST): XH_RESPONSE
			-- Handles a request from a client an generates a response.
		do
			create Result.make
			current_session := a_session_manager.get_current_session (a_request, Result)
			internal_controller.set_current_request (a_request)
			internal_controller.set_current_session (current_session)
			internal_controller.on_page_load
			handle_request (a_request, Result)
		end

	handle_request (a_request: XH_REQUEST; a_response: XH_RESPONSE)
			-- Handles a request from a client an generates a response.
		deferred
		end

	internal_controller: XWA_CONTROLLER
		deferred
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
