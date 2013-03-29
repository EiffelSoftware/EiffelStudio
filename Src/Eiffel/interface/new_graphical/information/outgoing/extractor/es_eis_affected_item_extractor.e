note
	description: "Extractor to get affected items"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_EIS_AFFECTED_ITEM_EXTRACTOR

inherit
	ES_EIS_EXTRACTOR

create
	make

feature {NONE} -- Initialization

	make (a_for_target: BOOLEAN)
			-- Initialize with `a_for_target'
		do
			is_for_target := a_for_target
			create eis_entries.make (2)
			extract
		end

feature -- Access

	is_for_target: BOOLEAN
			-- The tag to extract

	eis_full_entries: SEARCH_TABLE [EIS_ENTRY]
			-- EIS entries including all flat entries from all associated component
		do
			Result := eis_entries
		end

feature {NONE} -- Implementation

	extract
			-- Perform extracting.
			-- Only read from the storage.
			-- The actually extracting has been done or being done at background by
			-- other extractors.
		local
			l_entry: EIS_ENTRY
		do
			create eis_entries.make (100)
			across
				storage.change_server as l_c
			loop
				l_entry := l_c.item
				if not entry_acknowledged (l_entry) then
					eis_entries.force (l_entry)
				end
			end
		end

	entry_acknowledged (a_entry: EIS_ENTRY): BOOLEAN
			-- Has `a_entry' acknowledged?
		local
			l_finger_print: EIS_FINGERPRINT
		do
			if attached storage.acknowledge_server.item (a_entry.entry_id) as l_ack then
				if is_for_target then
					if attached a_entry.source as l_source and then attached storage.fingerprint_server.item (l_source) as l_item then
						l_finger_print := l_item
					else
						l_finger_print := storage.target_fingerprint_from_entry (a_entry)
					end
					Result := l_finger_print.same_fingerprint (l_ack.resource_fingerprint)
				else
					if attached storage.fingerprint_server.item (a_entry.target_id) as l_item then
						l_finger_print := l_item
					else
						l_finger_print := storage.target_fingerprint_from_entry (a_entry)
					end
					Result := l_finger_print.same_fingerprint (l_ack.target_fingerprint)
				end
			end
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

