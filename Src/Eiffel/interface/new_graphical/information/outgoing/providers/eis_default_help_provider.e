note
	description: "Default help provider for EIS entries."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EIS_DEFAULT_HELP_PROVIDER

inherit
	ES_EIS_ENTRY_HELP_PROVIDER
		redefine
			show_help,
			context_variables
		end

create
	make

feature -- Access

	document_protocol: STRING
			-- Document protocol used by a URI to navigate to the help accessible from the provider.
		once
			create Result.make_empty
			Result.append ("URI")
		end

	document_description: STRING_32
			-- Document short description
		once
			create Result.make_empty
			Result.append ("URI")
		end

feature -- Basic operation

	show_help (a_context_id: READABLE_STRING_GENERAL; a_section: HELP_CONTEXT_SECTION_I)
			-- <precursor>
		do
			if
				attached {HELP_SECTION_EIS_ENTRY} a_section as lt_section and then
				attached lt_section.entry as lt_entry and then
				lt_entry.source /= Void and then
				not lt_entry.source.is_empty and then
				attached lt_entry.source.as_string_8.twin as lt_src	 -- |FIXME: Bad conversion to STRING_8
			then
				last_entry := lt_entry
				format_uris (lt_src)
				launch_uri (lt_src)
			end
		end

	es_built_in_variables: HASH_TABLE [STRING, STRING]
			-- ES built-in variables.
			-- These variables should ideally be built into a configure file.
		once
			create Result.make (5)
			Result.put ("http://dev.eiffel.com", "ISE_WIKI")
			Result.put ("http://www.eiffelroom.com", "EIFFELROOM")
			Result.put ("http://doc.eiffel.com", "ISE_DOC")
			Result.put ("http://doc.eiffel.com/isedoc/uuid", "ISE_DOC_UUID")
			Result.put ("http://doc.eiffel.com/isedoc/eis", "ISE_DOC_REF")
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Implementation

	context_variables: HASH_TABLE [STRING_8, READABLE_STRING_8]
			-- <precursor>
		do
			Result := es_built_in_variables.twin
			Result.merge (Precursor)
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
