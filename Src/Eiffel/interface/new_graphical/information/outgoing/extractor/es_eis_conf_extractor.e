indexing
	description: "Extract possible information from a NOTE attributes in configuration file."
	status: "See notice at end of class."
	legal: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_CONF_EXTRACTOR

inherit
	ES_EIS_EXTRACTOR

	ES_EIS_NOTE_PICKER

create
	make

feature {NONE} -- Initialization

	make (a_notable: !CONF_NOTABLE) is
			-- Initialize with `a_notable'.
		do
			notable := a_notable
			create eis_entries.make (2)
			extract
		end

feature -- Access

	eis_full_entries: !SEARCH_TABLE [!EIS_ENTRY]
			-- EIS entries including all flat entries from all associated component
		local
			l_conf_extractor: ES_EIS_CONF_EXTRACTOR
		do
			if not {lt_full_entries: like internal_eis_full_entries}internal_eis_full_entries then
				if {lt_target: CONF_TARGET}notable then
					Result := eis_entries
				elseif {lt_group: CONF_CLUSTER}notable and then {lt_group_target: CONF_TARGET}lt_group.target then
					create l_conf_extractor.make (lt_group_target)
					Result := l_conf_extractor.eis_entries.twin
					Result.merge (eis_entries.twin)
				else
					Result := eis_entries
				end
				internal_eis_full_entries := Result
			else
				Result := internal_eis_full_entries
			end
		end

feature {NONE} -- Implementation

	extract is
			-- Perform extracting
		local
			l_notable: like notable
			l_notes: ARRAYED_LIST [HASH_TABLE [STRING_8, STRING_8]]
			l_note: HASH_TABLE [STRING_8, STRING_8]
			l_entries: !HASH_TABLE [!SEARCH_TABLE [!HASHABLE], !STRING]
			l_id: STRING
		do
				-- Compute id.
			if {lt_target: CONF_TARGET}notable then
				l_id := id_solution.id_of_target (lt_target)
			elseif {lt_cluster: CONF_CLUSTER}notable then
				l_id := id_solution.id_of_group (lt_cluster)
			end
			if {lt_id: STRING}l_id then
				l_entries := storage.entry_server.entries
				l_entries.search (lt_id)
				if not l_entries.found then
					l_notable := notable
					l_notes := l_notable.notes
					if l_notes /= Void then
						from
							l_notes.start
						until
							l_notes.after
						loop
							l_note := l_notes.item_for_iteration
							if {lt_entry: EIS_ENTRY}eis_entry_from_conf_note (l_note, lt_id) then
								eis_entries.force (lt_entry)
							end
							l_notes.forth
						end
					end
						-- Register extracted entries to EIS storage.
					if not eis_entries.is_empty then
						storage.register_entries_of_component_id (eis_entries, lt_id)
					end
				else
					if {lt_entries: like eis_entries}l_entries.found_item then
						eis_entries := lt_entries
					else
						check
							type_conformace: False
						end
					end
				end
			end
		end

feature {NONE} -- Access

	notable: !CONF_NOTABLE
			-- The item to extract EIS info from.

	internal_eis_full_entries: like eis_full_entries;
			-- Cached full entries

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
