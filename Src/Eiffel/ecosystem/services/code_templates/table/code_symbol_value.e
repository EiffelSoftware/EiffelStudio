note
	description: "[
		A code value for code symbol tables.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_SYMBOL_VALUE

create
	make,
	make_empty

feature {NONE} -- Initialization

	make (a_default: READABLE_STRING_32)
			-- Initializes a code symbol value using a default value string.
			--
			-- `a_default': The text to use a the default value, if no other representation is available.
		require
			a_default_attached: attached a_default
		do
			create default_value.make_from_string (a_default)
		ensure
			default_value_set: a_default.same_string (a_default)
		end

	make_empty
			-- Initializes a code symbol value using a empty value string.
		do
			create default_value.make_empty
		end

feature -- Access

	value: STRING_32 assign set_value
			-- The actual value, having been processed
		do
			if attached internal_value as l_result then
				create Result.make_from_string (l_result)
			else
				create Result.make_from_string (default_value)
			end
		ensure
			result_attached: attached Result
		end

	default_value: STRING_32
			-- A default value for a symbol table value

feature {CODE_SYMBOL_TABLE} -- Access

	symbol_table: detachable CODE_SYMBOL_TABLE assign set_symbol_table
			-- Symbol table of code values where Current resides
		note
			options: stable
		attribute
		end

feature -- Element change

	set_value (a_value: like value)
			-- Set the code symbol value.
		do
			if (not attached internal_value) or else internal_value /~ a_value then
				internal_value := a_value
				if (attached symbol_table as l_table) and then (attached l_table.id_of_value (Current) as l_id) then
					if attached {EVENT_TYPE_PUBLISHER_I [TUPLE [CODE_SYMBOL_TABLE, READABLE_STRING_8]]} l_table.value_changed_event as l_event then
						l_event.publish ([l_table, l_id])
					end
				end
			end
		ensure
			value_set: value ~ a_value
		end

feature {CODE_SYMBOL_TABLE} -- Element change

	set_symbol_table (a_table: like symbol_table)
			-- Sets the symbol table for the Current code value, used during evaluation of the symbol value.
			-- Note: Can only be set once.
			--
			-- `a_table': A new symbol table to set for Current.
		require
			a_table_attached: a_table /= Void
			symbol_table_detached: symbol_table = Void
		do
			check a_table_attached: attached a_table end
			symbol_table := a_table
		ensure
			symbol_table_set: symbol_table = a_table
		end

feature {NONE} -- Internal implementation cache

	internal_value: detachable like value
			-- Cached value of `value'.
			-- Note: Do not use directly!

invariant
	default_value_attached: attached default_value

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
