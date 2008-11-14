indexing
	description: "[
		Provides access to retrieval and setting of properties using IDs
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	METADATA_ACCESSIBLE

inherit
	METADATA_ACCESSIBLE_I

feature {NONE} -- Initialization

	initialize_metadata (a_table: !DS_HASH_TABLE [?STRING_GENERAL, !STRING_8])
			-- Initializes metadata table on first use.
			-- Note: No change events are raised during initialization
			--
			-- `a_table': Source table to extract metadata from.
		local
			l_table: like internal_metadata_table
			l_cursor: DS_HASH_TABLE_CURSOR [?STRING_GENERAL, !STRING_8]
		do
			l_table := internal_metadata_table
			if l_table = Void or else l_table.is_empty then
					-- No table created yet
				internal_metadata_table := a_table.twin
			else
					-- Merge entries
				l_cursor := a_table.new_cursor
				from l_cursor.start until l_cursor.after loop
					if is_valid_metadata_id (l_cursor.key) then
						if {l_value: STRING_GENERAL} l_cursor.item then
							if is_valid_metadata_value (l_value, l_key) then
								l_table.force (l_value, l_key)
							end
						else
							l_table.remove (l_key)
						end
					end
					l_cursor.forth
				end
			end
		end

feature -- Access

	metadata (a_id: !STRING_8): ?STRING_GENERAL assign set_metadata
			-- Retrieve a metadata asscociated with an identifier
		local
			l_table: like internal_metadata_table
		do
			l_table := internal_metadata_table
			if l_table /= Void and then l_table.has (a_id) then
				Result := l_table.item (a_id)
			end
		end

feature {NONE} -- Access

	frozen metadata_table: !DS_HASH_TABLE [!STRING_GENERAL, !STRING_8]
			-- Table of stored properties.
		do
			l_result := internal_metadata_table
			if l_result = Void then
				create Result.make_default
				internal_metadata_table := Result
			else
				Result := l_result
			end
		ensure
			result_consistent: Result = metadata_table
		end

feature -- Element change

	set_metadata (a_value: ?STRING_GENERAL; a_id: !STRING_8)
			-- Sets a metadata value associate with id.
			--
			-- `a_value': Value
		local
			l_old_value: ?STRING_GENERAL
			l_table: like internal_metadata_table
		do
			l_old_value := metadata (a_id)
			if not equal (l_old_value, a_value) then
				if {l_value: STRING_GENERAL} a_value then
					metadata_table.force (l_value, a_id)
				else
					l_table := internal_metadata_table
					if l_table /= Void and then l_table.has (a_id) then
						l_table.remove (a_id)
					end
				end

					-- Publish events
				changed_events.publish ([a_id, a_value, l_old_value])
			end
		end

feature -- Events

	changed_events: !EVENT_TYPE [TUPLE [a_id: !STRING_8; new_value: ?STRING_GENERAL; old_value: ?STRING_GENERAL]]
			-- Events fired when a piece of metadata changes.
		local
			l_result: like internal_change_events
		do
			l_result := internal_change_events
			if l_result = Void then
				create Result
				internal_changed_events := Result
			else
				Result := l_result
			end
		end

feature {NONE} -- Internal implementation cache

	frozen internal_metadata_table: ?DS_HASH_TABLE [!STRING_GENERAL, !STRING_8]
			-- Cached version of `metadata_table'
			-- Note: Do not use directly!

	frozen internal_changed_events: ?EVENT_TYPE [TUPLE [a_id: !STRING_8; new_value: ?STRING_GENERAL; old_value: ?STRING_GENERAL]]
			-- Cached version of `changed_events'
			-- Note: Do not use directly!

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
