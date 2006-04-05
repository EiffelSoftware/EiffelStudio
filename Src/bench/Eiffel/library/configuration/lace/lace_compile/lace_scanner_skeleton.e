indexing

	description: "Lace scanner skeletons"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class LACE_SCANNER_SKELETON

inherit

	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton
		redefine
			reset, fatal_error
		end

	LACE_TOKENS
		export {NONE} all end

	BASIC_ROUTINES
		export {NONE} all end

	SHARED_ERROR_HANDLER
		export {NONE} all end

	COMPILER_EXPORTER
		export {NONE} all end

	PLATFORM
		export
			{NONE} all
		undefine
			maximum_character_code
		end

feature {NONE} -- Initialization

	make is
			-- Create a new Lace scanner.
		do
			make_with_buffer (Empty_buffer)
			create token_buffer.make (Initial_buffer_size)
			create comments.make_empty
			filename := ""
		end

feature -- Initialization

	reset is
			-- Reset scanner before scanning next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor {YY_COMPRESSED_SCANNER_SKELETON}
			token_buffer.clear_all
		end

feature -- Access

	filename: STRING
			-- Name of file being parsed

	last_value: ANY
			-- Semantic value to be passed to the parser

	token_buffer: STRING
			-- Buffer for lexial tokens

	comments: STRING
			-- All comments from file being parsed.

feature -- Error handling

	fatal_error (a_message: STRING) is
			-- A fatal error occurred.
			-- Log `a_message' and raise an exception.
		do
		end

	report_string_bad_special_character_error is
			-- Invalid special character after % in manisfest string.
		do
		end

	report_string_invalid_code_error (a_code: INTEGER) is
			-- Invalid character code after % in manisfest string.
		do
		end

	report_string_missing_quote_error (a_string: STRING) is
			-- Invalid string: final quote missing.
		require
			a_string_not_void: a_string /= Void
		do
		end

	report_string_empty_error is
			-- Invalid string: empty string.
		do
		end

	report_unknown_token_error (a_token: CHARACTER) is
			-- Unknown token.
		do
		end

feature {NONE} -- Implementation

	process_string_character_code (code: INTEGER) is
			-- Check whether `code' is a valid character code
			-- in a string and set `last_token' accordingly.
		require
			code_positive: code >= 0
		do
			if code > Maximum_character_code then
					-- Bad character code.
				set_start_condition (0)
				report_string_invalid_code_error (code)
			else
				token_buffer.append_character (charconv (code))
			end
		end

feature {NONE} -- Constants

	Initial_buffer_size: INTEGER is 5120
			-- Initial size for `token_buffer'
			-- (See `eif_rtlimits.h')

	Maximum_character_code: INTEGER is 255
			-- Largest supported code for CHARACTER values

invariant

	token_buffer_not_void: token_buffer /= Void
	filename_not_void: filename /= Void

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

end -- class LACE_SCANNER_SKELETON


