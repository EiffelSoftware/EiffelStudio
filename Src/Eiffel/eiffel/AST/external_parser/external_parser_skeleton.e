note

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
			report_error, report_eof_expected_error, clear_all
		end

	EXTERNAL_SCANNER
		rename
			make as make_lace_scanner
		redefine
			reset, report_one_error
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

	make
			-- Create a new Lace parser.
		do
			make_lace_scanner
			make_parser_skeleton
		end

feature -- Initialization

	reset
			-- Reset Parser before parsing next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor
		end

feature -- Parsing

	parse_external (a_class: like current_class; a_line, a_column: INTEGER; a_file: STRING; a_string: STRING)
			-- Parse external clause text from `a_string' located in `a_file'.
			-- Make result available in `root_node'.
			-- An exception is raised if a syntax error is found.
		do
			file_line := a_line
			file_column := a_column
			root_node := Void
			current_class := a_class
			input_buffer := create {YY_BUFFER}.make (a_string)
			yy_load_input_buffer
			filename := a_file
			yyparse
			reset
		rescue
			reset
		end

feature -- Access

	root_node: EXTERNAL_EXTENSION_AS
			-- Result of parsing

feature -- Removal

	wipe_out
			-- Release unused objects to garbage collector.
		do
			root_node := Void
			clear_stacks
		ensure
			root_node_void: root_node = Void
		end

	clear_all
			-- Clear temporary objects so that they can be collected
			-- by the garbage collector. (This routine is called by
			-- `parse' before exiting.)
		do
		end

feature {NONE} -- Error handling

	report_eof_expected_error
		do
			fatal_error ("Unrecognized external construct")
		end

	report_error (a_message: STRING)
			-- A syntax error has been detected.
		do
			fatal_error (a_message)
		end

	report_one_error (a_error: ERROR)
			-- <Precursor>
		do
			Precursor (a_error)
			root_node := Void
			abort
		end

feature {NONE} -- Constants

	Argument_list_initial_size: INTEGER = 9
	Use_list_initial_size: INTEGER = 3;
			-- Initial capacity for lists

note
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

end -- class EXTERNAL_PARSER_SKELETON

