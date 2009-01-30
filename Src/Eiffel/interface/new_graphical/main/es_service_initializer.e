note
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
			add_core_services,
			new_testing_service
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
			a_container.register_with_activator ({FILE_NOTIFIER_S}, agent new_file_notifier_service, False)
			a_container.register_with_activator ({HELP_PROVIDERS_S}, agent new_help_providers_service, False)
			a_container.register_with_activator ({CODE_TEMPLATE_CATALOG_S}, agent new_code_template_catalog_service, False)
			a_container.register_with_activator ({WIZARD_ENGINE_S}, agent new_wizard_service, False)
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
			a_service.register_provider (l_kinds.eiffel_doc, {EIFFEL_DOC_HELP_PROVIDER})
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
			l_contracts := eiffel_layout.templates_path.twin
			a_service.extend_catalog (l_contracts.string.as_attached)

				-- User templates catalog
			a_service.extend_catalog (eiffel_layout.user_templates_path.string.as_attached)
		end

feature {NONE} -- Factory

	new_file_notifier_service: ?FILE_NOTIFIER_S
			-- Creates the file notifier service.
		do
			create {FILE_NOTIFIER} Result.make
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	new_help_providers_service: ?HELP_PROVIDERS_S
			-- Creates the help providers service.
		do
			create {HELP_PROVIDERS} Result.make
			if Result /= Void then
				register_help_providers (Result)
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	new_code_template_catalog_service: ?CODE_TEMPLATE_CATALOG_S
			-- Creates the code templates catalog service.
		do
			create {CODE_TEMPLATE_CATALOG} Result.make
			if Result /= Void then
				extend_code_template_catalog (Result)
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	new_wizard_service: ?WIZARD_ENGINE_S
			-- Create the wizard service
		do
			create {WIZARD_ENGINE} Result
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	new_testing_service: ?TEST_SUITE_S
			-- <Precursor>
		local
			l_ev_app: EV_SHARED_APPLICATION
		do
			create {TEST_SUITE} Result.make (create {ES_TEST_PROJECT_HELPER})
			register_test_suite_processors (Result)
			if Result /= Void then
				create l_ev_app
				l_ev_app.ev_application.add_idle_action (agent Result.synchronize_processors)
			end
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
