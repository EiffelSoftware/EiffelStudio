indexing

	description: "Lace parser skeletons"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class EXTERNAL_PARSER_SKELETON

inherit

	YY_PARSER_SKELETON [ANY]
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

	EXTERNAL_FACTORY
		export {NONE} all end

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

	parse_external (a_pos: INTEGER; a_file: STRING; a_string: STRING) is
			-- Parse external clause text from `a_string' located in `a_file'.
			-- Make result available in `root_node'.
			-- An exception is raised if a syntax error is found.
		do
			position := a_pos
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

	position: INTEGER
			-- Current position of parsing in class text `filename'.

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
			create external_syntax_error.make (position + current_position.start_position,
				 position + current_position.end_position, filename, 0, "", False)
		ensure then
			has_error: has_error
		end

feature {NONE} -- Constants

	Argument_list_initial_size: INTEGER is 9
	Use_list_initial_size: INTEGER is 3
			-- Initial capacity for lists

end -- class EXTERNAL_PARSER_SKELETON

--|----------------------------------------------------------------
--| Copyright (C) 1992-2000, Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited
--| without prior agreement with Interactive Software Engineering.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://eiffel.com
--|----------------------------------------------------------------
