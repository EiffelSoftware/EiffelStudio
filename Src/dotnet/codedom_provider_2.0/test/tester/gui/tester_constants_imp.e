indexing
	description: "Objects that provide access to constants loaded from files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TESTER_CONSTANTS_IMP
	
feature {NONE} -- Initialization

	initialize_constants is
			-- Load all constants from file.
		local
			file: PLAIN_TEXT_FILE
		do
			if not constants_initialized then
				create file.make (file_name)
				if file.exists then
					file.open_read
					file.readstream (file.count)
					file.close
					parse_file_contents (file.laststring)
				end
				initialized_cell.put (True)
			end
		ensure
			initialized: constants_initialized
		end

feature -- Access

	compile_unit_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (icons_directory)
			a_file_name.set_file_name ("compile_unit.png")
			set_with_named_file (Result, a_file_name)
		end

	compile_compile_unit_label: STRING is
			-- `Result' is STRING constant named `compile_compile_unit_label'.
		once
			Result := "Compile assembly from compile unit"
		end

	icons_directory: STRING is
			-- `Result' is DIRECTORY constant named `icons_directory'.
		once
			Result := "E:\Sources\dotnet\codedom_provider\test\tester\icons"
		end

	expression_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (icons_directory)
			a_file_name.set_file_name ("expression.png")
			set_with_named_file (Result, a_file_name)
		end

	generator_tab_title: STRING is
			-- `Result' is STRING constant named `generator_tab_title'.
		once
			Result := "Generator"
		end

	generate_type_label: STRING is
			-- `Result' is STRING constant named `generate_type_label'.
		once
			Result := "Generate from type"
		end

	type_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (icons_directory)
			a_file_name.set_file_name ("type.png")
			set_with_named_file (Result, a_file_name)
		end

	generate_namespace_label: STRING is
			-- `Result' is STRING constant named `generate_namespace_label'.
		once
			Result := "Generate from namespace"
		end

	generate_expression_label: STRING is
			-- `Result' is STRING constant named `generate_expression_label'.
		once
			Result := "Generate from expression"
		end

	namespace_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (icons_directory)
			a_file_name.set_file_name ("namespace.png")
			set_with_named_file (Result, a_file_name)
		end

	select_codedom_tree_label: STRING is
			-- `Result' is STRING constant named `select_codedom_tree_label'.
		once
			Result := "Select codedom tree"
		end

	generate_statement_label: STRING is
			-- `Result' is STRING constant named `generate_statement_label'.
		once
			Result := "Generate from statement"
		end

	select_compile_unit_label: STRING is
			-- `Result' is STRING constant named `select_compile_unit_label'.
		once
			Result := "Select CodeDom compile unit"
		end

	generate_compile_unit_label: STRING is
			-- `Result' is STRING constant named `generate_compile_unit_label'.
		once
			Result := "Generate from compile unit"
		end

	statement_png: EV_PIXMAP is
		local
			a_file_name: FILE_NAME
		Once
			create Result
			create a_file_name.make_from_string (icons_directory)
			a_file_name.set_file_name ("statement.png")
			set_with_named_file (Result, a_file_name)
		end


feature -- Access

--| FIXME `constant_by_name' and `has_constant' `constants_initialized' are only required until the complete change to
--| constants is complete. They are required for the pixmaps at the moment.

	constants_initialized: BOOLEAN is
			-- Have constants been initialized from file?
		do
			Result := initialized_cell.item
		end

	string_constant_by_name (a_name: STRING): STRING is
			-- `Result' is STRING 
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		do
			Result := (all_constants.item (a_name)).twin
		ensure
			Result_not_void: Result /= Void
		end
		
	integer_constant_by_name (a_name: STRING): INTEGER is
			-- `Result' is STRING 
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		local
			l_string: STRING
		do
			l_string := (all_constants.item (a_name)).twin
			check
				is_integer: l_string.is_integer
			end
			
			Result := l_string.to_integer
		end
		
	has_constant (a_name: STRING): BOOLEAN is
			-- Does constant `a_name' exist?
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
		do
			Result := all_constants.item (a_name) /= Void
		end

feature {NONE} -- Implementation

	initialized_cell: CELL [BOOLEAN] is
			-- A cell to hold whether the constants have been loaded.
		once
			create Result
		end
		
	all_constants: HASH_TABLE [STRING, STRING] is
			-- All constants loaded from constants file.
		once
			create Result.make (4)
		end
		
	file_name: STRING is "constants.txt"
		-- File name from which constants must be loaded.
		
	String_constant: STRING is "STRING"
	
	Integer_constant: STRING is "INTEGER"
		
	parse_file_contents (content: STRING) is
			-- Parse contents of `content' into `all_constants'.
		local
			line_contents: STRING
			is_string: BOOLEAN
			is_integer: BOOLEAN
			start_quote1, end_quote1, start_quote2, end_quote2: INTEGER
			name, value: STRING
		do
			from
			until
				content.is_equal ("")
			loop
				line_contents := first_line (content)
				if line_contents.count /= 1 then
					is_string := line_contents.substring_index (String_constant, 1) /= 0
					is_integer := line_contents.substring_index (Integer_constant, 1) /= 0
					if is_string or is_integer then
						start_quote1 := line_contents.index_of ('"', 1)
						end_quote1 := line_contents.index_of ('"', start_quote1 + 1)
						start_quote2 := line_contents.index_of ('"', end_quote1 + 1)
						end_quote2 := line_contents.index_of ('"', start_quote2 + 1)
						name := line_contents.substring (start_quote1 + 1, end_quote1 - 1)
						value := line_contents.substring (start_quote2 + 1, end_quote2 - 1)
						all_constants.put (value, name)
					end
				end
			end
		end
		
	first_line (content: STRING): STRING is
			-- `Result' is first line of `Content',
			-- which will be stripped from `content'.
		require
			content_not_void: content /= Void
			content_not_empty: not content.is_empty
		local
			new_line_index: INTEGER		
		do
			new_line_index := content.index_of ('%N', 1)
			if new_line_index /= 0 then
				Result := content.substring (1, new_line_index)
				content.keep_tail (content.count - new_line_index)
			else
				Result := content.twin
				content.keep_head (0)
			end
		ensure
			Result_not_void: Result /= Void
			no_characters_lost: old content.count = Result.count + content.count
		end

	set_with_named_file (a_pixmap: EV_PIXMAP; a_file_name: STRING) is
			-- Set image of `a_pixmap' from file, `a_file_name'.
			-- If `a_file_name' does not exist, do nothing.
		require
			a_pixmap_not_void: a_pixmap /= Void
			a_file_name /= Void
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_file_name)
			if l_file.exists then
				a_pixmap.set_with_named_file (a_file_name)
			end
		end

invariant
	all_constants_not_void: all_constants /= Void

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
end -- class TESTER_CONSTANTS_IMP
