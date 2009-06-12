note
	description: "[
		The {SERVLET} handles a page request. Every concrete servlet inherits from this class and implements
		the concrete render functions as well as the post and get handling with the final handling after rendering.
		This class handles premature redirects as well.
	]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XWA_SERVLET

inherit
	XU_SHARED_OUTPUTTER

feature {XWA_SERVLET} -- Initialization

	make
			-- Will be executed by inheritant class
		do
			create current_session.make
			create validation_errors.make (3)
			create render_conditions.make (3)
			create agent_table.make (5)
			uid_counter := 0
		ensure
			current_session_attached: attached current_session
			validation_errors_attached: attached validation_errors
			render_conditions_attached: attached render_conditions
			agent_table_attached: attached agent_table
		end

feature -- Access

	agent_table: HASH_TABLE [PROCEDURE [ANY, TUPLE], STRING]
			-- Agent-Table for lazy execution at next request

	current_session: XH_SESSION
			-- Represents the session that belongs to the user that has sent the current request

	validation_errors: HASH_TABLE [LIST [STRING], STRING]
			-- Current validation errors of the current form

	render_conditions: HASH_TABLE [BOOLEAN, STRING]
			-- Cached render conditions

	uid_counter: INTEGER
			-- Counter to generate unique ids

	get_unique_id: STRING
			-- Generates a new unique id for the servlet
		do
			Result := "servlet_uid_" + uid_counter.out
			uid_counter := uid_counter + 1
		ensure
			result_attached: attached Result
		end

feature -- Basic Operations	

	add_error (a_key: STRING; a_error: STRING)
			-- Appends an error to the list of errors for the specific key
		do
			if attached validation_errors [a_key] as errors then
				errors.extend (a_error)
			else
				validation_errors [a_key] := create {ARRAYED_LIST [STRING]}.make(1)
				validation_errors [a_key].extend (a_error)
			end
		end

	pre_handle_request (a_session_manager: XWA_SESSION_MANAGER; a_request: XH_REQUEST; a_response: XH_RESPONSE; a_commands: XS_COMMANDS)
			-- Handles a request from a client an generates a response.
			-- Assigns a_commands to the controllers.
		require
			a_session_manager_attached: attached a_session_manager
			a_request_attached: attached a_request
			a_commands_attached: attached a_commands
		local
			l_internal_controllers: LIST [XWA_CONTROLLER]
		do
			o.dprint ("Processing request...", 3)
			current_session := a_session_manager.get_current_session (a_request, a_response)
			l_internal_controllers := internal_controllers
			from
				l_internal_controllers.start
			until
				l_internal_controllers.after
			loop
				l_internal_controllers.item.set_current_request (a_request)
				l_internal_controllers.item.set_current_session (current_session)
				l_internal_controllers.item.server_control.set_commands(a_commands)
				l_internal_controllers.forth
			end
			set_all_booleans (a_request, a_response)
			a_request.call_pre_handler (Current, a_response)
			if a_response.goto_request.is_empty then
				set_all_booleans (a_request, a_response)
				render_html_page (a_request, a_response)
				if a_response.goto_request.is_empty then
					clean_up_after_render (a_request, a_response)
				end
			end
			validation_errors.wipe_out
			uid_counter := 0
		end

	handle_form (a_request: XH_REQUEST; a_response: XH_RESPONSE)
			-- Handles a form
		local
			l_wrapped_form: XH_FORM
			l_real_bean: ANY -- FIXME: Use correct type?
		do
			handle_form_internal (a_request, a_response)
		end

	fill_bean (a_request: XH_REQUEST): BOOLEAN
			-- Fills the bean variables from the form arguments
		require
			a_request_attached: attached a_request
		deferred
		end

	handle_form_internal (a_request: XH_REQUEST; a_response: XH_RESPONSE)
			-- Sets all the attributes from a_form to the bean
		require
			a_request_attached: attached a_request
			a_response_attached: attached a_response
		deferred
		end

	set_all_booleans (a_request: XH_REQUEST; a_response: XH_RESPONSE)
			-- Sets all booleans which are neede for render-attributes
		require
			a_request_attached: attached a_request
			a_response_attached: attached a_response
		deferred
		end

	clean_up_after_render (a_request: XH_REQUEST; a_response: XH_RESPONSE)
		require
			a_request_attached: attached a_request
			a_response_attached: attached a_response
		deferred
		end

	render_html_page (a_request: XH_REQUEST; a_response: XH_RESPONSE)
		require
			a_request_attached: attached a_request
			a_response_attached: attached a_response
		deferred
		end

	internal_controllers: LIST [XWA_CONTROLLER]
			-- The controller associated to the servlet
		deferred
		ensure
			Result_attached: attached Result
		end

invariant
	current_session_attached: attached current_session
note

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
