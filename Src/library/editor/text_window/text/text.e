note
	description: "[
		Basic, read only text. The text is made of a sequence of EDITOR_LINEs,
		which are themselves sequences of EDITOR_TOKENs.
		These lines and tokens are built from a string by an EDITOR_SCANNER.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT

inherit
	B_345_TREE
		rename
			first_data as first_line,
			last_data as last_line,
			item as line,
			count as number_of_lines,
			prepend_data as prepend_line,
			append_data as append_line
		export
			{NONE} append_line, prepend_line, set_first_data,
			set_last_data, wipe_out, make
		redefine
			make,
			first_line
		end

	TEXT_OBSERVER_MANAGER
		redefine
			make, recycle
		end

	DOCUMENT_TYPE_MANAGER

	SHARED_EDITOR_DATA

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

create
	make

feature {NONE}-- Initialization

	make
			-- create an empty text
		do
			Precursor {TEXT_OBSERVER_MANAGER}
			Precursor {B_345_TREE}
			set_tabulation_size (editor_preferences.tabulation_spaces)
			finish_reading_string_agent := agent finish_reading_string
			create current_string.make_empty
			current_pos := 1
		end

feature -- Content Change

	load_string (a_string: STRING)
			-- Scan `a_string' and fill the object with resulting
			-- lines and tokens
			-- `a_string' must be in UTF8.
		require
			string_not_void: a_string /= Void
			text_has_been_reinitialized: is_empty
		do
			current_string := a_string
			start_reading_string
		ensure
			read_enough_lines: number_of_lines >= first_read_block_size or else reading_text_finished
		end

feature  {TEXT_PANEL} -- Content Change		

	flush
			-- Load texts immediately
		do
			from until
				not text_being_processed
			loop
				finish_reading_string
			end
		ensure
			not_text_being_processed: not text_being_processed
			reading_text_finished: reading_text_finished
		end

feature -- Reinitialization

	reset_text
			-- reset the text to its original, empty state
		do
			abort_idle_processing
			wipe_out
			text_being_processed := True
			reading_text_finished := False
			create current_string.make_empty
			current_pos := 1
			if not is_notifying then
				on_text_reset
			end
		end

feature -- Access

	first_line: detachable EDITOR_LINE

	current_line: detachable like line
		-- current line

	text: STRING
			-- Image of text in `Current'.
		obsolete
			"Use `wide_text' instead, or wide characters are truncated. [2017-05-31]"
		require
			text_loaded: reading_text_finished
		do
			Result := wide_text.as_string_8
		end

	wide_text: STRING_32
			-- Image of text in `Current'.
			-- In UTF-32.
		require
			text_loaded: reading_text_finished
		local
			li: like current_line
		do
			from
				li := first_line
				check li /= Void end -- The first line is not void, otherwise a bug.
				Result := li.wide_image
			until
				li = last_line
			loop
				if attached li.eol_token as l_t then
					Result.append (l_t.wide_image)
				end
				li := li.next
				check li /= Void end -- Only the `last_line.next' can be void.
				Result.append (li.wide_image)
			end
		end

	first_read_block_size: INTEGER
			-- size in lines of the first block of text that
			-- will be read.

	tabulation_size: INTEGER
			-- Tabulation size in characters.
		do
			Result := internal_tabulation_size
		end

	text_loaded: STRING_8
			-- Text in UTF-8 loaded by `load_string'
		do
			Result := current_string
		end

feature -- Status Setting

	set_first_read_block_size (a_size: INTEGER)
			-- set the size in lines of the first block of text
			-- that will be read.
		require
			valid_size: a_size >= 0
		do
			 first_read_block_size := a_size
		end

	set_tabulation_size (a_size: INTEGER)
			-- Set thet tabulation size.  Overrides preferences default value.
		require
			a_size_big_enough: a_size > 0
		do
			internal_tabulation_size := a_size
		end

	highlight_line (a_line: INTEGER)
			-- Highlight line.  Do not move cursor to this line.
		require
			valid_i: a_line >= 1 and then a_line <= number_of_lines
		local
			l_line: like current_line
		do
			go_i_th (a_line)
			l_line := current_line
			check l_line /= Void end -- Implied by postcondition of `go_i_th'
			l_line.set_highlighted (True)
		end

	unhighlight_line (a_line: INTEGER)
			-- Highlight line.  Do not move cursor to this line.
		require
			valid_i: a_line >= 1 and then a_line <= number_of_lines
		local
			l_line: like current_line
		do
			go_i_th (a_line)
			l_line := current_line
			check l_line /= Void end -- Implied by postcondition of `go_i_th'
			l_line.set_highlighted (False)
		end

	set_is_windows_eol_style (a_windows_style: BOOLEAN)
			-- Set `is_unix_style' with `a_style'.
		do
			is_windows_eol_style := a_windows_style
		ensure
			is_windows_eol_style_set: is_windows_eol_style = a_windows_style
		end

feature -- Query

	after: BOOLEAN
			-- Is the `current_line' beyond the end of the text ?
		do
			Result := current_line = Void
		end

	text_length: INTEGER
			-- Length of displayed text
		do
			Result := wide_text.count
		end

	first_non_blank_token (a_line: like line): detachable EDITOR_TOKEN
			-- First non blank token in `a_line'.
		require
			a_line_not_void: a_line /= Void
		local
			l_found: BOOLEAN
		do
			Result := a_line.first_token
			if Result /= Void then
				from
					if not attached {EDITOR_TOKEN_BLANK} Result then
						l_found := True
					end
				until
					l_found
				loop
					check Result_attached: Result /= Void end
					Result := Result.next
					if Result = void or else not attached {EDITOR_TOKEN_BLANK} Result then
						l_found := True
					end
				end
			end
		end

	line_pos_in_chars (a_line: like line): INTEGER
			-- Position in chars of start of `a_line'.
		require
			line_not_void: a_line /= Void
		local
			l_line: like current_line
		do
			from
				start
				Result := 1
			until
				a_line = current_line or after
			loop
				l_line := current_line
				check l_line /= Void end -- Implied by not `after'
				Result := Result + l_line.wide_image.count + 1
				forth
			end
		ensure
			line_pos_in_chars_positive: Result > 0
		end

feature -- Element Change

	forth
			-- move `current_line' to the next line
		require
			not_after: not after
		local
			l_line: like current_line
		do
			l_line := current_line
			check l_line /= Void end -- Implied by not `after'
			current_line := l_line.next
		end

	start
			-- set the first line as `current_line'
		require
			number_of_lines >= 1
		do
			current_line := first_line
		end

	go_i_th (i: INTEGER)
			-- set the i-th line as `current_line'
		require
			valid_i: i >= 1 and then i <= number_of_lines
		do
			current_line := line (i)
		ensure
			not_after: not after
		end

	update_line (a_line: INTEGER)
			-- Update line tokens
		require
			line_index_valid: a_line > 0 and a_line <= number_of_lines
		local
			l_line: like line
		do
			l_line := line (a_line)
			check l_line /= Void end -- Implid by precondition
			l_line.update_token_information
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is there no text loaded in the editor ?
		do
			Result := number_of_lines = 0
		end

	reading_text_finished: BOOLEAN
			-- Is text completely read?

	text_being_processed: BOOLEAN
			-- is the text currently processed?

	is_windows_eol_style: BOOLEAN
			-- Is the text windows eol style?

feature -- Search

	search_string (searched_string: READABLE_STRING_GENERAL)
			-- Search the text for the string `searched_string'.
			-- If the search was successful, `successful_search' is
			-- set to True and `found_string_line' &
			-- `found_string_character_position' are set.
			-- `searched_string' should be in UTF-32 as STRING_32 or compatible STRING_8.
		require
			text_is_not_empty: not is_empty
		local
			line_string: STRING_32
			found_index: INTEGER
			line_number: INTEGER
			l_line: like current_line
		do
				-- Reset the success tag.
			successful_search := False

				-- Search the string...
			from
				start
				line_number := 0
			until
				found_index /= 0 or else after
			loop
				l_line := current_line
				check l_line /= Void end -- Implied by not `after'
				line_string := l_line.wide_image
				if line_string.count >= searched_string.count then
					found_index := line_string.substring_index (searched_string, 1)
				end
				line_number := line_number + 1

					-- Prepare next iteration.
				forth
			end

				-- If the search was successful, set the results attributes.
			if found_index /= 0 then
				successful_search := True
				found_string_line := line_number
				found_string_character_position := found_index
			end
		end

	found_string_line: INTEGER
			-- Line number of the last found string.
			-- Valid only if `successful_search' is set.

	found_string_character_position: INTEGER
			-- Position of the first character within the line of the last string.
			-- Valid only if `successful_search' is set.

	found_string_total_character_position: INTEGER
			-- Position of the first character within the complete text.
			-- Valid only if `successful_search' is set.

	successful_search: BOOLEAN
			-- Was the last call to `search_string' successful?

feature {TEXT_PANEL} -- Userset data

	set_userset_data (a_data: like userset_data)
			-- Set `userset_data' with `a_data'
		do
			userset_data := a_data
		ensure
			userset_data_set: userset_data = a_data
		end

	userset_data: detachable TEXT_PANEL_BUFFERED_DATA assign set_userset_data
			-- Userset editor data

feature {NONE} -- Text Loading

	start_reading_string
			-- Read the file named `a_name' and perform a lexical analysis
		local
			curr_string, l_current_string: STRING -- UTF-8
			j: INTEGER
		do


			lexer.set_tab_size (editor_preferences.tabulation_spaces)
			lexer.set_in_verbatim_string (False)

				-- read the file
			l_current_string := current_string
			from
				if l_current_string = Void or else l_current_string.is_empty then
					j := 0
					append_line (new_line_from_lexer ("", is_windows_eol_style))
				else
					current_pos := 1
					j := l_current_string.index_of ('%N', current_pos)
					if j = 0 then
						j := l_current_string.count + 1
					end
				end
			until
				number_of_lines > first_read_block_size or j = 0
			loop
				if j > 1 and then l_current_string [j - 1] = '%R' then
					curr_string := l_current_string.substring (current_pos, j - 2)
					append_line (new_line_from_lexer (curr_string, True))
				else
					curr_string := l_current_string.substring (current_pos, j - 1)
					append_line (new_line_from_lexer (curr_string, False))
				end
				current_pos := j + 1
				if current_pos > l_current_string.count then
					j := 0
				else
					j := l_current_string.index_of ('%N', current_pos)
					if j = 0 then
						j := l_current_string.count + 1
					end
				end
			end

			on_text_block_loaded (True)

			if j = 0 then
				if
					not l_current_string.is_empty and then
					(l_current_string.item (l_current_string.count) = '%N')
				then
					append_line (new_line_from_lexer ("", is_windows_eol_style))
				end
				reading_text_finished := True
				on_text_loaded
			else
					-- the file has not been entirely loaded, so we will
					-- finish loading the file on idle actions.
				reading_text_finished := False
			end
			ev_application.add_idle_action (finish_reading_string_agent)
		end

	finish_reading_string
			-- Read the file named `a_name' and perform a lexical analysis
		local
			l_current_string, curr_string: detachable STRING -- UTF-8
			j				: INTEGER
			lines_read		: INTEGER
		do
			if not reading_text_finished then
				lexer.set_tab_size (editor_preferences.tabulation_spaces)
				from
					lines_read := 1
					l_current_string := current_string
					if current_pos <= l_current_string.count then
						j := l_current_string.index_of ('%N', current_pos)
						if j = 0 then
							j := l_current_string.count + 1
						end
					else
						j := 0
					end
				until
					lines_read > Lines_read_per_idle_action or else j = 0
				loop
					if j > 1 and then l_current_string [j - 1] = '%R' then
							-- Remove the `%R' and let the lexer EOL token.
						curr_string := l_current_string.substring (current_pos, j - 2)
						append_line (new_line_from_lexer (curr_string, True))
					else
						curr_string := l_current_string.substring (current_pos, j - 1)
						append_line (new_line_from_lexer (curr_string, False))
					end
					current_pos := j + 1
					if current_pos <= l_current_string.count then
						j := l_current_string.index_of ('%N', current_pos)
						if j = 0 then
							j := l_current_string.count + 1
						end
					else
						j := 0
					end

						-- prepare next iteration
					lines_read := lines_read + 1
				end

				on_text_block_loaded (False)

				if j = 0 then
						-- We have finished reading the file, so we remove
						-- ourself from the idle actions.
					if l_current_string [l_current_string.count] = '%N' then
						append_line (new_line_from_lexer ("", is_windows_eol_style))
					end
					reading_text_finished := True
					on_text_loaded
					after_reading_idle_action
				end
			else
				after_reading_idle_action
			end
		end

	new_line_from_lexer (line_image: STRING; a_windows_style: BOOLEAN): attached like line
			-- create a new EDITOR_LINE from `line_image' using
			-- `line_image' is in UTF-8.
		require
			no_new_line_in_image: not line_image.has ('%N')
			no_new_line_in_image: not line_image.has ('%R')
			lexer_has_right_tab_size: editor_preferences.tabulation_spaces = lexer.tab_size
		do
			if line_image.is_empty then
				create Result.make (a_windows_style)
			else
				lexer.execute (line_image)
				create Result.make_from_lexer_and_style (lexer, a_windows_style)
			end
		end

	abort_idle_processing
			-- Stop text processing done during idle actions.
		do
			text_being_processed := False
			ev_application.remove_idle_action (finish_reading_string_agent)
		end

	after_reading_idle_action
			-- action performed on idle when text reading is finished.
		do
			ev_application.remove_idle_action (finish_reading_string_agent)
			text_being_processed := False
			on_text_fully_loaded
		end

	finish_reading_string_agent: PROCEDURE
			-- Agent for function `finish_reading_string'

feature {NONE} -- Implementation

	lexer: EDITOR_SCANNER
			-- Text lexer
		do
		   	Result := current_class.scanner
		end

	execute_lexer_with_wide_string (a_string: READABLE_STRING_GENERAL)
			-- Execute the lexer with wide string.
			-- Convert the string back to `lexer.current_encoding' first.
		require
			a_string_not_void: a_string /= Void
		do
			lexer.execute_with_wide_string (a_string.as_string_32)
		end

	current_string: STRING
			-- string to be loaded, in UTF8

	current_pos: INTEGER
			-- position in current_string where loading should be resumed

feature {NONE} -- Private Constants

	Lines_read_per_idle_action: INTEGER = 25
		-- Number of lines read each time finish_reading_file
		-- is called on an idle action.

	internal_tabulation_size: INTEGER
		-- Size of tabulation

feature -- Memory management

	recycle
		do
			reset_text
			finish_reading_string_agent := agent do end
		end

invariant
	current_line_valid: attached current_line as l_line implies l_line.is_valid
	positive_current_pos: current_pos > 0

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
