indexing
	description: "[
		Basic, read only text. The text is made of a sequence of EDITOR_LINEs, which are themselves
		sequences of EDITOR_TOKENs.
		These lines and tokEns are built from a string by an EDITOR_SCANNER.
	]"
	author: "Etienne Amodeo/Arnaud Pichery"
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT

inherit
	B_345_TREE [EDITOR_LINE]
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
			make
		end

	TEXT_OBSERVER_MANAGER
		redefine
			make, recycle
		end
create
	make

feature {NONE}-- Initialization

	make is
			-- create an empty text
		do
			{TEXT_OBSERVER_MANAGER} Precursor
			{B_345_TREE} Precursor
			create tab_size_cell.put (default_tabulation_size)
		end

feature -- Content Change

	load_string (a_string: STRING) is
			-- scan `a_string' and fill the object with resulting
			-- lines and tokens
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

	current_line: EDITOR_LINE
		-- current line

	text: STRING is
			-- Image of text in `Current'.
		require
			text_loaded: reading_text_finished
		local
			li: like current_line
		do
			from
				Result := first_line.image
				li := first_line
			until
				li = last_line
			loop
				Result.extend ('%N')
				li := li.next
				Result.append (li.image)
			end
		end

	first_read_block_size: INTEGER
			-- size in lines of the first block of text that
			-- will be read.

	tabulation_size: INTEGER is
			-- Tabulation size in characters.
		do
			Result := tab_size_cell.item
		end

feature -- Status setting

	load_as_basic_text is
			-- Make `Current' use basic text scanner
			-- when loading files or strings
		do
			scan_as_basic_text := True
		end
		
	load_as_eiffel_text is
			-- Make `Current' use eiffel text scanner
			-- when loading files or strings
		do
			scan_as_basic_text := False
		end
		
feature -- Element Change

	set_first_read_block_size (a_size: INTEGER) is
			-- set the size in lines of the first block of text
			-- that will be read.
		require
			valid_size: a_size >= 0
		do
			 first_read_block_size := a_size
		end

	set_tabulation_size (new_tab_size: INTEGER) is
			-- Assign `new_tab_size' to `tabulation_size'
		require
			positive_size: new_tab_size > 0
			no_text_loaded: is_empty
		do
			tab_size_cell.put (new_tab_size)
		end

feature -- Current line status report

	after: BOOLEAN is
			-- is the `current_line' beyond the end of the text ?
		do
			Result := (current_line = Void)
		end

	forth is
			-- move `current_line' to the next line
		require
			not after
		do
			current_line := current_line.next
		end

feature -- Current line change

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

feature -- Measurement

	text_length: INTEGER is
			-- length of displayed text
		do
			Result := text.count
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
			-- is the text currently processed ?

feature {NONE} -- Text Loading

	start_reading_string is
			-- Read the file named `a_name' and perform a lexical analysis
		local
			curr_string	: STRING
			j		: INTEGER
		do
			lexer.set_tab_size_cell (tab_size_cell)

				-- read the file
			from
				if current_string = Void or else current_string.is_empty then
					j := 0
					append_line (new_line_from_lexer (""))
				else
					current_pos := 1
					j := current_string.index_of ('%N', current_pos)
					if j = 0 then
						j := current_string.count + 1
					end
				end
			until
				number_of_lines > first_read_block_size or j = 0
			loop
				curr_string := current_string.substring (current_pos, j - 1)
				append_line (new_line_from_lexer (curr_string))
				current_pos := j + 1
				if current_pos > current_string.count then
					j := 0
				else
					j := current_string.index_of ('%N', current_pos)
					if j = 0 then
						j := current_string.count + 1
					end
				end
			end

			on_text_block_loaded (True)

			if j /= 0 then
					-- the file has not been entirely loaded, so we will
					-- finish loading the file on idle actions.
				reading_text_finished := False
			else
				if (current_string @ current_string.count) = '%N' then
					append_line (new_line_from_lexer (""))
				end
				reading_text_finished := True
				on_text_loaded
			end
			ev_application.idle_actions.extend(Finish_reading_agent)
		end

	finish_reading_string is
			-- Read the file named `a_name' and perform a lexical analysis
		local
			curr_string	: STRING
			j		: INTEGER
			lines_read	: INTEGER
		do
			if not reading_text_finished then
				lexer.set_tab_size_cell (tab_size_cell)
				from
					lines_read := 1
					if current_pos <= current_string.count then
						j := current_string.index_of ('%N', current_pos)
						if j = 0 then
							j := current_string.count + 1
						end
					else
						j := 0
					end
				until
					lines_read > Lines_read_per_idle_action or else j = 0
				loop
					curr_string := current_string.substring (current_pos, j-1)
					append_line (new_line_from_lexer (curr_string))
					current_pos := j + 1
					if current_pos <= current_string.count then
						j := current_string.index_of ('%N', current_pos)
						if j = 0 then
							j := current_string.count + 1
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
					if (current_string @ current_string.count) = '%N' then
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

	new_line_from_lexer (line_image: STRING): EDITOR_LINE is
			-- create a new EDITOR_LINE from `line)image' using
			-- `lexer'.
		require
			no_new_line_in_image: not line_image.has ('%N')
			lexer_has_right_tab_size: tab_size_cell = lexer.tab_size_cell
		do
			lexer.execute (line_image)
			create Result.make_from_lexer (lexer)
		end

	abort_idle_processing is
			-- Stop text processing done during idle actions.
		do
			text_being_processed := False
			ev_application.idle_actions.prune_all (Finish_reading_agent)
		end

	after_reading_idle_action is
			-- action performed on idle when text reading is finished.
		do
			ev_application.idle_actions.prune_all (Finish_reading_agent)
			text_being_processed := False
		end

	Finish_reading_agent: PROCEDURE [like Current, TUPLE] is
			-- Agent for function `finish_reading_file'
		do
			if internal_Finish_reading_agent = Void then
				internal_Finish_reading_agent := ~finish_reading_string
			end
			Result := internal_Finish_reading_agent
		end

feature {NONE} -- Implementation

	eiffel_lexer: EDITOR_EIFFEL_SCANNER is
			-- Eiffel Lexer
		once
			create Result.make
		end
	
	basic_lexer: EDITOR_BASIC_SCANNER is
			-- Basic text lexer
		once
			create Result.make
		end

	lexer: EDITOR_SCANNER is
			-- Text lexer
		do
			if scan_as_basic_text then
				Result := basic_lexer
			else
				Result := eiffel_lexer
			end
		end
		
	scan_as_basic_text: BOOLEAN
			-- Should the text be scanned with a basic text scanner?
		
	current_string: STRING
			-- string to be loaded

	current_pos: INTEGER
			-- position in current_string where loading should be resumed

	internal_finish_reading_agent: like Finish_reading_agent

feature {NONE} -- Private Constants

	Lines_read_per_idle_action: INTEGER is 25
		-- Number of lines read each time finish_reading_file
		-- is called on an idle action.

	Default_tabulation_size: INTEGER is 4

feature {NONE} -- Implementation

	ev_application: EV_APPLICATION is
			-- Current application
		once
			Result := (create {EV_ENVIRONMENT}).application
		end

feature {EB_CLASS_INFO_ANALYZER}-- Tabulation size

	tab_size_cell: CELL [INTEGER]
			-- cell containing tabulation size value

feature -- Memory management

	recycle is
		do
			reset_text
			internal_finish_reading_agent := Void
		end

end -- class TEXT
