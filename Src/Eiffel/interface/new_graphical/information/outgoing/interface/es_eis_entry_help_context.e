indexing
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
	make

feature {NONE} -- Initialzation

	make (a_entry: !EIS_ENTRY) is
			-- Initialization
		do
			entry := a_entry
			if {lt_source: STRING_GENERAL}a_entry.source then
				help_context_id := lt_source
			else
				help_context_id := "No source available"
			end
			create {HELP_SECTION_EIS_ENTRY}help_context_section.make (a_entry)
		ensure
			entry_set: entry = a_entry
			context_section_set: help_context_section /= Void
		end

feature -- Querry

	is_interface_usable: BOOLEAN = True
			-- Dtermines if the interface was usable

feature -- Access

	help_context_id: !STRING_GENERAL
			-- <precursor>

	help_context_section: ?HELP_CONTEXT_SECTION_I
			-- <precursor>

	help_context_description: ?STRING_GENERAL
			-- An optional description of the context.
		do
			eis_output.process (entry)
			Result := eis_output.last_output_code
		end

	help_provider: !UUID
			-- <precursor>
		do
			Result := help_provider_from_protocol (entry.protocol)
		end

feature {NONE} -- Access

	entry: !EIS_ENTRY;
			-- The entry

indexing
	copyright: "Copyright (c) 1984-2007, Eiffel Software"
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
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
