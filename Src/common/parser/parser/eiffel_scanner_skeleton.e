indexing

	description: "Eiffel scanner skeletons"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class EIFFEL_SCANNER_SKELETON

inherit

	YY_COMPRESSED_SCANNER_SKELETON
		rename
			make as make_compressed_scanner_skeleton
		redefine
			reset
		end

	EIFFEL_TOKENS
		export {NONE} all end

	BASIC_ROUTINES
		export {NONE} all end

	SHARED_ERROR_HANDLER
		export {NONE} all end

	COMPILER_EXPORTER
		export {NONE} all end

feature {NONE} -- Initialization

	make is
			-- Create a new Eiffel scanner.
		do
			make_with_buffer (Empty_buffer)
			!! token_buffer.make (Initial_buffer_size)
			!! current_position.reset
			line_number := 1
			filename := ""
		end

feature -- Initialization

	reset is
			-- Reset scanner before scanning next input source.
			-- (This routine can be called in wrap before scanning
			-- another input buffer.)
		do
			Precursor
			token_buffer.clear_all
			current_position.reset
			line_number := 1
			inherit_context := False
		end

feature -- Access

	filename: STRING
			-- Name of file being parsed

	line_number: INTEGER
			-- Current line number

	current_position: TOKEN_LOCATION
			-- Position of last token read

	last_value: ANY
			-- Semantic value to be passed to the parser

	token_buffer: STRING
			-- Buffer for lexial tokens

	inherit_context: BOOLEAN
			-- Was the last token an `end' keyword recognized
			-- by an `inherit' clause with an empty parent
			-- adaptation subclause?
			--
			-- class FOO
			-- inherit
			--		BAR
			--		end

	nb_tilde: INTEGER
			-- Number of '~' in the last TE_TILDE token

	yacc_error_code: INTEGER

feature -- Error handling

	report_error (a_message: STRING) is
			-- A syntax error has been detected.
			-- Print error message.
		require
			a_message_not_void: a_message /= Void
		local
			an_error: SYNTAX_ERROR
		do
-- TO DO
			inspect last_token
--			when EIF_ERROR2 then
					-- String too long: call feature `make_string_too_long' of
--		 * class ERROR_HANDLER.
--		 */
--		(*syntax2)(Error_handler);
--		break;
--	case EIF_ERROR3:
--		/* Bad string extension: call feature `make_string_extension'
--		 * of class ERROR_HANDLER.
--		 */
--		(*syntax3)(Error_handler);
--		break;
--	case EIF_ERROR4:
--		/* Bad string: call feature `make_string_uncompleted'
--		 * of class ERROR_HANDLER.
--		 */
--		(*syntax4)(Error_handler);
--		break;
--	case EIF_ERROR5:
--		/* Bad character */
--		(*syntax5)(Error_handler);
--		break;
--	case EIF_ERROR6:
--		/* Empty manifest string */
--		(*syntax6)(Error_handler);
--		break;
--	case EIF_ERROR7:
--		/* Identifier too long: call feature `make_id_too_long' of
--		 * class ERROR_HANDLER.
--		 */
--		(*syntax7)(Error_handler);

			else
					-- Common syntax error.
				!SYNTAX_ERROR! an_error.make (current_position.start_position, current_position.end_position, filename, yacc_error_code, "")
			end
--			if not equal (a_message, "parse error") then
			Error_handler.insert_error (an_error)
			Error_handler.raise_error
--			end
		end

feature {NONE} -- Implementation

	process_character_code (code: INTEGER) is
			-- Check whether `code' is a valid character code
			-- and set `last_token' accordingly.
		require
			code_positive: code >= 0
		do
			if code > Maximum_character_code then
					-- Bad character code.
				last_token := EIF_ERROR5
			else
				token_buffer.clear_all
				token_buffer.append_character (charconv (code))
				last_token := TE_CHAR
			end
		end

	process_string_character_code (code: INTEGER) is
			-- Check whether `code' is a valid character code
			-- in a string and set `last_token' accordingly.
		require
			code_positive: code >= 0
		do
			if code > Maximum_character_code then
					-- Bad character code.
				set_start_condition (0)
				last_token := EIF_ERROR3
			else
				token_buffer.append_character (charconv (code))
			end
		end

	append_without_underscores (from_string, to_string: STRING) is
			-- Append all characters of `from_string' but underscores
			-- to `to_string'.
		require
			from_string_not_void: from_string /= Void
			to_string_not_void: to_string /= Void
		local
			i, nb: INTEGER
			char: CHARACTER
		do
			nb := from_string.count
			from i := 1 until i > nb loop
				char := from_string.item (i)
				if char /= '_' then
					to_string.append_character (char)
				end
				i := i + 1
			end
		end

	cloned_string (a_string: STRING): STRING is
			-- Clone of `a_string'
			-- (Reduce memory storage if possible.)
		require
			a_string_not_void: a_string /= Void
		do
			!! Result.make (a_string.count)
			Result.append_string (a_string)
		ensure
			cloned_string_not_void: Result /= Void
			new_object: Result /= a_string
			equal: Result.is_equal (a_string)
			less_memory: Result.capacity <= a_string.capacity
		end

feature {NONE} -- Constants

	Initial_buffer_size: INTEGER is 5120
			-- Initial size for `token_buffer'
			-- (See `eif_rtlimits.h')

	Maximum_character_code: INTEGER is 255
			-- Largest supported code for CHARACTER values

invariant

	token_buffer_not_void: token_buffer /= Void
	current_position_not_void: current_position /= Void
	filename_not_void: filename /= Void

end -- class EIFFEL_SCANNER_SKELETON


--|----------------------------------------------------------------
--| Copyright (C) 1992-1999, Interactive Software Engineering Inc.
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
