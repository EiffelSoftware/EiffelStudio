indexing
	description: "[
		Template visitor for populating a symbol table for code template evaluation.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_SYMBOL_TABLE_BUILDER

inherit
	CODE_TEMPLATE_VISITOR_ITERATOR

create
	make,
	make_with_table

feature {NONE} -- Initialization

	make (a_template: !CODE_TEMPLATE_DEFINITION)
			-- Initialize symbol table builder.
			--
			-- `a_template': Code template to use to initialize the symbol table.
		do
			make_with_table (a_template, create_symbol_table)
		end

	make_with_table (a_template: !CODE_TEMPLATE_DEFINITION; a_table: like symbol_table)
			-- Initialize symbol table builder.
			--
			-- `a_template': Code template to use to initialize the symbol table.
			-- `a_table': A symbol table to populate with the declaration default values.
		do
			symbol_table := a_table
			a_template.process (Current)
		ensure
			symbol_table_set: symbol_table = a_table
		end

feature -- Access

	symbol_table: !CODE_SYMBOL_TABLE
			-- Built code symbol table.

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature {CODE_NODE} -- Processing

	process_code_literal_declaration (a_value: !CODE_LITERAL_DECLARATION)
			-- <Precursor>
		local
			l_value: !CODE_SYMBOL_VALUE
		do
				-- Ensure old value is not overwritten.
			create l_value.make (a_value.default_value)
			symbol_table.put (l_value, a_value.id)
		end

	process_code_object_declaration (a_value: !CODE_OBJECT_DECLARATION)
			-- <Precursor>
		local
			l_value: !CODE_SYMBOL_VALUE
		do
				-- Ensure old value is not overwritten.
			create l_value.make (a_value.default_value)
			symbol_table.put (l_value, a_value.id)
		end

	process_code_template (a_value: !CODE_TEMPLATE)
			-- <Precursor>
		do
		end

	process_code_metadata (a_value: !CODE_METADATA)
			-- <Precursor>
		do
		end

	process_code_versioned_template (a_value: !CODE_VERSIONED_TEMPLATE)
			-- <Precursor>
		do
		end

feature {NONE} -- Factory

	create_symbol_table: !CODE_SYMBOL_TABLE
			-- Factory used to create the default symbol table
		do
			create Result.make
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
