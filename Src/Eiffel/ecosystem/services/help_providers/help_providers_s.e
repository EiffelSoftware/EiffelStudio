note
	description: "[
		Abstract interface for the help provider service used in querying help service providers

		Check {HELP_PROVIDER_KINDS} for the common help provider UUID keys.
	]"
	doc: "wiki://Help Providers Service"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	HELP_PROVIDERS_S

inherit
	USABLE_I

	DISPOSABLE_I

	SERVICE_I

	REGISTRAR_I [HELP_PROVIDER_I, UUID]
		rename
			registrations as providers,
			active_registrations as active_providers,
			is_valid_registration as is_valid_provider,
			is_registered as is_provider_available,
			registration as provider,
			registered_event as provider_registered_event,
			unregistered_event as provider_unregistered_event,
			registration_activated_event as provider_activated_event,
			registrar_connection as help_providers_event_connection
		end

feature -- Basic operations

	show_help (a_context: attached HELP_CONTEXT_I)
			-- Attempts to show help for a specific context using the current help provider
			--
			-- `a_context': A help context to use to show the help
		require
			is_interface_usable: is_interface_usable
			a_context_is_interface_usable: a_context.is_interface_usable
			a_context_is_help_available: a_context.is_help_available
		local
			l_provider: attached HELP_PROVIDER_I
		do
			if is_provider_available (a_context.help_provider) then
				l_provider := provider (a_context.help_provider)
				l_provider.show_help (a_context.help_context_id, a_context.help_context_section)
			end
		end

;note
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
