note
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
	RAW_URI_HELP_PROVIDER
		undefine
			document_protocol,
			document_description
		redefine
			help_title,
			show_help
		end

feature {NONE} -- Access

	base_url: STRING_32
			-- Base URL used to locate help documentation.
		deferred
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
			result_ends_with_url_separator: Result.item (Result.count) = url_separator
		end

	url_separator: CHARACTER_32
			-- Separator for web-urls.
		once
			Result := '/'
		end

	section_url_separator: CHARACTER_32
			-- Separator for web-urls between the help context content and the help context section.
		once
			Result := '#'
		end

feature -- Query

	help_title (a_context_id: READABLE_STRING_GENERAL; a_section: detachable HELP_CONTEXT_SECTION_I): STRING_32
			-- <Precursor>
		local
			l_title: detachable STRING_32
		do
			if is_accessible then
					-- `is_accessible' requires calling {CURL_ACCESS}.make
				l_title := document_title (full_url (a_context_id, a_section), False)
			end
			if l_title /= Void then
				Result := l_title
			else
				Result := Precursor {RAW_URI_HELP_PROVIDER} (a_context_id, a_section)
			end
		end

feature {NONE} -- Status report

	is_accessible: BOOLEAN
			-- Temporary
		do
			Result := True
		end

feature {NONE} -- Query

	full_url (a_context_id: READABLE_STRING_GENERAL; a_section: detachable HELP_CONTEXT_SECTION_I): STRING_32
			-- Full URL to navigate to, base on the help content context.
		require
			a_context_id_attached: a_context_id /= Void
			not_a_context_id_is_empty: not a_context_id.is_empty
		do
			create Result.make (256)
			Result.append (base_url)
			Result.append (format_context_id (a_context_id))
			if a_section /= Void then
				Result.append_character (section_url_separator)
				Result.append (format_context_section (a_section.section))
			end
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	document_title (a_url: READABLE_STRING_32; a_trim: BOOLEAN): detachable STRING_32
			-- Attempts to retrieve a document title from a URL.
			--
			-- `a_url': URL to fetch a document title from
			-- `a_trim': True to remove any trailing hiephenated info text from the title " - Info Text".
			-- `Result': A title, or Void if not title coule be retrieved from a URL.
		require
			is_accessible: is_accessible -- Need to call `make' from {CURL_ACCESS}.
			a_url_attached: a_url /= Void
		local
			l_result: detachable STRING_32
			l_protcol: detachable HTTP_PROTOCOL
			l_regex: like title_extract_regex
			l_url: HTTP_URL
			i: INTEGER
			retried: BOOLEAN
		do
			if not retried then
					-- Create URL string
				create l_url.make ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_url))
				create l_protcol.make (l_url)
				l_protcol.set_connect_timeout (30)
				l_protcol.set_timeout (60)
				l_protcol.set_port (80)
				l_protcol.set_read_mode
				l_protcol.open
				if l_protcol.is_open then
					l_protcol.initiate_transfer
					if l_protcol.transfer_initiated then
							-- Fetch the document
						l_regex := title_extract_regex
						create l_result.make (256)
						l_protcol.set_read_buffer_size (256)
						from
							l_protcol.read
						until
							Result /= Void or else
							l_protcol.error or else
							not l_protcol.is_packet_pending
						loop
							if attached l_protcol.last_packet as l_packet then
								l_result.append (l_packet)
								l_regex.match (l_result)
								if l_regex.has_matched then
									Result := l_regex.captured_substring (1).as_string_32
								end
							end
							if Result = Void and then l_protcol.is_packet_pending then
								l_protcol.read
							end
						end
						if Result = Void and then attached l_protcol.last_packet as l_packet then
							l_result.append (l_packet)
							l_regex.match (l_result)
							if l_regex.has_matched then
								Result := l_regex.captured_substring (1).as_string_32
							end
						end

						if attached Result and then a_trim then
							i := Result.last_index_of ('-', Result.count)
							if i > 1 then
								Result.keep_head (i - 1)
								Result.prune_all_trailing (' ')
							end
						end
					else
						-- Not good!
					end
					l_protcol.close
				else
					-- Timed out!
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		rescue
			if attached l_protcol and then l_protcol.is_open then
				l_protcol.close
			end
			retried := True
			retry
		end

feature -- Basic operations

	show_help (a_context_id: READABLE_STRING_GENERAL; a_section: detachable HELP_CONTEXT_SECTION_I)
			-- <Precursor>
		do
			Precursor (full_url (a_context_id, a_section), a_section)
		end

feature {NONE} -- Formatting

	format_context_id (a_context_id: READABLE_STRING_GENERAL): STRING_32
			-- Formats the context id so it may be used in a URL.
			--
			-- `a_context_id': A help content context identifier to format
			-- `Result': A formatted help context identifier for a URL
		require
			a_context_id_attached: a_context_id /= Void
			not_a_context_id_is_empty: not a_context_id.is_empty
		do
			Result := format_context (a_context_id)
		ensure
			result_attached: Result /= Void
			not_result_id_is_empty: not Result.is_empty
		end

	format_context_section (a_section: READABLE_STRING_GENERAL): STRING_32
			-- Formats the context section so it may be used in a URL.
			--
			-- `a_section': A help content context section to format
			-- `Result': A formatted help context section for a URL
		require
			a_section_attached: a_section /= Void
			not_a_section_is_empty: not a_section.is_empty
		do
			Result := format_context (a_section)
		ensure
			result_attached: Result /= Void
			not_result_id_is_empty: not Result.is_empty
		end

	format_context (a_context: READABLE_STRING_GENERAL): STRING_32
			-- Formats the context so it may be used in a URL.
			--
			-- `a_context': A help content context of session context identifier to format
			-- `Result': A formatted help context for a URL
		require
			a_context_attached: a_context /= Void
			not_a_context_is_empty: not a_context.is_empty
		do
			create Result.make_from_string_general (a_context)
		ensure
			result_attached: Result /= Void
			not_result_id_is_empty: not Result.is_empty
		end

feature {NONE} -- Regular expressions

	title_extract_regex: RX_PCRE_MATCHER
			-- Regular expression to extract an HTML title
		once
			create Result.make
			Result.set_caseless (True)
			Result.compile ("\<TITLE\>([^<]*)\<\/TITLE\>")
		ensure
			result_attached: Result /= Void
			result_is_compiled: Result.is_compiled
		end

;note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
