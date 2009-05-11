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
			new_output_manager_service,
			new_testing_service,
			register_environment_variables,
			register_outputs
		end

--inherit {NONE}
	EIFFEL_LAYOUT
		export
			{NONE} all
		end

	ES_SHARED_LOCALE_FORMATTER
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

feature -- Services

	add_core_services (a_container: attached SERVICE_CONTAINER_S)
			-- <Precursor>
		do
			Precursor {SERVICE_INITIALIZER} (a_container)
			a_container.register_with_activator ({CODE_TEMPLATE_CATALOG_S}, agent new_code_template_catalog_service, False)
			a_container.register_with_activator ({FILE_NOTIFIER_S}, agent new_file_notifier_service, False)
			a_container.register_with_activator ({HELP_PROVIDERS_S}, agent new_help_providers_service, False)
			--a_container.register_with_activator ({STATUS_BAR_S}, agent new_status_bar_service, False)
			a_container.register_with_activator ({WIZARD_ENGINE_S}, agent new_wizard_service, False)
		end

feature {NONE} -- Factory

	new_code_template_catalog_service: detachable CODE_TEMPLATE_CATALOG_S
			-- Creates the code templates catalog service.
		do
			create {CODE_TEMPLATE_CATALOG} Result.make
			if Result.is_interface_usable then
				register_code_template_catalogs (Result)
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	new_file_notifier_service: detachable FILE_NOTIFIER_S
			-- Creates the file notifier service.
		do
			create {FILE_NOTIFIER} Result.make
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	new_help_providers_service: detachable HELP_PROVIDERS_S
			-- Creates the help providers service.
		do
			create {HELP_PROVIDERS} Result.make
			if Result.is_interface_usable then
				register_help_providers (Result)
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

	new_output_manager_service: detachable OUTPUT_MANAGER_S
			-- Creates the output manager service
		do
			create {ES_OUTPUT_MANAGER} Result.make
			if Result.is_interface_usable then
				register_outputs (Result)
			end
		end

--	new_status_bar_service: detachable STATUS_BAR_S
--			-- Create the wizard service.
--		do
--			create {STATUS_BAR} Result
--		ensure
--			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
--		end

	new_testing_service: detachable TEST_SUITE_S
			-- <Precursor>
		do
			create {TEST_SUITE} Result.make (create {ES_TEST_PROJECT_HELPER})
			register_test_suite_processors (Result)
		end

	new_wizard_service: detachable WIZARD_ENGINE_S
			-- Create the wizard service
		do
			create {WIZARD_ENGINE} Result
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
		end

feature {NONE} -- Registering: Code templates

	register_code_template_catalogs (a_service: CODE_TEMPLATE_CATALOG_S)
			-- Extends the build in paths to the code template catalog service.
			--
			-- `a_service': The service to extend with the build in catalog paths.
		require
			a_service_attached: a_service /= Void
			a_service_is_interface_usable: a_service.is_interface_usable
		local
			l_contracts: attached DIRECTORY_NAME
		do
				-- Top level catalog
			l_contracts := eiffel_layout.templates_path.twin
			a_service.extend_catalog (l_contracts.string.as_attached)

				-- User templates catalog
			a_service.extend_catalog (eiffel_layout.user_templates_path.string.as_attached)

				-- Should add user-preference paths here.
			-- ...
		end

feature {NONE} -- Registeration: Environemtn

	register_environment_variables (a_service: ENVIRONMENT_S)
			-- <Precursor>
		do
				-- Add the environment variables used for the external URIs
			a_service.set_environment_variable ("http://dev.eiffel.com", "ISE_WIKI")
			a_service.set_environment_variable ("http://www.eiffelroom.com", "EIFFELROOM")
			a_service.set_environment_variable ("http://doc.eiffel.com", "ISE_DOC")
			a_service.set_environment_variable ("http://doc.eiffel.com/isedoc/uuid", "ISE_DOC_UUID")
		end

feature {NONE} -- Registration: Help

	register_help_providers (a_service: HELP_PROVIDERS_S)
			-- Registers all help providers with the help providers service.
			--
			-- `a_service': The service interface to register the helper providers on.
		require
			a_service_attached: a_service /= Void
			a_service_is_interface_usable: a_service.is_interface_usable
		local
			l_kinds: HELP_PROVIDER_KINDS
		do
			create l_kinds

			a_service.register_with_activator (agent: attached HELP_PROVIDER_I
				do
					create {EIFFEL_DOC_HELP_PROVIDER} Result.make (
						agent (preferences.misc_data.internet_browser_preference).string_value)
				end, l_kinds.eiffel_doc)

			a_service.register_with_activator (agent: attached HELP_PROVIDER_I
				do
					create {WIKI_HELP_PROVIDER} Result.make (
						agent (preferences.misc_data.internet_browser_preference).string_value)
				end, l_kinds.wiki)

			a_service.register_with_activator (agent: attached HELP_PROVIDER_I
				do
					create {RAW_URI_HELP_PROVIDER} Result.make (
						agent (preferences.misc_data.internet_browser_preference).string_value)
				end, l_kinds.raw_uri)

			a_service.register_with_activator (agent: attached HELP_PROVIDER_I
				do
					create {PDF_HELP_PROVIDER} Result.make (
						agent (preferences.misc_data.internet_browser_preference).string_value)
				end, l_kinds.pdf)

			a_service.register_with_activator (agent: attached HELP_PROVIDER_I
				do
					create {DOC_HELP_PROVIDER} Result.make (
						agent (preferences.misc_data.internet_browser_preference).string_value)
				end, l_kinds.doc)

			a_service.register_with_activator (agent: attached HELP_PROVIDER_I
				do
					create {EIS_DEFAULT_HELP_PROVIDER} Result.make (
						agent (preferences.misc_data.internet_browser_preference).string_value)
				end, l_kinds.eis_default)
		end

feature {NONE} -- Registration: Output

	register_outputs (a_service: attached OUTPUT_MANAGER_S)
			-- <Precursor>
		local
			l_kinds: OUTPUT_MANAGER_KINDS
		do
			create l_kinds
			a_service.register (create {ES_EDITOR_OUTPUT_PANE}.make_with_icon (locale_formatter.translation (lb_general), (create {EB_SHARED_PIXMAPS}).icon_pixmaps.tool_output_icon_buffer), l_kinds.general)
			a_service.register (create {ES_EIFFEL_COMPILER_OUTPUT_PANE}.make (locale_formatter.translation (lb_compiler)), l_kinds.eiffel_compiler)
			a_service.register (create {ES_C_COMPILER_OUTPUT_PANE}.make (locale_formatter.translation (lb_external_compilation)), l_kinds.c_compiler)
		end

feature {NONE} -- Internationalization

	lb_general: STRING = "General"
	lb_compiler: STRING = "Compiler"
	lb_external_compilation: STRING = "External Compilation"
	lb_testing: STRING = "Testing"

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
