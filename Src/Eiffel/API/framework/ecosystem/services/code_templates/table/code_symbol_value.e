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
	make

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

feature -- Access

	value: !STRING_32
			-- The actual value, having been processed
		do
			Result := default_value.twin
		end

	default_value: !STRING_32
			-- A default value for a symbol table value

feature {CODE_SYMBOL_TABLE} -- Access

	symbol_table: ?CODE_SYMBOL_TABLE assign set_symbol_table
			-- Symbol table of code values where Current resides

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
