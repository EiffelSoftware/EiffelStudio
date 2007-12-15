indexing
	description: "[
		Provides access to help functionality through inheritance.
		
		Note: Descendents should implement {HELP_CONTEXT_I} or use the base implementation {HELP_CONTEXT}
		      in order for help to usable.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	ES_HELP_REQUEST_BINDER

feature {NONE} -- Initialization

	bind_help_shortcut (a_window: EV_WINDOW)
			-- Binds the help shortcut to a specify window for contextual help requests via the keyboard.
			--
			-- `a_window': The window to bind the help shortcut key to.
		require
			a_window_attached: a_window /= Void
			not_a_window_is_destoryed: not a_window.is_destroyed
		do
			a_window.accelerators.extend (create_help_request_shortcut)
		end

feature {NONE} -- Helpers

	frozen help_providers: SERVICE_CONSUMER [HELP_PROVIDERS_S]
			-- Access to the help providers service {HELP_PROVIDERS_S} consumer
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Basic operations

	show_help
			-- Attempts to show help given the current help context implemented on Current.
		do
			if help_providers.is_service_available then
					-- Add a help button, if help is available
				if {l_help_context: !HELP_CONTEXT_I} Current and then l_help_context.is_help_available then
					on_help_requested (l_help_context)
				end
			end
		end

feature {NONE} -- Action handlers

	on_help_requested (a_context: !HELP_CONTEXT_I) is
			-- Called when help is requested for the dialog.
			--
			-- `a_context': The help context to show help for
		require
			a_context_is_interface_usable: a_context.is_interface_usable
			a_context_is_help_available: a_context.is_help_available
			is_help_providers_service_available: help_providers.is_service_available
		do
			help_providers.service.show_help (a_context)
		end

feature {NONE} -- Factory

	frozen create_help_request_shortcut: EV_ACCELERATOR is
			-- Help request shortcut accelerator key
		do
			create Result.make_with_key_combination (create {EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_f1), False, False, False)
			Result.actions.extend (agent show_help)
		ensure
			result_attached: Result /= Void
			not_result_is_destroyed: not Result.is_destroyed
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
