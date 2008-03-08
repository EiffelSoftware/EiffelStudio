indexing
	description: "[
		A base implementation for a help provider used to fetch content online.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

deferred class
	WEB_HELP_PROVIDER

inherit
	HELP_PROVIDER_I
		redefine
			help_title
		end

	CURL_ACCESS
		export
			{NONE} all
		end

feature -- Access

	help_title (a_context_id: !STRING_GENERAL; a_section: ?STRING_GENERAL): !STRING_32
			-- A human readable title for a help document, given a context id and section.
			--
			-- `a_context_id': The primary help provider's linkable context content id, used to locate a help document.
			-- `a_section': An optional section to locate sub context in the to-be-shown help document.
		do
			if is_accessible and then {l_title: !STRING_32} document_title (full_url (a_context_id, a_section), False) then
					-- `is_accessible' requires calling {CURL_ACCESS}.make
				Result := l_title
			else
				Result := Precursor {HELP_PROVIDER_I} (a_context_id, a_section)
			end
		end

feature {NONE} -- Access

	base_url: !STRING_8
			-- Base URL used to locate help documentation.
		deferred
		ensure
			not_result_is_empty: not Result.is_empty
			result_ends_with_url_separator: Result.item (Result.count) = url_separator
		end

	url_separator: CHARACTER
			-- Separator for web-urls.
		once
			Result := '/'
		ensure
			result_is_printable: Result.is_printable
		end

	section_url_separator: CHARACTER
			-- Separator for web-urls between the help context content and the help context section.
		once
			Result := '#'
		ensure
			result_is_printable: Result.is_printable
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- Dtermines if the interface was usable
		once
			Result := True
		end

feature {NONE} -- Query

	full_url (a_context_id: !STRING_GENERAL; a_section: ?STRING_GENERAL): !STRING_8
			-- Full URL to navigate to, base on the help content context.
		require
			not_a_context_id_is_empty: not a_context_id.is_empty
			not_a_section_is_empty: a_section /= Void implies not a_section.is_empty
		do
			create {!STRING_8} Result.make (256)
			Result.append (base_url.as_string_8)
			Result.append (format_context_id (a_context_id).as_string_8)
			if {l_section: !STRING_GENERAL} a_section and then not l_section.is_empty then
				Result.append_character (section_url_separator)
				Result.append (format_context_section (l_section).as_string_8)
			end
		ensure
			not_result_is_empty: not Result.is_empty
		end

	document_title (a_url: !STRING_GENERAL; a_trim: BOOLEAN): ?STRING_32
			-- Attempts to retrieve a document title from a URL
			--
			-- `a_url': URL to fetch a document title from
			-- `a_trim': True to remove any trailing hiephenated info text from the title " - Info Text".
			-- `Result': A title, or Void if not title coule be retrieved from a URL.
		require
			is_accessible: is_accessible -- Need to call `make' from {CURL_ACCESS}.
		local
			l_curl: like curl
			l_data: !CURL_STRING
			l_result: ?STRING_GENERAL
			l_regex: like title_extract_regex
			i: INTEGER
		do
			l_curl := curl
			l_curl.setopt_string (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_url, a_url)
			l_curl.setopt_integer (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_post, 0)

			create l_data.make_empty
			curl.setopt_curl_string (curl_hnd, {CURL_OPT_CONSTANTS}.curlopt_writedata, l_data)

			perform

			l_result := l_data.string
			if l_result /= Void and then not l_result.is_empty then
				l_regex := title_extract_regex
				l_regex.match (l_result.as_string_8)
				if l_regex.has_matched then
					Result := l_regex.captured_substring (1).as_string_32
					if a_trim then
						i := Result.last_index_of ('-', Result.count)
						if i > 1 then
							Result.keep_head (i - 1)
							Result.prune_all_trailing (' ')
						end
					end
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

feature -- Basic operations

	show_help (a_context_id: !STRING_GENERAL; a_section: ?STRING_GENERAL)
			-- Attempts to show help for a specific context using the current help provider.
			--
			-- `a_context_id': The primary help provider's linkable context content id, used to locate a help document.
			-- `a_section': An optional section to locate sub context in the to-be-shown help document.
		do
			launch_url (full_url (a_context_id, a_section))
		end

feature {NONE} -- Basic operations

	launch_url (a_url: !STRING_8)
			-- Launches url in the default web browser.
			--
			-- `a_url': The URL to launch in a web-browser.
		require
			not_a_url_is_empty: not a_url.is_empty
		local
			l_cmd: STRING_8
		do
			if {PLATFORM}.is_windows then
					-- Use start command to open a URL
				l_cmd := "cmd /C start " + a_url
			else
					-- Simple python script to open a URL, for now.
				l_cmd := "python -c %"import webbrowser; webbrowser.open ('" + a_url + "')%""
			end
			if {l_process: !PROCESS} (create {PROCESS_FACTORY}).process_launcher (l_cmd, Void, Void) then
				l_process.set_hidden (True)
				l_process.launch
			end
		end

feature {NONE} -- Formatting

	format_context_id (a_context_id: !STRING_GENERAL): !STRING_8
			-- Formats the context id so it may be used in a URL.
			--
			-- `a_context_id': A help content context identifier to format
			-- `Result': A formatted help context identifier for a URL
		require
			not_a_context_id_is_empty: not a_context_id.is_empty
		do
			Result := format_context (a_context_id)
		ensure
			not_result_id_is_empty: not Result.is_empty
		end

	format_context_section (a_section: !STRING_GENERAL): !STRING_8
			-- Formats the context section so it may be used in a URL.
			--
			-- `a_section': A help content context section to format
			-- `Result': A formatted help context section for a URL
		require
			not_a_section_is_empty: not a_section.is_empty
		do
			Result := format_context (a_section)
		ensure
			not_result_id_is_empty: not Result.is_empty
		end

	format_context (a_context: !STRING_GENERAL): !STRING_8
			-- Formats the context so it may be used in a URL.
			--
			-- `a_context': A help content context of session context identifier to format
			-- `Result': A formatted help context for a URL
		require
			not_a_context_id_is_empty: not a_context.is_empty
		do
			Result ?= a_context.as_string_8
			if Result = a_context then
				Result := Result.twin
			end
		ensure
			not_result_id_is_empty: not Result.is_empty
		end

feature {NONE} -- Regular expressions

	title_extract_regex: !RX_PATTERN_MATCHER
			-- Regular expression to extract an HTML title
		local
			l_regex: !RX_PCRE_MATCHER
		once
			create l_regex.make
			l_regex.set_caseless (True)
			l_regex.compile ("\<TITLE\>([^<]*)\<\/TITLE\>")

			Result ?= l_regex
		ensure
			result_is_compiled: Result.is_compiled
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
