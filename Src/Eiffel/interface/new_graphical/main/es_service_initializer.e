indexing
	description: "[
		An initialization provider to initialize all services used by the EiffelStudio and the Eiffel Compiler.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_SERVICE_INITIALIZER

inherit
	SERVICE_INITIALIZER
		redefine
			add_core_services
		end

--inherit {NONE}
	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature -- Services

	add_core_services (a_container: !SERVICE_CONTAINER_S)
			-- Adds all the core services.
			--
			-- `a_container': The service container to add services to.
		do
			Precursor {SERVICE_INITIALIZER} (a_container)
			a_container.register_with_activator ({FILE_NOTIFIER_S}, agent create_file_notifier_service, False)
			a_container.register_with_activator ({HELP_PROVIDERS_S}, agent setup_help_providers_service, False)
			a_container.register_with_activator ({CODE_TEMPLATE_CATALOG_S}, agent create_code_template_catalog_service, False)
			a_container.register_with_activator ({WIZARD_ENGINE_S}, agent create_wizard_service, False)
			a_container.register_with_activator ({EIFFEL_TEST_SUITE_S}, agent create_testing_servive, False)
		end

feature {NONE} -- Help registration

	frozen setup_help_providers_service: HELP_PROVIDERS_S
			-- Creates the editor documents table service
		do
			Result := create_help_providers_service
			if {l_service: !HELP_PROVIDERS_S} Result then
					-- Register all services.
					-- Note: There is no need to perform any unregistering as the service should clean up all
					--       help providers when the service is disposed of.
				register_help_providers (l_service)
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	register_help_providers (a_service: !HELP_PROVIDERS_S)
			-- Registers all help providers with the help providers service
		require
			a_service_is_interface_usable: a_service.is_interface_usable
		local
			l_kinds: HELP_PROVIDER_KINDS
		do
			create l_kinds
			a_service.register_provider (l_kinds.wiki, {WIKI_HELP_PROVIDER})
			a_service.register_provider (l_kinds.raw_uri, {RAW_URI_HELP_PROVIDER})
			a_service.register_provider (l_kinds.pdf, {PDF_HELP_PROVIDER})
			a_service.register_provider (l_kinds.doc, {DOC_HELP_PROVIDER})
			a_service.register_provider (l_kinds.eis_default, {EIS_DEFAULT_HELP_PROVIDER})
		end

feature {NONE} -- Factory

	create_file_notifier_service: FILE_NOTIFIER_S
			-- Creates the file notifier service.
		do
			create {FILE_NOTIFIER} Result.make
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	create_help_providers_service: HELP_PROVIDERS_S
			-- Creates the help providers service.
		do
			create {HELP_PROVIDERS} Result.make
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	create_code_template_catalog_service: CODE_TEMPLATE_CATALOG_S
			-- Creates the code templates catalog service.
		local
			l_contracts: !DIRECTORY_NAME
		do
			create {CODE_TEMPLATE_CATALOG} Result.make
			l_contracts ?= eiffel_layout.templates_path.twin
			Result.extend_catalog (l_contracts.string)
			l_contracts.extend ("eiffel")
			Result.extend_catalog (l_contracts.string)
			Result.extend_catalog (eiffel_layout.user_templates_path.string)
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	create_wizard_service: ?WIZARD_ENGINE_S
			-- Create the wizard service
		do
			create {WIZARD_ENGINE} Result
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	create_testing_servive: ?EIFFEL_TEST_SUITE_S
			-- Create test suite service
		do
			create {EIFFEL_TEST_SUITE} Result.make
		ensure
			result_not_void_implies_usable: Result /= Void implies Result.is_interface_usable
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
