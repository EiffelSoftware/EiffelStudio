indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	RICH_WINDOW

inherit
	EV_TEXT_EDITOR
		redefine
			make,
			update_highlighting
		end

	EIFFEL_SCANNER
		rename
			make as make_scanner,
			text as scanner_text,
			execute as scanner_execute
		redefine
			on_token_found
		end

	EIFFEL_TOKENS
	
	EV_BASIC_COLORS
creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		do
			make_scanner
			{EV_TEXT_EDITOR} Precursor (par)

			set_minimum_size (300, 200)
		end

feature -- Access

feature -- Basic operation

feature -- Command execution


feature {NONE}

	update_highlighting (first_pos, last_pos: INTEGER) is
			-- This function updates all startin from 
			-- `first_pos' to `last_pos' according to 
			-- it's syntax.
		local
			old_has_selection: BOOLEAN
			old_cursor_position: INTEGER
			old_selection_start: INTEGER
			old_selection_end: INTEGER
		do
			if
				syntax_highlighting_enabled
			then		
				if
					has_selection
				then
					old_has_selection := True
					old_selection_start := selection_start
					old_selection_end := selection_end
				end
	
				old_cursor_position := position
				highlight_position_offset := first_pos - 1
			

				freeze
				scan_string (text.substring (first_pos, last_pos))
				

				if
					old_has_selection
				then
					set_position (old_cursor_position)
					select_region (old_selection_start, old_selection_end)
				else
					deselect_all
					set_position (old_cursor_position)
				end

				thaw
			end
		end

	
	
		
	highlight_position_offset: INTEGER

	on_token_found is
			-- called by Eiffel analyzer whenever a 
			-- token has been recognized.
		local
			cf: EV_CHARACTER_FORMAT
			first_pos, last_pos: INTEGER
			int_buffer: INTEGER
		do
			check
				consistent_positions: token_first_pos <= token_last_pos
			end

			inspect
				last_token
			when
				E_CHARACTER
			then
				cf := string_char_format
			when
				E_INTEGER
			then
				cf := number_char_format
			when
				E_REAL
			then
				cf := number_char_format
			when
				E_IDENTIFIER
			then
					-- If identifier is in upper case
					-- treat it like a class name
				if
					is_upper_case_only (scanner_text)
				then
					cf := class_identifier_char_format
				else
					cf := general_identifier_char_format
				end
			when
				E_STRING
			then
				cf := string_char_format
			when
				E_BIT 
			then
				cf := string_char_format
			when
				E_BITTYPE
			then
				cf := string_char_format
			when
				E_CHARERR
			then
				cf := string_char_format
			when
				E_INTERR
			then
				cf := string_char_format
			when
				E_REALERR
			then
				cf := string_char_format
			when
				E_STRERR
			then
				cf := string_char_format
			when
				E_UNKNOWN
			then
				cf := default_char_format
			when
				E_NOMEMORY
			then
				cf := keyword_char_format
				check
					False
				end
			when
				E_BANGBANG
			then
				cf := symbol_char_format
			when
				E_ARROW
			then
				cf := symbol_char_format
			when
				E_DOTDOT
			then
				cf := symbol_char_format
			when
				E_LARRAY
			then
				cf := symbol_char_format
			when
				E_RARRAY
			then
				cf := symbol_char_format
			when
				E_ASSIGN
			then
				cf := symbol_char_format
			when
				E_REVERSE
			then
				cf := symbol_char_format
			when
				E_ALIAS
			then
				cf := keyword_char_format
			when
				E_ALL
			then
				cf := keyword_char_format
			when
				E_AS
			then
				cf := keyword_char_format
			when
				E_CHECK
			then
				cf := keyword_char_format
			when
				E_CLASS
			then
				cf := keyword_char_format
			when
				E_CREATION
			then
				cf := keyword_char_format
			when
				E_DEBUG
			then
				cf := keyword_char_format
			when
				E_DEFERRED
			then
				cf := keyword_char_format
			when
				E_DO
			then
				cf := keyword_char_format
			when
				E_ELSE
			then
				cf := keyword_char_format
			when
				E_ELSEIF
			then
				cf := keyword_char_format
			when
				E_END
			then
				cf := keyword_char_format
			when
				E_ENSURE
			then
				cf := keyword_char_format
			when
				E_EXPANDED
			then
				cf := keyword_char_format
			when
				E_EXPORT
			then
				cf := keyword_char_format
			when
				E_EXTERNAL
			then
				cf := keyword_char_format
			when
				E_FALSE
			then
				cf := keyword_char_format
			when
				E_FEATURE
			then
				cf := keyword_char_format
			when
				E_FROM
			then
				cf := keyword_char_format
			when
				E_FROZEN
			then
				cf := keyword_char_format
			when
				E_IF
			then
				cf := keyword_char_format
			when
				E_INDEXING
			then
				cf := keyword_char_format
			when
				E_INFIX
			then
				cf := keyword_char_format
			when
				E_INHERIT
			then
				cf := keyword_char_format
			when
				E_INSPECT
			then
				cf := keyword_char_format
			when
				E_INVARIANT
			then
				cf := keyword_char_format
			when
				E_IS
			then
				cf := keyword_char_format
			when
				E_LIKE
			then
				cf := keyword_char_format
			when
				E_LOCAL
			then
				cf := keyword_char_format
			when
				E_LOOP
			then
				cf := keyword_char_format
			when
				E_OBSOLETE
			then
				cf := keyword_char_format
			when
				E_ONCE
			then
				cf := keyword_char_format
			when
				E_PREFIX
			then
				cf := keyword_char_format
			when
				E_REDEFINE
			then
				cf := keyword_char_format
			when
				E_RENAME
			then
				cf := keyword_char_format
			when
				E_REQUIRE
			then
				cf := keyword_char_format
			when
				E_RESCUE
			then
				cf := keyword_char_format
			when
				E_RETRY
			then
				cf := keyword_char_format
			when
				E_SELECT
			then
				cf := keyword_char_format
			when
				E_SEPARATE
			then
				cf := keyword_char_format
			when
				E_STRIP
			then
				cf := keyword_char_format
			when
				E_THEN
			then
				cf := keyword_char_format
			when
				E_TRUE
			then
				cf := keyword_char_format
			when
				E_UNDEFINE
			then
				cf := keyword_char_format
			when
				E_UNIQUE
			then
				cf := keyword_char_format
			when
				E_UNTIL
			then
				cf := keyword_char_format
			when
				E_VARIANT
			then
				cf := keyword_char_format
			when
				E_WHEN
			then
				cf := keyword_char_format
			when
				E_CURRENT
			then
				cf := keyword_char_format
			when
				E_RESULT
			then
				cf := keyword_char_format
			when
				E_STRPLUS
			then
				cf := keyword_char_format
			when
				E_STRMINUS
			then
				cf := keyword_char_format
			when
				E_STRSTAR
			then
				cf := keyword_char_format
			when
				E_STRSLASH
			then
				cf := keyword_char_format
			when
				E_STRDIV
			then
				cf := keyword_char_format
			when
				E_STRMOD
			then
				cf := keyword_char_format
			when
				E_STRPOWER
			then
				cf := keyword_char_format
			when
				E_STRLT
			then
				cf := keyword_char_format
			when
				E_STRLE
			then
				cf := keyword_char_format
			when
				E_STRGT
			then
				cf := keyword_char_format
			when
				E_STRGE
			then
				cf := keyword_char_format
			when
				E_STRAND
			then
				cf := keyword_char_format
			when
				E_STROR
			then
				cf := keyword_char_format
			when
				E_STRXOR
			then
				cf := keyword_char_format
			when
				E_STRANDTHEN
			then
				cf := keyword_char_format
			when
				E_STRORELSE
			then
				cf := keyword_char_format
			when
				E_STRIMPLIES
			then
				cf := keyword_char_format
			when
				E_STRFREEOP
			then
				cf := keyword_char_format
			when
				E_STRNOT
			then
				cf := keyword_char_format
			when
				E_IMPLIES
			then
				cf := keyword_char_format
			when
				E_OR
			then
				cf := keyword_char_format
			when
				E_XOR
			then
				cf := keyword_char_format
			when
				E_AND
			then
				cf := keyword_char_format
			when
				E_NE
			then
				cf := keyword_char_format
			when
				E_LE
			then
				cf := keyword_char_format
			when
				E_GE
			then
				cf := keyword_char_format
			when
				E_DIV
			then
				cf := symbol_char_format
			when
				E_MOD
			then
				cf := symbol_char_format
			when
				E_FREEOP
			then
				cf := symbol_char_format
			when
				E_NOT
			then
				cf := symbol_char_format
			when
				E_OLD
			then
				cf := keyword_char_format
			when
				E_PRECURSOR
			then
				cf := keyword_char_format
			when
				E_COMMENT
			then
				cf := comment_char_format
			when
				Minus_code
			then
				cf := symbol_char_format
			when
				Plus_code
			then
				cf := symbol_char_format
			when
				Star_code
			then
				cf := symbol_char_format
			when
				Slash_code
			then
				cf := symbol_char_format
			when
				Caret_code
			then
				cf := symbol_char_format
			when
				Equal_code
			then
				cf := symbol_char_format
			when
				Greater_than_code
			then
				cf := symbol_char_format
			when
				Less_than_code
			then
				cf := symbol_char_format
			when
				Dot_code
			then
				cf := symbol_char_format
			when
				Semicolon_code
			then
				cf := symbol_char_format
			when
				Comma_code
			then
				cf := symbol_char_format
			when
				Colon_code
			then
				cf := symbol_char_format
			when
				Exclamation_code
			then
				cf := symbol_char_format
			when
				Left_parenthesis_code
			then
				cf := symbol_char_format
			when
				Right_parenthesis_code
			then
				cf := symbol_char_format
			when
				Left_brace_code
			then
				cf := symbol_char_format
			when
				Right_brace_code
			then
				cf := symbol_char_format
			when
				Left_bracket_code
			then
				cf := symbol_char_format
			when
				Right_bracket_code
			then
				cf := symbol_char_format
			when
				Dollar_code
			then
				cf := symbol_char_format
			else
				cf := default_char_format
			end

			check
				cf_not_void: cf /= Void
			end
			first_pos := highlight_position_offset + token_first_pos
			last_pos := highlight_position_offset + token_last_pos

				-- Unfortunatly gives us the analyzer somtimes positions
				-- that are not valid. We simply ignore those cases.
--			if
--				valid_character_position (first_pos) and
--				valid_character_position (last_pos)
--			then

--				if
--					first_pos > last_pos
--				then
--					debug
--						print ("Warning: Analyzer gives reversed token positions:")
--						print (first_pos)
--						print (",")
--						print (last_pos)
--						print (",")
--						print (text_length)
--						print (") %N")
--					end
--					int_buffer := first_pos
--					first_pos := last_pos
--					last_pos := int_buffer
--				end

			
			debug
				print ("[raising hl: ")
				print (last_token.out)
				print (" [")
				print (text.substring (first_pos, last_pos))
				print ("] (")
				print (first_pos)
				print (",")
				print (last_pos)
				print (",")
				print (text_length)
				print (")")
				print ("]%N")
			end
				int_buffer := text_length
			
				execute_highlight (first_pos, last_pos, cf)
--			else
				debug
					print ("Warning: Analyzer gives invalid token positions:")
					print (first_pos)
					print (",")
					print (last_pos)
					print (",")
					print (text_length)
					print (") %N")
				end
--			end
		end		



	default_font: EV_FONT is
		do
			--create Result.make_by_name ("Courier New")
			create Result.make
			Result.set_height (10)
		end


	keyword_char_format: EV_CHARACTER_FORMAT is
		do
			create Result.make
			Result.set_color (blue)
			Result.set_font (default_font)
			Result.set_bold (True)
		end	

	string_char_format: EV_CHARACTER_FORMAT is
		do
			create Result.make
			Result.set_color (red)
			Result.set_font (default_font)
			Result.set_bold (False)
		end	

	comment_char_format: EV_CHARACTER_FORMAT is
		do
			create Result.make
			Result.set_color (dark_green)
			Result.set_font (default_font)
			Result.set_bold (False)
		end	

	general_identifier_char_format: EV_CHARACTER_FORMAT is
		do
			create Result.make
			Result.set_color (dark_blue)
--			Result.set_italic (True)
			Result.set_font (default_font)
			Result.set_bold (False)
		end	

	class_identifier_char_format: EV_CHARACTER_FORMAT is
		do
			create Result.make
			Result.set_color (red)
--			Result.set_italic (True)
			Result.set_font (default_font)
			Result.set_bold (True)
		end	

	number_char_format: EV_CHARACTER_FORMAT is
		do
			create Result.make
			Result.set_color (red)
			Result.set_font (default_font)
			Result.set_bold (False)
		end	

	symbol_char_format: EV_CHARACTER_FORMAT is
		do
			create Result.make
			Result.set_color (dark_red)
			Result.set_font (default_font)
			Result.set_bold (False)
		end	

	default_char_format: EV_CHARACTER_FORMAT is
		do
			create Result.make
			Result.set_color (black)
			Result.set_font (default_font)
			Result.set_bold (False)
		end	

	dcf: EV_CHARACTER_FORMAT is
		-- test only
		do
			create Result.make
			Result.set_color (black)
			Result.set_font (default_font)
			Result.set_bold (False)
		end	


	is_upper_case_only (s: STRING): BOOLEAN is
			-- Does `s' consist of upper case characters
			-- only?
		local
			i: INTEGER
		do
			from
				Result := True
				i := 1
			until
				i > s.count
			loop
				if
					s.item (i).is_lower
				then
					Result := False
				end
				i := i + 1
			end
		end

end -- class BUTTON_WINDOW

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

