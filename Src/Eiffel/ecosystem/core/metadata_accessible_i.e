indexing
	description: "[
		Provides access to retrieval and setting of properties using IDs
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	METADATA_ACCESSIBLE_I

inherit
	USABLE_I

feature -- Access

	metadata (a_id: !STRING_8): ?STRING_GENERAL
			-- Retrieve a metadata asscociated with an identifier
		require
			is_interface_usable: is_interface_usable
			a_id_is_valid_metadata_id: is_valid_metadata_id (a_id)
		deferred
		end

	metakeys: !DS_BILINEAR [!STRING_8]
			-- List of metadata keys data is index by
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_contains_valid_items: Result.for_all (agent is_valid_metadata_id)
		end

feature -- Element change

	set_metadata (a_value: ?STRING_GENERAL; a_id: !STRING_8)
			-- Sets a metadata value associate with id.
			--
			-- `a_value': Value
		require
			is_interface_usable: is_interface_usable
			a_id_is_valid_metadata_id: is_valid_metadata_id (a_id)
			a_value_is_valid_metadata_value: is_valid_metadata_value (a_value, a_id)
		deferred
		ensure
			has_metakey: a_value /= Void implies metakeys.has (a_id)
			not_has_metakey: a_value = Void implies not metakeys.has (a_id)
			metadata_set: a_value /= Void implies equal (metadata (a_id), a_value)
		end

	merge (a_metadata: !METADATA_ACCESSIBLE_I)
			-- Merges other metadata store with the current metadata store
			--
			-- `a_metadata': Other metadata to add or override the current metadata with
		require
			is_interface_usable: is_interface_usable
			a_metadata_is_interface_usable: a_metadata.is_interface_usable
		local
			l_key: !STRING_8
			l_value: ?STRING_GENERAL
		do
			if {l_cursor: !DS_BILINEAR_CURSOR [!STRING_8]} a_metadata.metakeys then
				from l_cursor.start until l_cursor.after loop
					l_key := l_cursor.item
					if is_valid_metadata_id (l_key) then
						l_value := a_metadata.metadata (l_key)
						if is_valid_metadata_value (l_value, l_key) then
							set_metadata (l_value, l_key)
						else
								-- Remove value
							set_metadata (Void, l_key)
						end
					end
					l_cursor.forth
				end
			end
		end
feature -- Query

	is_valid_metadata_id (a_id: !STRING_8): BOOLEAN
			-- Detemines if an identifier is a valid metadata identifier for `Current'
		require
			is_interface_usable: is_interface_usable
		do
			Result := not a_id.is_empty
		ensure
			not_a_id_is_empty: Result implies not a_id.is_empty
		end

	is_valid_metadata_value (a_value: ?STRING_GENERAL; a_id: !STRING_8): BOOLEAN
			-- Determines if a metadata value is valid given a metadata associated with a metadata identifier
		require
			is_interface_usable: is_interface_usable
			a_id_is_valid_metadata_id: is_valid_metadata_id (a_id)
		deferred
		ensure
			void_a_value_is_value: a_value = Void implies Result
		end

feature -- Events

	changed_events: !EVENT_TYPE [TUPLE [a_id: !STRING_8; new_value: ?STRING_GENERAL; old_value: ?STRING_GENERAL]]
			-- Events fired when a piece of metadata changes.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_consistent: Result = changed_events
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
