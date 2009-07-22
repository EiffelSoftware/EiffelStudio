note
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

inherit
	USABLE_I

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	bind_help_shortcut (a_window: EV_WINDOW)
			-- Binds the help shortcut to a specify window for contextual help requests via the keyboard.
			--
			-- `a_window': The window to bind the help shortcut key to.
		require
			is_interface_usable: is_interface_usable
			a_window_attached: a_window /= Void
			not_a_window_is_destoryed: not a_window.is_destroyed
		local
			l_action: PROCEDURE [ANY, TUPLE]
			l_shortcut: SHORTCUT_PREFERENCE
			l_acc: EV_ACCELERATOR
		do
			l_shortcut := preferences.misc_shortcut_data.shortcuts.item ("show_context_help")
			check l_shortcut_attached: attached l_shortcut end

			create l_acc.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			if not a_window.accelerators.has (l_acc) then
				l_acc.actions.extend (agent show_help)
				a_window.accelerators.extend (l_acc)
					-- Set up call back action when the preference is changed.
					-- This simply rebinds the accelerator to the new preference.
				l_action := agent (ia_accel: EV_ACCELERATOR; ia_window: EV_WINDOW)
					require
						ia_accel_attached: attached ia_accel
						ia_window_attached: attached ia_window
					do
						if is_interface_usable and then attached ia_window and then not ia_window.is_destroyed then
							ia_window.accelerators.prune_all (ia_accel)

								-- Rebind
							bind_help_shortcut (ia_window)
						end
					end (l_acc, a_window)
				if attached {EB_RECYCLABLE} Current as l_recyclable then
					l_recyclable.register_kamikaze_action (l_shortcut.change_actions, l_action)
				else
					check needs_to_be_recycable: False end
				end
			end
		end

feature {NONE} -- Helpers

	frozen help_providers: attached SERVICE_CONSUMER [HELP_PROVIDERS_S]
			-- Access to the help providers service {HELP_PROVIDERS_S} consumer
		once
			check is_interface_usable: is_interface_usable end
			create Result
		end

feature {NONE} -- Basic operations

	show_help
			-- Attempts to show help given the current help context implemented on Current.
		require
			is_interface_usable: is_interface_usable
		do
			if help_providers.is_service_available then
					-- Add a help button, if help is available
				if attached {HELP_CONTEXT_I} Current as l_help_context and then l_help_context.is_help_available then
					on_help_requested (l_help_context)
				end
			end
		end

feature {NONE} -- Action handlers

	on_help_requested (a_context: attached HELP_CONTEXT_I)
			-- Called when help is requested for the dialog.
			--
			-- `a_context': The help context to show help for
		require
			is_interface_usable: is_interface_usable
			a_context_is_interface_usable: a_context.is_interface_usable
			a_context_is_help_available: a_context.is_help_available
			is_help_providers_service_available: help_providers.is_service_available
		do
			help_providers.service.show_help (a_context)
		end

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
