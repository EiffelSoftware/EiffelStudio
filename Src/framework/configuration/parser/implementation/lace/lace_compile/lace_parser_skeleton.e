note

	description: "Lace parser skeletons"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class LACE_PARSER_SKELETON

inherit

	LACE_PARSER_ROUTINES

	YY_PARSER_SKELETON
		rename
			parse as yyparse,
			make as make_parser_skeleton
		redefine
			report_error, clear_all
		end

	LACE_SCANNER
		rename
			make as make_lace_scanner
		redefine
			reset
		end

	LACE_AST_FACTORY
		export {NONE} all end

	REFACTORING_HELPER
		export
			{NONE} all
		end

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
			Precursor {LACE_SCANNER}
			ast := Void
			set_last_syntax_error (Void)
		ensure then
			ast_detached: not attached ast
			last_syntax_error_detached: not attached last_syntax_error
		end

feature {NONE} -- Parsing

	parse_lace (a_file: KL_BINARY_INPUT_FILE)
			-- Parse Lace class text from `a_file'.
			-- Make result available in `ast'.
			-- An exception is raised if a syntax error is found.
		do
			reset
			File_buffer.set_file (a_file)
			input_buffer := File_buffer
			yy_load_input_buffer
			filename := a_file.name
			yyparse
		end

feature -- Removal

	wipe_out
			-- Release unused objects to garbage collector.
		do
			ast := Void
			clear_stacks
		ensure
			ast_void: ast = Void
		end

	clear_all
			-- Clear temporary objects so that they can be collected
			-- by the garbage collector. (This routine is called by
			-- `parse' before exiting.)
		do
		end

feature {NONE} -- Keywords

	All_keyword: OPT_VAL_SD
			-- ALL keyword AST node
		once
			create Result.make_all
		ensure
			all_keyword_void: Result /= Void
		end

	Assertion_keyword: ASSERTION_SD
			-- ASSERTION keyword AST node
		once
			create Result
		ensure
			assertion_keyword_void: Result /= Void
		end

	Check_keyword: OPT_VAL_SD
			-- CHECK keyword AST node
		once
			create Result.make_check
		ensure
			check_keyword_not_void: Result /= Void
		end

	Debug_keyword: DEBUG_SD
			-- DEBUG keyword AST node
		once
				-- Create an enabled DEBUG_SD node
			create Result.initialize (True)
		ensure
			debug_keyword_void: Result /= Void
		end

	Disabled_debug_keyword: DEBUG_SD
			-- DISABLED_DEBUG keyword AST node
		once
				-- Create an enabled DEBUG_SD node
			create Result.initialize (False)
		ensure
			debug_keyword_void: Result /= Void
		end

	Ensure_keyword: OPT_VAL_SD
			-- ENSURE keyword AST node
		once
			create Result.make_ensure
		ensure
			ensure_keyword_not_void: Result /= Void
		end

	Invariant_keyword: OPT_VAL_SD
			-- INVARIANT keyword AST node
		once
			create Result.make_invariant
		ensure
			invariant_keyword_not_void: Result /= Void
		end

	Loop_keyword: OPT_VAL_SD
			-- LOOP keyword AST node
		once
			create Result.make_loop
		ensure
			loop_keyword_not_void: Result /= Void
		end

	No_keyword: OPT_VAL_SD
			-- NO keyword AST node
		once
			create Result.make_no
		ensure
			no_keyword_not_void: Result /= Void
		end

	Optimize_keyword: OPTIMIZE_SD
			-- OPTIMIZE keyword AST node
		once
			create Result
		ensure
			optimize_keyword_void: Result /= Void
		end

	Precompiled_keyword: PRECOMPILED_SD
			-- PRECOMPILED keyword AST node
		once
			create Result
		ensure
			precompiled_keyword_void: Result /= Void
		end

	Require_keyword: OPT_VAL_SD
			-- REQUIRE keyword AST node
		once
			create Result.make_require
		ensure
			require_keyword_not_void: Result /= Void
		end

	Trace_keyword: TRACE_SD
			-- TRACE keyword AST node
		once
			create Result
		ensure
			trace_keyword_void: Result /= Void
		end

	Yes_keyword: OPT_VAL_SD
			-- YES keyword AST node
		once
			create Result.make_yes
		ensure
			yes_keyword_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	File_buffer: YY_FILE_BUFFER
			-- Parser input file buffer
		once
			create Result.make_with_size ((create {KL_STANDARD_FILES}).input, 50000)
		ensure
			file_buffer_not_void: Result /= Void
		end

feature {NONE} -- Error handling

	report_error (a_message: STRING)
			-- A syntax error has been detected.
			-- Print error message.
		do
			set_last_syntax_error (a_message + " (line "+line.out+", column "+column.out+")")
		end

note
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

end -- class LACE_PARSER_SKELETON

