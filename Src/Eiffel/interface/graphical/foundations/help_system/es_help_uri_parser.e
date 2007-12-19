indexing
	description: "[
		A simple parser used to parse Eiffel editor embedded help URI, for the purpose of extracting a usable help context object {HELP_CONTEXT_I}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_HELP_URI_PARSER

feature -- Query

	help_provider_for_protocol (a_protocol: !STRING_GENERAL): UUID
			-- Retrieves a help provider UUID given a protocol string.
			-- Note: This function has the side effect of loading and initializing all help providers. This is because
			--       the protocol information is fetched from the help provider it self.
		require
			not_a_protocol_is_empty: not a_protocol.is_empty
		local
			l_providers: DS_BILINEAR_CURSOR [!HELP_PROVIDER_I]
			l_provider: !HELP_PROVIDER_I
		do
			if help_providers.is_service_available then
				l_providers := help_providers.service.help_providers.new_cursor
				from l_providers.start until l_providers.after or Result /= Void loop
					l_provider := l_providers.item
					if l_provider.document_protocol.as_string_8.is_case_insensitive_equal (a_protocol.as_string_8) then
						Result := l_provider.kind
					end
					l_providers.forth
				end
			end
		end

feature -- Basic operations

	parse_help_uri (a_uri: !STRING_GENERAL): HELP_CONTEXT_I
			-- Parses a URI and attempts to return a help context base on the information in the string
			--
			-- `a_uri': A help URI to parse and retrieve (hopefully) a help context object from.
			-- `Result': A help context or Void if the parsed URI was unsuccessful or no help information was available.
		require
			not_a_uri_is_empty: not a_uri.is_empty
		local
			l_regex: like uri_protocol_regex
			l_section: STRING_GENERAL
		do
			l_regex := uri_protocol_regex
			l_regex.match (a_uri.as_string_8)
			if l_regex.has_matched and l_regex.match_count > 2 then
				if {l_protocol: !STRING_GENERAL} l_regex.captured_substring (1) and {l_id: !STRING_GENERAL} l_regex.captured_substring (2) then
					if l_regex.match_count > 3 then
						l_section := l_regex.captured_substring (3)
					end
					Result := create_help_context (l_protocol, l_id, l_section)
				end
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
			result_is_help_available: Result /= Void implies Result.is_help_available
		end

feature {NONE} -- Helpers

	frozen help_providers: SERVICE_CONSUMER [HELP_PROVIDERS_S]
			-- Access to the help providers service {HELP_PROVIDERS_S} consumer
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Factory

	create_help_context (a_protocol: !STRING_GENERAL; a_context_id: !STRING_GENERAL; a_section: ?STRING_GENERAL): HELP_CONTEXT_I
			-- Creates a new help context for a given protocol.
			--
			-- `a_protocol': The help protocol to set on a resulting help context.
			-- `a_context_id': The primary help context identifier for the resulting help context.
			-- `a_section': An optional section to set on the resulting help context.
			-- `Result': A help context or Void if not help context could be created for the information provided.
		require
			help_providers_is_service_available: help_providers.is_service_available
			not_a_protocol_is_empty: not a_protocol.is_empty
			not_a_context_id_is_empty: not a_context_id.is_empty
			not_a_section_is_empty: a_section /= Void implies not a_section.is_empty
		do
			if {l_kind: !UUID} help_provider_for_protocol (a_protocol) then
				create {!BASIC_HELP_CONTEXT} Result.make (a_context_id, a_section, l_kind)
			end
		ensure
			result_is_interface_usable: Result /= Void implies Result.is_interface_usable
			result_is_help_available: Result /= Void implies Result.is_help_available
		end

feature {NONE} -- Regular expressions

	uri_protocol_regex: !RX_PATTERN_MATCHER
			-- URI pattern match used to split a help string.
		once
			create {!RX_PCRE_MATCHER} Result.make
			Result.compile ("^([^:]+):\/\/([^:]+):?(.+)?$")
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
