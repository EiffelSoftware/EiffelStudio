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
			a_container.register_with_activator ({HELP_PROVIDERS_S}, agent create_help_providers_service, False)
			a_container.register_with_activator ({CODE_TEMPLATE_CATALOG_S}, agent create_code_template_catalog_service, False)
			a_container.register_with_activator ({WIZARD_ENGINE_S}, agent create_wizard_service, False)
			a_container.register_with_activator ({EIFFEL_TEST_SUITE_S}, agent create_testing_servive, False)
		end

feature {NONE} -- Help registration

	register_help_providers (a_service: !HELP_PROVIDERS_S)
			-- Registers all help providers with the help providers service.
			--
			-- `a_service': The service interface to register the helper providers on.
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

feature {NONE} -- Code template cataloging

	extend_code_template_catalog (a_service: !CODE_TEMPLATE_CATALOG_S)
			-- Extends the build in paths to the code template catalog service.
			--
			-- `a_service': The service to extend with the build in catalog paths.
		require
			a_service_is_interface_usable: a_service.is_interface_usable
		local
			l_contracts: !DIRECTORY_NAME
		do
				-- Top level catalog
			l_contracts ?= eiffel_layout.templates_path.twin
			a_service.extend_catalog (l_contracts.string)

				-- User templates catalog
			a_service.extend_catalog (eiffel_layout.user_templates_path.string)
		end

feature {NONE} -- Test suite extension

	register_test_suite_processors (a_service: !EIFFEL_TEST_SUITE_S) is
			-- Register standard test processors for test suite service.
			--
			-- `a_service': Service in which test processors are registered.
		require
			a_service_usable: a_service.is_interface_usable
		local
			l_executor: EIFFEL_TEST_EXECUTOR
			l_debugger: EIFFEL_TEST_DEBUGGER_I
			l_type: !TYPE [!EIFFEL_TEST_PROCESSOR_I]
		do
			create l_executor.make
			l_type ?= {EIFFEL_TEST_BACKGROUND_EXECUTOR_I}
			a_service.processor_registrar.register (l_executor, l_type)
		end

feature {NONE} -- Factory

	create_file_notifier_service: ?FILE_NOTIFIER_S
			-- Creates the file notifier service.
		do
			create {FILE_NOTIFIER} Result.make
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	create_help_providers_service: ?HELP_PROVIDERS_S
			-- Creates the help providers service.
		do
			create {HELP_PROVIDERS} Result.make
			if Result /= Void then
				register_help_providers (Result)
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	create_code_template_catalog_service: ?CODE_TEMPLATE_CATALOG_S
			-- Creates the code templates catalog service.
		do
			create {CODE_TEMPLATE_CATALOG} Result.make
			if Result /= Void then
				extend_code_template_catalog (Result)
			end
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
			register_test_suite_processors (Result)
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
