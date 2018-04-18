note
	description: "Help provider to launch raw URI"
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	RAW_URI_HELP_PROVIDER

inherit
	HELP_PROVIDER_I
		redefine
			help_title
		end

	SITE [HELP_PROVIDERS_S]

create
	make

feature {NONE} -- Initialization

	make (a_delegate: attached like default_browser_delegate)
			-- Initializes the help provider using a delegating action to fetch a default URI application.
		do
			default_browser_delegate := a_delegate
		ensure
			default_browser_delegate_attached: default_browser_delegate /= Void
		end

feature -- Access

	document_protocol: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "URI"
		end

	document_description: STRING_32
			-- <Precursor>
		once
			Result := {STRING_32} "URI"
		end

feature {NONE} -- Access

	context_variables: STRING_TABLE [READABLE_STRING_32]
			-- <Precursor>
		do
			if attached internal_context_variables as l_result then
				Result := l_result
			else
					-- No other variables
				create Result.make (0)
				internal_context_variables := Result
			end
		end

	default_uri_browser: detachable STRING_32
			-- Default URI launcher/browser application
		require
			is_interface_usable: is_interface_usable
		do
			if attached default_browser_delegate as l_action then
				Result := l_action.item (Void)
				if Result.is_empty then
					Result := Void
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

	default_browser_delegate: detachable FUNCTION [STRING_32]
			-- Delegate action to fetch a default URI browser, handy for systems with preferences.

feature -- Status report

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

	is_launched: BOOLEAN
			-- <Precursor>

feature -- Query

	help_title (a_context_id: READABLE_STRING_GENERAL; a_section: detachable HELP_CONTEXT_SECTION_I): STRING_32
			-- <Precursor>
		do
			if a_section /= Void then
				create Result.make_from_string (a_section.section)
			else
					-- Not sure if INTERFACE_NAMES should be introduced in ecosystem
				Result := {STRING_32} "Untitled"
			end
		end

feature {NONE} -- Helpers

	environment: SERVICE_CONSUMER [ENVIRONMENT_S]
			-- Access to the environment service
		do
			if attached internal_environment as l_result then
				Result := l_result
			elseif
					-- The object test is required to access the feature `{SITE}.is_sited` that is not exported by the descendant.
				attached {SITE [SERVICE_PROVIDER_I]} site as l_site and then
				l_site.is_sited and then
				attached l_site.site as l_provider
			then
					-- Use the localized service provider.
				create Result.make_with_provider (l_provider)
			else
					-- Use the global service provider.
				create Result
			end
		end

feature -- Basic operations

	show_help (a_context_id: READABLE_STRING_GENERAL; a_section: detachable HELP_CONTEXT_SECTION_I)
			-- <Precursor>
		local
			l_id: STRING_32
		do
			create l_id.make_from_string_general (a_context_id)
			format_uris (l_id)
			launch_uri (l_id)
		end

feature {NONE} -- Basic operations

	launch_uri (a_uri: READABLE_STRING_32)
			-- Launches uri in the default web browser.
			--
			-- `a_uri': The URI to launch in a web-browser.
		require
			a_uri_attached: a_uri /= Void
			not_a_url_is_empty: not a_uri.is_empty
		local
			uri_launcher: URI_LAUNCHER
			l_path_uri: STRING_32
		do
			l_path_uri := a_uri
			create uri_launcher
			if attached default_uri_browser as l_default_browser and then not l_default_browser.is_empty then
				is_launched := uri_launcher.launch_with_default_app (l_path_uri, l_default_browser)
			else
				is_launched := uri_launcher.launch (l_path_uri)
					-- This check is here because it lets us know if the preference wasn't initialized.
				check False end
			end
		end

feature {NONE} -- Variable expansion

	format_uris (a_uri: STRING_32)
			-- Formates URI and expands any variables
			--
			-- `a_uri': URI to format.
		require
			a_uri_attached: a_uri /= Void
			a_uris_contains_valid_items: not a_uri.is_empty
		local
			l_uri: STRING_32
		do
				-- Escape '%%' before processing
			a_uri.replace_substring_all ("%%", "%%%%")
			l_uri := (create {STRING_AGENT_EXPANDER}).expand_string_32 (a_uri, agent variable, False, True)
			a_uri.wipe_out
			a_uri.append (l_uri)
		end

	variable (a_name: READABLE_STRING_32): detachable STRING_32
			-- Fetches a variable value associated with a supplied name.
			--
			-- `a_name': The name of the variable to retrieve a value for.
			-- `a_value': The variable value or Void if the value was not defined.
		require
			a_name_attached: a_name /= Void
			not_a_name_is_empty: not a_name.is_empty
		do
				-- Check the environment service
				-- then context variables!
			if
				attached environment.service as l_service and then l_service.is_interface_usable and then
				attached l_service.variable (a_name) as l_result
			then
				Result := l_result
			elseif attached context_variables.item (a_name) as l_result then
				Result := l_result
			end
		end

feature {NONE} -- Implementation: Internal cache

	internal_environment: detachable like environment
			-- Cached version of `environment'.
			-- Note: Do not use directly!

	internal_context_variables: detachable like context_variables
			-- Cached version of `context_variables'.
			-- Note: Do not use directly!

;note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
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
