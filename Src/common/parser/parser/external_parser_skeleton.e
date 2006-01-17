indexing

	description: "Lace parser skeletons"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class EXTERNAL_PARSER_SKELETON

inherit

	YY_PARSER_SKELETON
		rename
			parse as yyparse,
			make as make_parser_skeleton
		redefine
			report_error, clear_all
		end

	EXTERNAL_SCANNER
		rename
			make as make_lace_scanner
		redefine
			reset
		end

	SHARED_IL_CONSTANTS
		rename
			valid_type as valid_il_type
		export {NONE} all end

	SHARED_CPP_CONSTANTS
		rename
			valid_type as valid_cpp_type
		export {NONE} all end

	SHARED_ERROR_HANDLER
		export {NONE} all end

	COMPILER_EXPORTER
		export {NONE} all end

feature {NONE} -- Initialization

	make is
			-- Create a new Lace parser.
		do
			make_lace_scanner
			make_parser_skeleton
		end

feature -- Initialization

	reset is
			-- Reset Parser before parsing next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor
		end

feature -- Parsing

	parse_external (a_line: INTEGER; a_file: STRING; a_string: STRING) is
			-- Parse external clause text from `a_string' located in `a_file'.
			-- Make result available in `root_node'.
			-- An exception is raised if a syntax error is found.
		do
			file_line := a_line
			root_node := Void
			external_syntax_error := Void
			input_buffer := create {YY_BUFFER}.make (a_string)
			yy_load_input_buffer
			filename := a_file
			yyparse
			reset
		rescue
			reset
		end

feature -- Access

	filename: STRING
			-- Current parsed file.
	
	root_node: EXTERNAL_EXTENSION_AS
			-- Result of parsing

	file_line: INTEGER
			-- Current line of parsing in class text `filename'.

	external_syntax_error: SYNTAX_ERROR
			-- Current syntax error if any.
			
	has_error: BOOLEAN is
			-- Did an error occcur at last parsing?	
		do
			Result := external_syntax_error /= Void
		end

feature -- Removal

	wipe_out is
			-- Release unused objects to garbage collector.
		do
			root_node := Void
			clear_stacks
		ensure
			root_node_void: root_node = Void
		end

	clear_all is
			-- Clear temporary objects so that they can be collected
			-- by the garbage collector. (This routine is called by
			-- `parse' before exiting.)
		do
		end

feature {NONE} -- Actions

feature {NONE} -- Keywords

feature {NONE} -- Error handling

	report_error (a_message: STRING) is
			-- A syntax error has been detected.
		do
			create external_syntax_error.make (file_line,
				 position, filename, "", False)
		ensure then
			has_error: has_error
		end

feature {NONE} -- Constants

	Argument_list_initial_size: INTEGER is 9
	Use_list_initial_size: INTEGER is 3;
			-- Initial capacity for lists

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EXTERNAL_PARSER_SKELETON

