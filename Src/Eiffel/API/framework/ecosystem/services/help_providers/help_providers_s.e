indexing
	description: "[
		Abstract interface for the help provider service used in querying help service providers based on available providers described in {HELP_PROVIDER_KINDS}.
	]"
	help: "http://dev.eiffel.com/Help_Providers_Service"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	HELP_PROVIDERS_S

inherit
	SERVICE_I

	USABLE_I

feature -- Access

	help_providers: !DS_BILINEAR [!HELP_PROVIDER_I]
			-- List of registered help providers.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Query

	help_provider (a_kind: !UUID): !HELP_PROVIDER_I
			-- Retrieves a help provider from the current service using a provider kind identifier.
			--
			-- `a_kind': The kind of help service provider to retrieve. Most kinds are located in
			--           {HELP_PROVIDER_KINDS}, please see respective documentation related to extended third-party
			--           help providers.
			-- `Result':
		require
			a_kind_is_provider_available: is_provider_available (a_kind)
		deferred
		ensure
			result_is_interface_usable: Result.is_interface_usable
		end

	is_provider_available (a_kind: !UUID): BOOLEAN
			-- Determines if a help provider is available from this service
			--
			-- `a_kind': The kind of help service provider to check for. Most kinds are located in
			--           {HELP_PROVIDER_KINDS}, please see respective documentation related to extended third-party
			--           help providers.
			-- `Result': True if the help provider is available; False otherwise.
		require
			is_interface_usable: is_interface_usable
		deferred
		end

feature -- Basic operations

	register_provider (a_kind: !UUID; a_type: TYPE [HELP_PROVIDER_I])
			-- Registers a help provider with the current service using a type corresponding to the type that should be instantiate
			-- when the help provider is requested. For providers with more complex creation use `register_provider_with_activator'.
			--
			-- `a_kind': The kind of help service provider to register. Most kinds are located in
			--           {HELP_PROVIDER_KINDS}, please see respective documentation related to extended third-party
			--           help providers.
			-- `a_type': Type to instantiate when the respective help provider is requested.
		require
			is_interface_usable: is_interface_usable
			not_a_kind_is_provider_available: not is_provider_available (a_kind)
			a_type_attached: a_type /= Void
		do
			register_provider_with_activator (a_kind, agent (a_ia_service: !HELP_PROVIDERS_S; a_ia_type: TYPE [HELP_PROVIDER_I]): !HELP_PROVIDER_I
					-- Add
				local
					l_internal: !INTERNAL
					l_provider: !HELP_PROVIDER_I
				do
					create l_internal
					l_provider ?= l_internal.new_instance_of (l_internal.generic_dynamic_type (a_ia_type, 1))
					if {l_site: !SITE [HELP_PROVIDERS_S]} l_provider then
							-- Set site, if applicable
						l_site.site := a_ia_service
					end
					Result := l_provider
				end (?, a_type))
		ensure
			a_kind_is_provider_available: is_provider_available (a_kind)
		end

	register_provider_with_activator (a_kind: !UUID; a_activator: FUNCTION [ANY, TUPLE [providers: !HELP_PROVIDERS_S], !HELP_PROVIDER_I])
			-- Registers a help provider with the current service, using a delayed-initialization function to retrieve
			-- the help provider.
			--
			-- `a_kind': The kind of help service provider to register. Most kinds are located in
			--           {HELP_PROVIDER_KINDS}, please see respective documentation related to extended third-party
			--           help providers.
			-- `a_activator': An agent function use to fetch a new instance of a help provider.
		require
			is_interface_usable: is_interface_usable
			not_a_kind_is_provider_available: not is_provider_available (a_kind)
			a_activator_attached: a_activator /= Void
		deferred
		ensure
			a_kind_is_provider_available: is_provider_available (a_kind)
		end

	unregister_provider (a_kind: !UUID)
			-- Unregisters a previously registers help provider from the current service.
			--
			-- `a_kind': The kind of help service provider to remove. Most kinds are located in
			--           {HELP_PROVIDER_KINDS}, please see respective documentation related to extended third-party
			--           help providers.
		require
			is_interface_usable: is_interface_usable
			a_kind_is_provider_available: is_provider_available (a_kind)
		deferred
		ensure
			not_a_kind_is_provider_available: not is_provider_available (a_kind)
		end

	show_help (a_context: !HELP_CONTEXT_I)
			-- Attempts to show help for a specific context using the current help provider
			--
			-- `a_context': A help context to use to show the help
		require
			is_interface_usable: is_interface_usable
			a_context_is_interface_usable: a_context.is_interface_usable
			a_context_is_help_available: a_context.is_help_available
		local
			l_provider: !HELP_PROVIDER_I
		do
			if is_provider_available (a_context.help_provider) then
				l_provider := help_provider (a_context.help_provider)
				l_provider.show_help (a_context.help_context_id, a_context.help_context_section)
			end
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
