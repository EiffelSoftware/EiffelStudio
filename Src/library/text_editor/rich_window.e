indexing
	description:
		"The demo that goes with the button demo"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
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

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		do
			make_scanner
			Precursor {EV_TEXT_EDITOR} (par)

			set_minimum_size (400, 500)
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
			rich_edit: WEL_RICH_EDIT
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
			
				rich_edit ?= implementation
				rich_edit.hide_selection
--				freeze
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
				rich_edit.show_selection

--				thaw
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
			when E_COMMENT then
				cf := comment_char_format
			when
				E_CHARACTER, E_STRING, E_BIT, E_BITTYPE,
				E_CHARERR, E_INTERR, E_REALERR, E_STRERR
			then
				cf := string_char_format
			when E_INTEGER, E_REAL then
				cf := number_char_format
			when E_IDENTIFIER then
					-- If identifier is in upper case
					-- treat it like a class name
				if is_class_identifier (scanner_text) then
					cf := class_identifier_char_format
				else
					cf := general_identifier_char_format
				end
			when
				E_BANGBANG, E_ARROW, E_DOTDOT, E_LARRAY,
				E_RARRAY, E_ASSIGN, E_REVERSE, E_DIV, E_MOD, E_FREEOP,
				E_NOT, Minus_code, Plus_code, Star_code, Slash_code,
				Caret_code, Equal_code, Greater_than_code, Less_than_code,
				Dot_code, Semicolon_code, Comma_code, Colon_code, Exclamation_code,
				Left_parenthesis_code, Right_parenthesis_code, Left_brace_code,
				Right_brace_code, Left_bracket_code, Right_bracket_code, Dollar_code
			then
				cf := symbol_char_format
			when E_UNKNOWN then
				cf := default_char_format
			when E_NOMEMORY then
				cf := keyword_char_format
				check
					False
				end
			when
				E_ALIAS, E_ALL, E_AS, E_CHECK, E_CLASS, E_CREATION, E_DEBUG,
				E_DEFERRED, E_DO, E_ELSE, E_ELSEIF, E_END, E_ENSURE, E_EXPANDED,
				E_EXPORT, E_EXTERNAL, E_FALSE, E_FEATURE, E_FROM, E_FROZEN,
				E_IF, E_INDEXING, E_INFIX, E_INHERIT, E_INSPECT, E_INVARIANT,
				E_IS, E_LIKE, E_LOCAL, E_LOOP, E_OBSOLETE, E_ONCE, E_PREFIX,
				E_REDEFINE, E_RENAME, E_REQUIRE, E_RESCUE, E_RETRY, E_SELECT, E_SEPARATE,
				E_STRIP, E_THEN, E_TRUE, E_UNDEFINE, E_UNIQUE, E_UNTIL, E_VARIANT,
				E_WHEN, E_CURRENT, E_RESULT, E_STRPLUS, E_STRMINUS, E_STRSTAR, E_STRSLASH,
				E_STRDIV, E_STRMOD, E_STRPOWER, E_STRLT, E_STRLE, E_STRGT, E_STRGE,
				E_STRAND, E_STROR, E_STRXOR, E_STRANDTHEN, E_STRORELSE, E_STRIMPLIES,
				E_STRFREEOP, E_STRNOT, E_IMPLIES, E_OR, E_XOR, E_AND, E_NE,
				E_LE, E_GE, E_OLD, E_PRECURSOR
			then
				cf := keyword_char_format
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
			
--				execute_highlight (first_pos, last_pos, cf)
				format_region (first_pos, last_pos, cf)				
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

feature {NONE} -- Implementation

	is_class_identifier (s: STRING): BOOLEAN is
			-- Does `s' consist of upper case characters
			-- only?
		local
			i, nb: INTEGER
			area: SPECIAL [CHARACTER]
			c: CHARACTER
		do
			from
				area := s.area
				nb := s.count - 1
				Result := True
				i := 0
			until
				i > nb or not Result
			loop
				c := area.item (i)
				if c /= '_' then
					Result := c.is_upper
				end
				i := i + 1
			end
		end

feature {NONE} -- Implementation

	courrier_font: EV_FONT is
		once
			create Result.make_by_name ("Courier New")
			Result.set_height (8)
		end

	times_font: EV_FONT is
		once
			create Result.make_by_name ("Times New Roman")
			Result.set_height (9)
		end

	keyword_char_format: EV_CHARACTER_FORMAT is
		once
			create Result.make
			Result.set_color (blue)
			Result.set_font (times_font)
			Result.set_bold (True)
		end	

	string_char_format: EV_CHARACTER_FORMAT is
		once
			create Result.make
			Result.set_color (red)
			Result.set_font (times_font)
		end	

	comment_char_format: EV_CHARACTER_FORMAT is
		once
			create Result.make
			Result.set_color (red)
			Result.set_font (courrier_font)
		end	

	general_identifier_char_format: EV_CHARACTER_FORMAT is
		once
			create Result.make
			Result.set_color (dark_green)
			Result.set_font (courrier_font)
			Result.set_italic (True)
		end	

	class_identifier_char_format: EV_CHARACTER_FORMAT is
		once
			create Result.make
			Result.set_color (magenta)
			Result.set_font (times_font)
			Result.set_italic (True)
		end	

	number_char_format: EV_CHARACTER_FORMAT is
		once
			create Result.make
			Result.set_color (red)
			Result.set_font (times_font)
		end	

	symbol_char_format: EV_CHARACTER_FORMAT is
		once
			create Result.make
			Result.set_color (dark_red)
			Result.set_font (times_font)
		end	

	default_char_format: EV_CHARACTER_FORMAT is
		once
			create Result.make
			Result.set_color (black)
			Result.set_font (courrier_font)
		end	

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class BUTTON_WINDOW

