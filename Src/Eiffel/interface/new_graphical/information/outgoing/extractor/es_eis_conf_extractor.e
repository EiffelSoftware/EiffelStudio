note
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

	make (a_notable: attached CONF_NOTABLE; a_force: BOOLEAN)
			-- Initialize with `a_notable'.
		do
			notable := a_notable
			create eis_entries.make (2)
			force_extracting := a_force
			extract
		ensure
			force_extracting_set: force_extracting = a_force
		end

feature -- Access

	eis_full_entries: attached SEARCH_TABLE [EIS_ENTRY]
			-- EIS entries including all flat entries from all associated component
		local
			l_conf_extractor: ES_EIS_CONF_EXTRACTOR
		do
			if not attached internal_eis_full_entries as lt_full_entries then
				if attached {CONF_TARGET} notable as lt_target then
					Result := eis_entries
				elseif attached {CONF_CLUSTER} notable as lt_group and then attached {CONF_TARGET} lt_group.target as lt_group_target then
					create l_conf_extractor.make (lt_group_target, True)
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

	extract
			-- Perform extracting
			-- Always real extracting since it is relatively light for conf notes.
		local
			l_notable: like notable
			l_notes: ARRAYED_LIST [HASH_TABLE [STRING_8, STRING_8]]
			l_note: HASH_TABLE [STRING_8, STRING_8]
			l_entries: HASH_TABLE [SEARCH_TABLE [HASHABLE], STRING]
			l_id: STRING
			l_date: INTEGER
		do
				-- Compute id.
			if attached {CONF_TARGET} notable as lt_target then
				l_id := id_solution.id_of_target (lt_target)
				l_date := lt_target.system.file_date
			elseif attached {CONF_CLUSTER} notable as lt_cluster then
				l_id := id_solution.id_of_group (lt_cluster)
				l_date := lt_cluster.target.system.file_date
			else
				check not_possible: False end
			end
			if attached {STRING} l_id as lt_id then
				l_entries := storage.entry_server.entries
				l_entries.search (lt_id)
				if not l_entries.found or force_extracting then
					l_notable := notable
					l_notes := l_notable.notes
					if l_notes /= Void then
						from
							l_notes.start
						until
							l_notes.after
						loop
							l_note := l_notes.item_for_iteration
							if attached {EIS_ENTRY} eis_entry_from_conf_note (l_note, lt_id) as lt_entry then
								eis_entries.force (lt_entry)
							end
							l_notes.forth
						end
					end
						-- Register extracted entries to EIS storage.
					if not eis_entries.is_empty then
						storage.register_entries_of_component_id (eis_entries, lt_id, l_date)
					end
				else
					if attached {like eis_entries} l_entries.found_item as lt_entries then
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

	notable: attached CONF_NOTABLE
			-- The item to extract EIS info from.

	internal_eis_full_entries: like eis_full_entries;
			-- Cached full entries

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
