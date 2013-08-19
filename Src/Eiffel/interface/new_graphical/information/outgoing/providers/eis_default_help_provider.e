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

	EB_SHARED_WINDOW_MANAGER

create
	make

feature -- Access

	document_protocol: STRING_32
			-- Document protocol used by a URI to navigate to the help accessible from the provider.
		once
			Result := {STRING_32} "URI"
		end

	document_description: STRING_32
			-- Document short description
		once
			Result := {STRING_32} "URI"
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
				attached lt_entry.source.twin as lt_src
			then
				last_entry := lt_entry
				format_uris (lt_src)
				if not lt_section.is_shown_in_es then
					launch_uri (lt_src)
				else
					if attached window_manager.last_focused_development_window as l_window then
						if
							attached {ES_WEB_BROWSER_TOOL_COMMANDER_I} l_window.shell_tools.tool ({ES_WEB_BROWSER_TOOL}) as l_browser and then
							l_browser.is_interface_usable
						then
							l_browser.visit (lt_src)
						end
					end
				end
			end
		end

feature -- Query

	expanded_uri_from_entry (a_entry: EIS_ENTRY): STRING_32
			-- Expanded URI from `a_entry'
		require
			a_entry_not_void: a_entry /= Void
		do
			if attached a_entry.source as l_source then
				Result := l_source.twin
				format_uris (Result)
			else
				create Result.make_empty
			end
		ensure
			Result_set: Result /= Void
		end

feature {NONE} -- Implementation

	context_variables: STRING_TABLE [READABLE_STRING_32]
			-- <precursor>
		do
			Result := eis_variables.es_built_in_variables.twin
			Result.merge (Precursor)
		end

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software"
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
