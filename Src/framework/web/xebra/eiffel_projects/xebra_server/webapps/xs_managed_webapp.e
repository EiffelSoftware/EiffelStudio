note
	description: "[
			Represents a managed webapp and provides features to translate, compile and run it.
	]"
	legal: "See notice at end of class."
	status: "Pre-release"
	date: "$Date$"
	revision: "$Revision$"

class
	XS_MANAGED_WEBAPP

inherit
	XS_WEBAPP
		redefine
			make_with_config
		end

create
	make_with_config

feature {NONE} -- Initialization

	make_with_config (a_webapp_config: XC_WEBAPP_CONFIG)
			-- Initialization for `Current'.
			--
			-- Initializes the actions. The action chain is:
			-- TRANSLATE -> COMPILE_SERVLET_GENERATOR -> GENERATE -> COMPILE_WEBAPP -> RUN -> SEND
		do
			Precursor (a_webapp_config)
			current_request := create {XCWC_EMPTY}.make

			create action_translate.make
			create action_compile_sgen.make
			create action_generate.make
			create action_compile_webapp.make
			create action_run
			create action_send

			action_translate.set_webapp (current)
			action_compile_sgen.set_webapp (current)
			action_generate.set_webapp (current)
			action_compile_webapp.set_webapp (current)
			action_run.set_webapp (current)
			action_send.set_webapp (current)

			action_translate.set_next_action (action_compile_sgen)
			action_compile_sgen.set_next_action (action_generate)
			action_generate.set_next_action (action_compile_webapp)
			action_compile_webapp.set_next_action (action_run)
			action_run.set_next_action (action_send)
				-- Set dev mode by default to true
			dev_mode := True
		ensure then
			config_attached: config /= Void
			action_translate_attached: action_translate /= Void
			action_compile_webapp_attached: action_compile_webapp /= Void
			action_compile_sgen_attached: action_compile_sgen /= Void
			action_generate_attached: action_generate /= Void
			action_run_attached: action_run /= Void
			action_send_attached: action_send /= Void
		end

feature  -- Access

	action_translate: XSWA_TRANSLATE
		-- The action to translate the webapp

	action_compile_sgen: XSWA_COMPILE_SGEN
		-- The action to compile the servlet_generator		

	action_compile_webapp: XSWA_COMPILE_WEBAPP
		-- The action to compile the webapp

	action_generate: XSWA_GENERATE
		-- The action to generate the webapp

	action_run: XSWA_RUN
		-- The action to run the webapp

feature -- Actions

	send (a_request: XC_WEBAPP_COMMAND): XC_COMMAND_RESPONSE
			-- <Precursor>
		do
			current_request := a_request
			if is_disabled then
					Result := (create {XER_DISABLED}.make(app_config.name)).render_to_command_response
			else
				if dev_mode then
					action_translate.execute
					Result := action_translate.last_response
				else
					action_run.execute
					Result := action_run.last_response
				end
			end
		end

	force_translate
			-- Forces to retranslate the webapp
		do
			action_translate.force := True
			action_translate.execute
		end

	force_clean
			-- Forces translation and cleaning of the webapp
		do
			action_compile_webapp.needs_cleaning := True
			action_compile_sgen.needs_cleaning := True
			force_translate
		end

	get_sessions: BOOLEAN
			-- Retrieves the count of sessions from the webapp
		do
			Result := True
			if is_running then
				current_request :=  create {XCWC_GET_SESSIONS}.make
				action_send.execute
				if attached {XCCR_GET_SESSIONS} action_send.last_response as l_response then
					sessions := l_response.sessions
				else
					Result := False
				end
			end
		end

feature  -- Status Setting

	set_needs_cleaning
			-- Sets needs_cleaning to all cleanable actions.
		do
			action_translate.set_force (True)
			action_compile_webapp.set_needs_cleaning (True)
			action_compile_sgen.set_needs_cleaning (True)
			action_generate.set_needs_cleaning (True)
		end

	shutdown
			-- Initiates shutdown and waits for termination.
		do
			if action_run.is_running then
				log.dprint ("Sending shutdown command to '" + app_config.name.value + "'...", log.debug_tasks)
				current_request := 	create {XCWC_SHUTDOWN}.make
				action_send.execute
				action_run.wait_for_exit
			end
		end

	shutdown_all
			-- Shuts the application down and all process (compile and translate).
		do
			shutdown
			action_compile_webapp.stop
			action_generate.stop
			action_compile_sgen.stop
			action_translate.stop
		end

invariant
	config_attached: config /= Void
	action_translate_attached: action_translate /= Void
	action_compile_webapp_attached: action_compile_webapp /= Void
	action_compile_sgen_attached: action_compile_sgen /= Void
	action_generate_attached: action_generate /= Void
	action_run_attached: action_run /= Void
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
