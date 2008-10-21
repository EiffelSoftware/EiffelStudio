indexing
	description: "[
		A code template render engine symbol table, for code token replacements.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_SYMBOL_TABLE

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes a new symbol table for a code template edit session
		do
			create content_table.make_default
				-- We currently use `attemp' from {TYPE} to get around the fact the Gobo does not yet use attachment marks.
			content_table.set_key_equality_tester (({KL_EQUALITY_TESTER [!STRING]}) #? create {KL_CASE_INSENSITIVE_STRING_EQUALITY_TESTER})
		end

feature -- Access

	item (a_id: !STRING_8): !CODE_SYMBOL_VALUE
			-- Retrieve the current value for a given symbol identifier.
			--
			-- `a_id': A symbol identifier to retrieve a value for.
			-- `Result': The associated code value.
		require
			not_a_id_is_empty: not a_id.is_empty
			has_id_a_id: has_id (a_id)
		do
			if content_table.has (a_id) then
					-- The postcondition of `has_id' does not guarentee 'content_table.has (a_id)'. This is because in the future
					-- values may be fetched lazily, when using function evaluation
				Result := content_table.item (a_id)
			else
				create Result.make_empty
			end
		end

feature {NONE} -- Access

	content_table: !DS_HASH_TABLE [!CODE_SYMBOL_VALUE, !STRING_8]
			-- Table of indentiers and mapped values

feature -- Element change

	put (a_value: !CODE_SYMBOL_VALUE; a_id: !STRING_8)
			-- Extends the symbol table with a new id/value pair.
			--
			-- `a_value': A value to associated with an indentifier in the symbol table.
			-- `a_id': The indentifier to associate with the value.
		require
			not_a_id_is_empty: not a_id.is_empty
			not_has_id_a_id: not has_id (a_id)
		do
			a_value.set_symbol_table (Current)
			content_table.put (a_value, a_id)
			value_changed_events.publish ([a_id])
		ensure
			has_id_a_id: has_id (a_id)
			a_value_set: item (a_id).is_equal (a_value)
			a_value_symbol_table_set: a_value.symbol_table = Current
		end

	force (a_value: !CODE_SYMBOL_VALUE; a_id: !STRING_8)
			-- Forces extending of the symbol table with a new id/value pair.
			--
			-- `a_value': A value to associated with an indentifier in the symbol table.
			-- `a_id': The indentifier to associate with the value.
		require
			not_a_id_is_empty: not a_id.is_empty
		do
			a_value.set_symbol_table (Current)
			content_table.force (a_value, a_id)
			value_changed_events.publish ([a_id])
		ensure
			has_id_a_id: has_id (a_id)
			a_value_set: item (a_id).is_equal (a_value)
			a_value_symbol_table_set: a_value.symbol_table = Current
		end

feature -- Query

	has_id (a_id: !STRING): BOOLEAN
			-- Determines if the symbol table contains an identifier.
			--
			-- `a_id': The identifier to check for existence.
			-- `Result': True if the identifier exists in the table; False otherwise
		require
			not_a_id_is_empty: not a_id.is_empty
		do
			Result := content_table.has (a_id)
		ensure
			content_table_has_a_id: Result implies content_table.has (a_id)
		end

feature {CODE_SYMBOL_VALUE} -- Query

	id_of_value (a_value: !CODE_SYMBOL_VALUE): ?STRING
			-- Retrieves the ID of a code symbol value.
			--
			-- `a_value': The value to retrieve an ID for
			-- `Result': An id in teh current table or Void if the value was not located.
		do
			content_table.start
			content_table.search_forth (a_value)
			if not content_table.after then
				Result := content_table.key_for_iteration
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			has_id_result: Result /= Void implies has_id (Result)
		end

feature -- Events

	value_changed_events: !EVENT_TYPE [TUPLE [id: !STRING_8]]
			-- Actions called when a value in the symbol table is changed
		do
			if internal_value_changed_events = Void then
				create Result
				internal_value_changed_events := Result
			else
				Result ?= internal_value_changed_events
			end
		end

feature {NONE} -- Internal implementation cache

	internal_value_changed_events: EVENT_TYPE [TUPLE [id: !STRING_8]]
			-- Cached version of `value_changed_events'
			-- Note: Do not use directly!

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
