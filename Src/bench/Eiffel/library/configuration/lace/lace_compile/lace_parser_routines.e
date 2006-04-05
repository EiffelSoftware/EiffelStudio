indexing
	description: "Set of features needed for parsing of Lace files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date: "
	revision: "$Revision: "

deferred class
	LACE_PARSER_ROUTINES

feature -- Access

	ast: AST_LACE
			-- Last AS description

	is_in_use_file: BOOLEAN
			-- Are we parsing `use' specification of Lace or Lace itself?

feature -- Parsing

	build_ast (file_name: STRING) is
			-- Parse file named `file_name' and make built ast node
			-- (void if failure) available through `ast'.
		local
			file: KL_BINARY_INPUT_FILE
		do
			create file.make (file_name)
			file.open_read

			if not file.is_open_read then
			else
				parse_lace (file)
				file.close
			end
		end

	parse_file (file_name: STRING; in_use_file: BOOLEAN) is
			-- Parse file named `file_name' and make built ast node
			-- (void if failure) available through `ast'.
		do
			is_in_use_file := in_use_file
			set_last_syntax_error (Void)
			build_ast (file_name)
		end

feature -- Shared once

	last_syntax_error: SYNTAX_ERROR is
			-- Last syntax error generated after calling
			-- routine `parse_ast'
		do
			Result := last_syntax_cell.item
		end

	set_last_syntax_error (s: SYNTAX_ERROR) is
			-- Put the last syntax error in last_syntax_error
		do
			last_syntax_cell.put (s)
		end

feature {NONE} -- Implementation

	last_syntax_cell: CELL [SYNTAX_ERROR] is
			-- Stored value of last generated syntax error generated calling
			-- routine `parse_ast'
		once
			create Result.put (Void)
		end

	parse_lace (a_file: KL_BINARY_INPUT_FILE) is
			-- Call lace parser with a source file.
		require
			a_file_not_void: a_file /= Void
			a_file_open_read: a_file.is_open_read
		deferred
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class LACE_PARSER_ROUTINES
