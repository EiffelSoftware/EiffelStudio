note
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
			create content_table.make_caseless (5)
		end

feature -- Access

	item (a_id: READABLE_STRING_32): CODE_SYMBOL_VALUE
			-- Retrieve the current value for a given symbol identifier.
			--
			-- `a_id': A symbol identifier to retrieve a value for.
			-- `Result': The associated code value.
		require
			a_id_attached: attached a_id
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
		ensure
			result_attached: attached Result
		end

feature {NONE} -- Access

	content_table: STRING_TABLE [CODE_SYMBOL_VALUE]
			-- Table of indentiers and mapped values

feature -- Element change

	put (a_value: CODE_SYMBOL_VALUE; a_id: READABLE_STRING_32)
			-- Extends the symbol table with a new id/value pair.
			--
			-- `a_value': A value to associated with an indentifier in the symbol table.
			-- `a_id': The indentifier to associate with the value.
		require
			a_value_attached: attached a_value
			not_a_id_is_empty: not a_id.is_empty
			a_id_attached: attached a_id
			not_has_id_a_id: not has_id (a_id)
		do
			a_value.set_symbol_table (Current)
			content_table.put (a_value, a_id)
			if attached internal_value_changed_event as l_event then
				l_event.publish ([Current, a_id])
			end
		ensure
			has_id_a_id: has_id (a_id)
			a_value_set: item (a_id).is_equal (a_value)
			a_value_symbol_table_set: a_value.symbol_table = Current
		end

	force (a_value: CODE_SYMBOL_VALUE; a_id: READABLE_STRING_32)
			-- Forces extending of the symbol table with a new id/value pair.
			--
			-- `a_value': A value to associated with an indentifier in the symbol table.
			-- `a_id': The indentifier to associate with the value.
		require
			a_value_attached: attached a_value
			a_id_attached: attached a_id
			not_a_id_is_empty: not a_id.is_empty
		do
			a_value.set_symbol_table (Current)
			content_table.force (a_value, a_id)
			if attached internal_value_changed_event as l_event then
				l_event.publish ([Current, a_id])
			end
		ensure
			has_id_a_id: has_id (a_id)
			a_value_set: item (a_id).is_equal (a_value)
			a_value_symbol_table_set: a_value.symbol_table = Current
		end

feature -- Query

	has_id (a_id: READABLE_STRING_32): BOOLEAN
			-- Determines if the symbol table contains an identifier.
			--
			-- `a_id': The identifier to check for existence.
			-- `Result': True if the identifier exists in the table; False otherwise
		require
			a_id_attached: a_id /= Void
			not_a_id_is_empty: not a_id.is_empty
		do
			Result := content_table.has (a_id)
		ensure
			content_table_has_a_id: Result implies content_table.has (a_id)
		end

feature {CODE_SYMBOL_VALUE} -- Query

	id_of_value (a_value: CODE_SYMBOL_VALUE): detachable STRING_32
			-- Retrieves the ID of a code symbol value.
			--
			-- `a_value': The value to retrieve an ID for
			-- `Result': An id in the current table or Void if the value was not located.
		require
			a_value_attached: a_value /= Void
		local
			l_table: like content_table
		do
			l_table := content_table
			l_table.start
			across
				l_table as l_c
			until
				Result /= Void
			loop
				if l_c = a_value then
					create Result.make_from_string_general (@ l_c.key)
				end
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
			has_id_result: Result /= Void implies has_id (Result)
		end

feature -- Events

	value_changed_event: EVENT_TYPE_I [TUPLE [sender: CODE_SYMBOL_TABLE; id: READABLE_STRING_32]]
			-- Actions called when a value in the symbol table is changed
			--
			-- 'sender': Sender of the event.
			-- 'id': The id of the change symbol table value.
		local
			l_event: like internal_value_changed_event
		do
			if attached internal_value_changed_event as l_result then
				Result := l_result
			else
				create l_event
				Result := l_event
				internal_value_changed_event := l_event
			end
		ensure
			result_attached: Result /= Void
			result_consistent: Result = value_changed_event
		end

feature {NONE} -- Internal implementation cache

	internal_value_changed_event: detachable EVENT_TYPE [TUPLE [sender: CODE_SYMBOL_TABLE; id: READABLE_STRING_32]]
			-- Cached version of `value_changed_event'
			-- Note: Do not use directly!

invariant
	content_table_attached: content_table /= Void

;note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software"
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
