indexing

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

	SHARED_PARSER_FILE_BUFFER
		export {NONE} all end

	LACE_AST_FACTORY
		export {NONE} all end

	REFACTORING_HELPER
		export
			{NONE} all
		end

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
			Precursor {LACE_SCANNER}
		end

feature {NONE} -- Parsing

	parse_lace (a_file: KL_BINARY_INPUT_FILE) is
			-- Parse Lace class text from `a_file'.
			-- Make result available in `ast'.
			-- An exception is raised if a syntax error is found.
		do
			ast := Void
			File_buffer.set_file (a_file)
			input_buffer := File_buffer
			yy_load_input_buffer
			filename := a_file.name
			yyparse
			reset
		rescue
			reset
		end

feature -- Removal

	wipe_out is
			-- Release unused objects to garbage collector.
		do
			ast := Void
			clear_stacks
		ensure
			ast_void: ast = Void
		end

	clear_all is
			-- Clear temporary objects so that they can be collected
			-- by the garbage collector. (This routine is called by
			-- `parse' before exiting.)
		do
		end

feature {NONE} -- Keywords

	All_keyword: OPT_VAL_SD is
			-- ALL keyword AST node
		once
			create Result.make_all
		ensure
			all_keyword_void: Result /= Void
		end

	Assertion_keyword: ASSERTION_SD is
			-- ASSERTION keyword AST node
		once
			create Result
		ensure
			assertion_keyword_void: Result /= Void
		end

	Check_keyword: OPT_VAL_SD is
			-- CHECK keyword AST node
		once
			create Result.make_check
		ensure
			check_keyword_not_void: Result /= Void
		end

	Debug_keyword: DEBUG_SD is
			-- DEBUG keyword AST node
		once
				-- Create an enabled DEBUG_SD node
			create Result.initialize (True)
		ensure
			debug_keyword_void: Result /= Void
		end

	Disabled_debug_keyword: DEBUG_SD is
			-- DISABLED_DEBUG keyword AST node
		once
				-- Create an enabled DEBUG_SD node
			create Result.initialize (False)
		ensure
			debug_keyword_void: Result /= Void
		end

	Ensure_keyword: OPT_VAL_SD is
			-- ENSURE keyword AST node
		once
			create Result.make_ensure
		ensure
			ensure_keyword_not_void: Result /= Void
		end

	Invariant_keyword: OPT_VAL_SD is
			-- INVARIANT keyword AST node
		once
			create Result.make_invariant
		ensure
			invariant_keyword_not_void: Result /= Void
		end

	Loop_keyword: OPT_VAL_SD is
			-- LOOP keyword AST node
		once
			create Result.make_loop
		ensure
			loop_keyword_not_void: Result /= Void
		end

	No_keyword: OPT_VAL_SD is
			-- NO keyword AST node
		once
			create Result.make_no
		ensure
			no_keyword_not_void: Result /= Void
		end

	Optimize_keyword: OPTIMIZE_SD is
			-- OPTIMIZE keyword AST node
		once
			create Result
		ensure
			optimize_keyword_void: Result /= Void
		end

	Precompiled_keyword: PRECOMPILED_SD is
			-- PRECOMPILED keyword AST node
		once
			create Result
		ensure
			precompiled_keyword_void: Result /= Void
		end

	Require_keyword: OPT_VAL_SD is
			-- REQUIRE keyword AST node
		once
			create Result.make_require
		ensure
			require_keyword_not_void: Result /= Void
		end

	Trace_keyword: TRACE_SD is
			-- TRACE keyword AST node
		once
			create Result
		ensure
			trace_keyword_void: Result /= Void
		end

	Yes_keyword: OPT_VAL_SD is
			-- YES keyword AST node
		once
			create Result.make_yes
		ensure
			yes_keyword_not_void: Result /= Void
		end


feature {NONE} -- Error handling

	report_error (a_message: STRING) is
			-- A syntax error has been detected.
			-- Print error message.
		local
			an_error: SYNTAX_ERROR
		do
			create an_error.make (line, column, filename, "", is_in_use_file)
			Error_handler.insert_error (an_error)
			Error_handler.raise_error
		end

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

end -- class LACE_PARSER_SKELETON


