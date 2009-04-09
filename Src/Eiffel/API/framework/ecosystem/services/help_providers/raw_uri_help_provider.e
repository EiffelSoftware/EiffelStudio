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

--inherit {NONE}
	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

feature -- Access

	help_title (a_context_id: READABLE_STRING_GENERAL; a_section: detachable HELP_CONTEXT_SECTION_I): STRING_32
			-- <Precursor>
		do
			if a_section /= Void then
				create Result.make_from_string (a_section.section.as_string_32)
			else
					-- Not sure if INTERFACE_NAMES should be introduced in ecosystem
				create Result.make_from_string ("Untitled")
			end
		end

	document_protocol: STRING
			-- <Precursor>
		once
			create Result.make_from_string ("URI")
		end

	document_description: STRING_32
			-- <Precursor>
		once
			create Result.make_from_string ("URI")
		end

feature -- Querry

	is_interface_usable: BOOLEAN = True
			-- <Precursor>

feature -- Basic operations

	show_help (a_context_id: READABLE_STRING_GENERAL; a_section: detachable HELP_CONTEXT_SECTION_I)
			-- <Precursor>
		local
			l_id: STRING
		do
			l_id := a_context_id.as_string_8
			if l_id ~ a_context_id then
				l_id := l_id.twin
			end
			format_uris (l_id)
			launch_uri (l_id)
		end

feature {NONE} -- Basic operations

	launch_uri (a_uri: READABLE_STRING_8)
			-- Launches uri in the default web browser.
			--
			-- `a_uri': The URI to launch in a web-browser.
		require
			a_uri_attached: a_uri /= Void
			not_a_url_is_empty: not a_uri.is_empty
		local
			l_url: URI_LAUNCHER
			l_error: ES_ERROR_PROMPT
			l_default_browser: READABLE_STRING_GENERAL
			l_launched: BOOLEAN
		do
			create l_url
			l_default_browser := preferences.misc_data.internet_browser_preference.string_value
			if l_default_browser /= Void and then not l_default_browser.is_empty then
				l_launched := l_url.launch_with_default_app (a_uri, l_default_browser)
			else
				l_launched := l_url.launch (a_uri)
					-- This check is here because it lets us know if the preference wasn't initialized.
				check False end
			end
			if not l_launched then
				create l_error.make_standard ((create {ERROR_MESSAGES}).e_help_unable_to_launch)
				l_error.show_on_active_window
			end
		end

feature {NONE} -- Variable expansion

	context_variables: HASH_TABLE [STRING, STRING]
			-- A table of context variables, indexed by a variable name
		do
			Result := environment_variables
			Result.merge (es_built_in_variables)
		ensure
			result_attached: Result /= Void
		end

	format_uris (a_uri: STRING)
			-- Formates URI and expands any variables
			--
			-- `a_uri': URI to format.
		require
			a_uri_attached: a_uri /= Void
			a_uris_contains_valid_items: not a_uri.is_empty
		local
			l_context_vars: like context_variables
			l_uri: STRING
			l_new_uri: STRING
			l_vars: like uri_variables
			l_var: TUPLE [var: STRING; start_i, end_i: INTEGER]
			l_start_i, l_end_i: INTEGER
			l_scanner_regex: like variable_scanner_regex
			l_extractor_regex: like variable_extractor_regex
		do
			l_uri := a_uri
			l_scanner_regex := variable_scanner_regex
			l_extractor_regex := variable_extractor_regex

				-- Retrieve variables from `entry'.
			l_context_vars := context_variables

			l_vars := uri_variables (l_uri, l_scanner_regex, l_extractor_regex)
			if l_vars /= Void and then not l_vars.is_empty then
					-- Make variable replacements.
				create l_new_uri.make (l_uri.count)

				l_start_i := 1
				l_end_i := l_vars.first.start_i - 1
				from
					l_vars.start
					l_var := l_vars.item_for_iteration
				until
					l_vars.after or
					l_start_i > l_uri.count
				loop
					if l_start_i <= l_end_i then
							-- Append leading text
						l_new_uri.append (l_uri.substring (l_start_i, l_end_i))
					end

					if l_context_vars.has (l_var.var) then
							-- Append variable value
						l_new_uri.append (l_context_vars.item (l_var.var))
					end

						-- Make position text adjustments
					l_start_i := l_var.end_i + 1
					l_vars.forth
					if not l_vars.after then
						l_var := l_vars.item_for_iteration
						l_end_i := l_var.start_i - 1
					else
						l_end_i := l_uri.count
					end
				end

				if l_start_i <= l_uri.count then
						-- Append trailing text
					l_new_uri.append (l_uri.substring (l_start_i, l_end_i))
				end

					-- Change original URI
				l_uri.wipe_out
				l_uri.append (l_new_uri)
			end
		end

	uri_variables (a_uri: STRING; a_scanner: RX_PCRE_MATCHER; a_var_extractor: RX_PCRE_MATCHER): detachable ARRAYED_LIST [TUPLE [var: STRING; start_i, end_i: INTEGER]]
			-- Extracts variables from a URI and returns a list of variables with the start and end location
			-- in characters.
			--
			-- `a_uri': A URI string containing variable
			-- `a_scanner': An expression to extract tokenized variables.
			-- `a_var_extractor': An expression used to extract the variable name from its tokenized representation
		require
			a_uri_attached: a_uri /= Void
			not_a_uri_is_empty: not a_uri.is_empty
			a_scanner_attached: a_scanner /= Void
			a_scanner_is_compiled: a_scanner.is_compiled
			a_var_extractor_attached: a_var_extractor /= Void
			a_var_extractor_is_compiled: a_var_extractor.is_compiled
		local
			l_token_var: STRING
			l_var: STRING
		do
			a_scanner.match (a_uri)
			if a_scanner.has_matched then
				create Result.make (5)
				from a_scanner.first_match until not a_scanner.has_matched loop
					l_token_var := a_scanner.captured_substring (1)
					if l_token_var /= Void then
							-- Token variable located
						if not l_token_var.is_empty then
							a_var_extractor.match (l_token_var)
							if a_var_extractor.has_matched then
									-- Variable name extracted
								l_var := a_var_extractor.captured_substring (1)
								if l_var /= Void then
									Result.extend ([l_var, a_scanner.captured_start_position (1), a_scanner.captured_end_position (1)])
								end
							end
						end
					end
					a_scanner.next_match
				end
			end
		ensure
			result_contains_attached_items: (attached {LIST [detachable ANY]} Result) implies not Result.has (Void)
			result_contains_valid_items: Result /= Void implies Result.for_all (
				agent (a_ia_item: TUPLE [var: STRING; start_i, end_i: INTEGER]): BOOLEAN
					do
						Result := (attached a_ia_item.var as l_var) and then
							not a_ia_item.var.is_empty and then
							a_ia_item.start_i > 0 and then
							a_ia_item.start_i < a_ia_item.end_i
					end)
		end

	variable_scanner_regex: RX_PCRE_MATCHER
			-- Regular expression to extract tokenized variables from a URI string
		once
			create Result.make
			Result.compile ("(\$[a-zA-Z0-9_-]+|\$\([a-zA-Z0-9_-]+\))")
		ensure
			result_attached: Result /= Void
			result_is_compiled: Result.is_compiled
		end

	variable_extractor_regex: RX_PCRE_MATCHER
			-- Regular expression to extract tokenized variables from a URI string
		once
			create Result.make
			Result.compile ("^\$\(?([^)]+)\)?$")
		ensure
			result_attached: Result /= Void
			result_is_compiled: Result.is_compiled
		end

	environment_variables: HASH_TABLE [STRING, STRING]
			-- All environment variables
		once
			Result := (create {EXECUTION_ENVIRONMENT}).starting_environment_variables.as_attached
		ensure
			result_attached: Result /= Void
		end

	es_built_in_variables: HASH_TABLE [STRING, STRING]
			-- ES built-in variables.
			-- These variables should ideally be built into a configure file.
		once
			create Result.make (3)
			Result.put ("http://dev.eiffel.com", "ISE_WIKI")
			Result.put ("http://www.eiffelroom.com", "EIFFELROOM")
			Result.put ("http://doc.eiffel.com", "ISE_DOC")
			Result.put ("http://doc.eiffel.com/isedoc/uuid", "ISE_DOC_UUID")
		ensure
			result_attached: Result /= Void
		end

note
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
