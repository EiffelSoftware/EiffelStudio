indexing
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

	make is
			-- create an empty text
		do
			Precursor {TEXT_OBSERVER_MANAGER}
			Precursor {B_345_TREE}
			set_tabulation_size (editor_preferences.tabulation_spaces)
			finish_reading_string_agent := agent finish_reading_string
		end

feature -- Content Change

	load_string (a_string: STRING) is
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

feature -- Reinitialization

	reset_text is
			-- reset the text to its original, empty state
		do
			abort_idle_processing
			wipe_out
			text_being_processed := True
			reading_text_finished := False
			current_string := Void
			current_pos := 0
			on_text_reset
		end

feature -- Access

	first_line: EDITOR_LINE

	current_line: like line
		-- current line

	text: STRING is
			-- Image of text in `Current'.
		obsolete
			"Use `wide_text' instead, or wide characters are truncated."
		require
			text_loaded: reading_text_finished
		do
			Result := wide_text.as_string_8
		end

	wide_text: STRING_32 is
			-- Image of text in `Current'.
			-- In UTF-32.
		require
			text_loaded: reading_text_finished
		local
			li: like current_line
			l_string_32: STRING_32
		do
			from
				l_string_32 := first_line.wide_image
				li := first_line
			until
				li = last_line
			loop
				l_string_32.extend ('%N')
				li := li.next
				l_string_32.append (li.wide_image)
			end
			Result := l_string_32
		end

	first_read_block_size: INTEGER
			-- size in lines of the first block of text that
			-- will be read.

	tabulation_size: INTEGER is
			-- Tabulation size in characters.
		do
			Result := internal_tabulation_size
		end

feature -- Status Setting

	set_first_read_block_size (a_size: INTEGER) is
			-- set the size in lines of the first block of text
			-- that will be read.
		require
			valid_size: a_size >= 0
		do
			 first_read_block_size := a_size
		end

	set_tabulation_size (a_size: INTEGER) is
			-- Set thet tabulation size.  Overrides preferences default value.
		require
			a_size_big_enough: a_size > 0
		do
			internal_tabulation_size := a_size
		end

	highlight_line (a_line: INTEGER) is
			-- Highlight line.  Do not move cursor to this line.
		require
		do
			go_i_th (a_line)
			current_line.set_highlighted (True)
		end

	unhighlight_line (a_line: INTEGER) is
			-- Highlight line.  Do not move cursor to this line.
		require
		do
			go_i_th (a_line)
			current_line.set_highlighted (False)
		end

feature -- Query

	after: BOOLEAN is
			-- Is the `current_line' beyond the end of the text ?
		do
			Result := (current_line = Void)
		end

	text_length: INTEGER is
			-- Length of displayed text
		do
			Result := wide_text.count
		end

	first_non_blank_token (a_line: like line): EDITOR_TOKEN is
			-- First non blank token in `a_line'.
		local
			blnk: EDITOR_TOKEN_BLANK
		do
			from
				Result := a_line.first_token
				blnk ?= Result
			until
				blnk = Void
			loop
				Result := Result.next
				blnk ?= Result
			end
		end

	line_pos_in_chars (a_line: like line): INTEGER is
			-- Position in chars of start of `a_line'.
		require
			line_not_void: a_line /= Void
		do
			from
				start
				Result := 1
			until
				a_line = current_line or after
			loop
				Result := Result + current_line.wide_image.count + 1
				forth
			end
		ensure
			line_pos_in_chars_positive: Result > 0
		end

feature -- Element Change

	forth is
			-- move `current_line' to the next line
		require
			not after
		do
			current_line := current_line.next
		end

	start is
			-- set the first line as `current_line'
		require
			number_of_lines >= 1
		do
			current_line := first_line
		end

	go_i_th (i: INTEGER) is
			-- set the i-th line as `current_line'
		require
			valid_i: i >= 1 and then i <= number_of_lines
		do
			current_line := line (i)
		end

	update_line (a_line: INTEGER) is
			-- Update line tokens
		require
			line_index_valid: a_line > 0 and a_line <= number_of_lines
		do
			line (a_line).update_token_information
		end

feature -- Status report

	is_empty: BOOLEAN is
			-- Is there no text loaded in the editor ?
		do
			Result := number_of_lines = 0
		end

	reading_text_finished: BOOLEAN
			-- Is text completely read?

	text_being_processed: BOOLEAN
			-- is the text currently processed?

feature -- Search

	search_string (searched_string: STRING_GENERAL) is
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
				line_string := current_line.wide_image
				if line_string.count >= searched_string.count then
					found_index := line_string.substring_index(searched_string, 1)
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

feature {NONE} -- Text Loading

	start_reading_string is
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
					append_line (new_line_from_lexer (""))
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
				curr_string := l_current_string.substring (current_pos, j - 1)
				append_line (new_line_from_lexer (curr_string))
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

			if j /= 0 then
					-- the file has not been entirely loaded, so we will
					-- finish loading the file on idle actions.
				reading_text_finished := False
			else
				if
					not l_current_string.is_empty and then
					(l_current_string.item (l_current_string.count) = '%N')
				then
					append_line (new_line_from_lexer (""))
				end
				reading_text_finished := True
				on_text_loaded
			end
			ev_application.add_idle_action (finish_reading_string_agent)
		end

	finish_reading_string is
			-- Read the file named `a_name' and perform a lexical analysis
		local
			l_current_string, curr_string: STRING -- UTF-8
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
					curr_string := l_current_string.substring (current_pos, j-1)
					append_line (new_line_from_lexer (curr_string))
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
					if (l_current_string @ l_current_string.count) = '%N' then
						append_line (new_line_from_lexer (""))
					end
					reading_text_finished := True
					on_text_loaded
					after_reading_idle_action
				end
			else
				after_reading_idle_action
			end
		end

	new_line_from_lexer (line_image: STRING): like line is
			-- create a new EDITOR_LINE from `line_image' using
			-- `line_image' is in UTF-8.
		require
			no_new_line_in_image: not line_image.has ('%N')
			lexer_has_right_tab_size: editor_preferences.tabulation_spaces = lexer.tab_size
		do
			if line_image.is_empty then
				create Result.make_empty_line
			else
				lexer.execute (line_image)
				create Result.make_from_lexer (lexer)
			end
		end

	abort_idle_processing is
			-- Stop text processing done during idle actions.
		do
			text_being_processed := False
			ev_application.remove_idle_action (finish_reading_string_agent)
		end

	after_reading_idle_action is
			-- action performed on idle when text reading is finished.
		do
			ev_application.remove_idle_action (finish_reading_string_agent)
			text_being_processed := False
			on_text_fully_loaded
		end

	finish_reading_string_agent: PROCEDURE [like Current, TUPLE]
			-- Agent for function `finish_reading_string'

feature {NONE} -- Implementation

	lexer: EDITOR_SCANNER is
			-- Text lexer
		do
		   	Result := current_class.scanner
		end

	execute_lexer_with_wide_string (a_string: STRING_GENERAL) is
			-- Excute the lexer with wide string.
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

	Lines_read_per_idle_action: INTEGER is 25
		-- Number of lines read each time finish_reading_file
		-- is called on an idle action.

	internal_tabulation_size: INTEGER
		-- Size of tabulation

feature -- Memory management

	recycle is
		do
			reset_text
			finish_reading_string_agent := Void
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




end -- class TEXT
