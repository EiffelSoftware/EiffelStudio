note
	description: "Help context of EIS entries."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_ENTRY_HELP_CONTEXT

inherit
	HELP_CONTEXT_I
		redefine
			help_provider
		end

	ES_EIS_HELP_PROVIDER_HELPER
		export
			{NONE} all
		end

	ES_EIS_SHARED
		export
			{NONE} all
		end

create
	make,
	make_from_other

feature {NONE} -- Initialzation

	make (a_entry: EIS_ENTRY; a_shown_in_es: BOOLEAN)
			-- Initialization
		require
			a_entry_not_void: a_entry /= Void
		do
			entry := a_entry
			if attached a_entry.source as l_source and then not l_source.is_empty then
				help_context_id := l_source
			else
				help_context_id := "No source available"
			end
			create help_context_section.make (a_entry, a_shown_in_es)
		ensure
			entry_set: entry = a_entry
			context_section_set: help_context_section /= Void
		end

	make_from_other (other: like Current)
			-- Initialization
		require
			a_entry_not_void: other /= Void
		do
			make (other.entry, other.help_context_section.is_shown_in_es)
		ensure
			context_section_set: help_context_section /= Void
		end

feature -- Query

	is_interface_usable: BOOLEAN = True
			-- Dtermines if the interface was usable

	is_http_link: BOOLEAN
			-- Is http link?
		do
			Result := help_context_id.same_caseless_characters ("http:", 1, 5, 1)
		end

	is_web_browser_tool_usable: BOOLEAN
			-- Is web browser tool usable?
		local
			l_browser: EV_WEB_BROWSER
		once
			create l_browser
			Result := l_browser.is_browser_usable
		end

feature -- Element Change

	set_is_shown_in_es (a_shown_in_es: BOOLEAN)
			-- Set is shown in es?
		do
			help_context_section.set_is_shown_in_es (a_shown_in_es)
		end

feature -- Access

	help_context_id: STRING_32
			-- <precursor>

	help_context_section: HELP_SECTION_EIS_ENTRY
			-- <precursor>

	help_context_description: detachable STRING_32
			-- An optional description of the context.
		do
			eis_output.process (entry)
			Result := eis_output.last_output_code
		end

	help_provider: UUID
			-- <precursor>
		do
			Result := help_provider_from_protocol (entry.protocol)
		end

feature {ES_EIS_ENTRY_HELP_CONTEXT} -- Access

	entry: EIS_ENTRY;
			-- The entry

invariant
	entry_attached: entry /= Void
	help_context_id_attached: help_context_id /= Void
	not_help_context_id_is_empty: not help_context_id.is_empty
	help_context_section_set: help_context_section /= Void

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
