indexing
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

	make (a_default: like default_value)
			-- Initializes a code symbol value using a default value string.
			--
			-- `a_default': The text to use a the default value, if no other representation is available.
		do
			default_value := a_default.twin
		ensure
			default_value_set: a_default.is_equal (default_value)
		end

	make_empty
			-- Initializes a code symbol value using a empty value string.
		do
			create default_value.make_empty
		end

feature -- Access

	value: !STRING_32 assign set_value
			-- The actual value, having been processed
		do
			if internal_value /= Void then
				Result ?= internal_value.twin
			else
				Result := default_value.twin
			end
		end

	default_value: !STRING_32
			-- A default value for a symbol table value

feature {CODE_SYMBOL_TABLE} -- Access

	symbol_table: ?CODE_SYMBOL_TABLE assign set_symbol_table
			-- Symbol table of code values where Current resides

feature -- Element change

	set_value (a_value: like value)
			-- Set the code symbol value
		local
			l_table: like symbol_table
		do
			if internal_value = Void or else not internal_value.is_equal (a_value) then
				internal_value := a_value
				l_table := symbol_table
				if l_table /= Void and then {l_id: !STRING} l_table.id_of_value (Current)  then
					l_table.value_changed_events.publish ([l_id])
				end
			end
		ensure
			value_set: value.is_equal (a_value)
		end

feature {CODE_SYMBOL_TABLE} -- Element change

	set_symbol_table (a_table: like symbol_table)
			-- Sets the symbol table for the Current code value
		require
			a_table_attached: a_table /= Void
			symbol_table_detached: symbol_table = Void
		do
			symbol_table := a_table
		ensure
			symbol_table_set: symbol_table = a_table
		end

feature {NONE} -- Internal implementation cache

	internal_value: ?STRING_32
			-- Cached value of `value'
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
