indexing
	description	: "Whole text displayed in the editor window."
	author		: "Christophe Bonnard / Arnaud PICHERY [ aranud@mail.dotcom.fr ]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EDITOR_CONTENT 

inherit
	B_345_TREE [EDITOR_LINE]
		rename
			first_data as first_line,
			last_data as last_line
		end

create
	make, make_from_file

feature -- Initialization

	make_from_file (fn: STRING) is
		do
			make
			--| FIXME: Not yet implemented.
		end	

feature -- Access

	first_displayed_line: like current_line

	last_displayed_line: like current_line

	nb_of_lines_displayed: INTEGER

	lexer: EIFFEL_SCANNER is
			-- Eiffel Lexer
		once
			create Result.make
		end

feature -- Search status

	found_string_line: INTEGER
			-- Line number of the last found string.
			-- Valid only if `successful_search' is set.

	found_string_character_position: INTEGER
			-- Position of the first character within the line of the last string.
			-- Valid only if `successful_search' is set.
	
	successful_search: BOOLEAN
			-- Was the last call to `search_string' successful?

feature -- test features

	current_line: EDITOR_LINE

	after: BOOLEAN is
		do
			Result := (current_line = Void)
		end

	forth is
		require
			not after
		do
			current_line := current_line.next
		end

	go_i_th (i: INTEGER) is
		require
			valid_i: i >= 1 and then i <= count
		do
			current_line := item (i)
		end

	start is
		require
			count >= 1
		do
			current_line := first_line
		end

feature -- Basic Operations

	delete_selection (start_selection: EDITOR_CURSOR; end_selection: EDITOR_CURSOR) is
			-- Delete text between `start_selection' until `end_selection'.
			-- `end_selection' is not included.
		require
				right_order: start_selection < end_selection
		local
			s: STRING
			line: like current_line
			t : EDITOR_TOKEN
		do
				-- Retrieving line before `start_selection'.
			line := start_selection.line
			t := start_selection.token
			if t /= line.eol_token then
				from
					s := t.image.substring (1, start_selection.pos_in_token - 1)
					t := t.previous
				until
					t = Void
				loop
					s.prepend (t.image)
					t := t.previous
				end
			else
				s := line.image
			end
				-- Retrieving line after `end_selection'.
			line := end_selection.line
			t := end_selection.token
			if t /= line.eol_token then
				from
					s.append (t.image.substring (end_selection.pos_in_token, t.image.count))
					t := t.next
				until
					t = line.eol_token
				loop
					s.append (t.image)
					t := t.next
				end
			end
				-- Removing unwanted lines.
			line := start_selection.line
			if line /= end_selection.line then
				from
				until
					line.next = end_selection.line
				loop
					line.next.delete
				end
				line.next.delete
			end
				-- Rebuild line with previously collected parts.
			lexer.execute (s)
			line.make_from_lexer (lexer)
		end

	comment_selection(start_selection: EDITOR_CURSOR; end_selection: EDITOR_CURSOR) is
			-- Comment all lines included in the selection with the string `symbol'.
			-- Even If `start_selection' does not begin the line, the entire line
			-- is commented. Same for the last line of the selection.
		do
			symbol_selection(start_selection, end_selection, "--")
		end

	uncomment_selection(start_selection: EDITOR_CURSOR; end_selection: EDITOR_CURSOR) is
			-- Uncomment all lines included in the selection with the string `symbol'.
			-- Even If `start_selection' does not begin the line, the entire line
			-- is uncommented. Same for the last line of the selection.
		do
			unsymbol_selection(start_selection, end_selection, "--")
		end

	indent_selection(start_selection: EDITOR_CURSOR; end_selection: EDITOR_CURSOR) is
			-- Tabify all lines included in the selection with the string `symbol'.
			-- Even If `start_selection' does not begin the line, the entire line
			-- is commented. Same for the last line of the selection.
		do
			symbol_selection(start_selection, end_selection, "%T")
		end

	unindent_selection(start_selection: EDITOR_CURSOR; end_selection: EDITOR_CURSOR) is
			-- Tabify all lines included in the selection with the string `symbol'.
			-- Even If `start_selection' does not begin the line, the entire line
			-- is commented. Same for the last line of the selection.
		do
			unsymbol_selection(start_selection, end_selection, "%T")
		end

	search_string(searched_string: STRING) is
			-- Search the text for the string `searched_string'.
			-- If the search was successful, `successful_search' is
			-- set to True and `found_string_line' & 
			-- `found_string_character_position' are set.
		local
			found		: BOOLEAN
			line_string	: STRING
			found_index : INTEGER
			line_number : INTEGER
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
				line_string := current_line.image
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

	string_selected (start_selection: EDITOR_CURSOR; end_selection: EDITOR_CURSOR): STRING is
		require
				right_order: start_selection < end_selection
		local
			line: like current_line
			t, t2 : EDITOR_TOKEN
		do
				-- Retrieving line after `start_selection'.
			t := start_selection.token
			t2 := end_selection.token
			if t = t2 then
				if start_selection.pos_in_token = end_selection.pos_in_token then
					Result := ""
				else
					Result := t.image.substring (start_selection.pos_in_token, end_selection.pos_in_token -1)
				end
			else
				line := start_selection.line
				from
					if t = line.eol_token then
						Result := "%N"
						line := line.next
						if line = Void then
							check
								never_reached: False
							end
						else
							t := line.first_token
						end
					else
						Result := t.image.substring (start_selection.pos_in_token, t.image.count)
						t := t.next
					end
				until
					t = t2
				loop
					if t = line.eol_token then
						Result.extend ('%N')
						line := line.next
						if line = Void then
							check
								never_reached: False
							end
						else
							t := line.first_token
						end
					else
						Result.append (t.image)
						t := t.next
					end
				end
				check
					good_line: line = end_selection.line
				end
				Result.append (t2.image.substring (1, end_selection.pos_in_token -1))
			end
		end


feature {NONE} -- Private feature

	symbol_selection (start_selection: EDITOR_CURSOR; end_selection: EDITOR_CURSOR; symbol: STRING) is
			-- Prepend all lines included in the selection with the string `symbol'.
			-- Even If `start_selection' does not begin the line, the entire line
			-- is prepended with `symbol'. Same for the last line of the selection.
		require
				valid_selection: start_selection /= Void and end_selection /= Void
				right_order: start_selection < end_selection
				valid_symbol: symbol /= Void and then not symbol.empty
		local
			line_image	: STRING			-- String representation of the current line
			line		: like current_line	-- Current line
		do
			from
				line := start_selection.line
			until
				line = end_selection.line
			loop
					-- Retrieve the string representation of the line
				line_image := line.image

					-- Add the commentary symbol in front of the line
				line_image.prepend(symbol)

					-- Rebuild line from the lexer.
				lexer.execute (line_image)
				line.make_from_lexer (lexer)

				if line = start_selection.line then
						-- shift the selection cursor
					start_selection.set_x_in_characters((start_selection.x_in_characters + symbol.count).max(1))
				end
					-- Prepare next iteration
				line := line.next
			end

				-- handle the last line differently because if the cursor is on the
				-- first character, we do not want to add the symbol
			if end_selection.token /= line.first_token or else end_selection.pos_in_token /= 1 then
					-- Retrieve the string representation of the line
				line_image := line.image

					-- Add the commentary symbol in front of the line
				line_image.prepend(symbol)

					-- Rebuild line from the lexer.
				lexer.execute (line_image)
				line.make_from_lexer (lexer)

					-- shift the selection cursor
				end_selection.set_x_in_characters((end_selection.x_in_characters + symbol.count).max(1))
			end
		end

	unsymbol_selection (start_selection: EDITOR_CURSOR; end_selection: EDITOR_CURSOR; symbol: STRING) is
			-- Prepend all lines included in the selection with the string `symbol'.
			-- Even If `start_selection' does not begin the line, the entire line
			-- is prepended with `symbol'. Same for the last line of the selection.
			-- A line is uncommented only if it begins with `symbol'.
		require
				valid_selection: start_selection /= Void and end_selection /= Void
				right_order: start_selection < end_selection
				valid_symbol: symbol /= Void and then not symbol.empty
		local
			line_image		: STRING			-- String representation of the current line
			line			: like current_line	-- Current line
			symbol_length	: INTEGER			-- number of characters in `symbol'
		do
			symbol_length := symbol.count

			from
				line := start_selection.line
			until
				line = end_selection.line
			loop
					-- Retrieve the string representation of the line
				line_image := line.image

					-- Remove the commentary symbol in front of the line (if any)
				if (line_image.count >= symbol_length) and then (line_image.substring(1, symbol_length).is_equal(symbol)) then
					line_image := line_image.substring(symbol_length + 1, line_image.count)

						-- Rebuild line from the lexer.
					lexer.execute (line_image)
					line.make_from_lexer (lexer)

						-- shift the selection cursor
					if line = start_selection.line then
						start_selection.set_x_in_characters((start_selection.x_in_characters - symbol_length).max(1))
					end
				end

					-- Prepare next iteration
				line := line.next
			end

				-- handle the last line differently because if the cursor is on the
				-- first character, we do not want to remove the symbol
			if end_selection.token /= line.first_token or else end_selection.pos_in_token /= 1 then
					-- Retrieve the string representation of the line
				line_image := line.image

					-- Remove the commentary symbol in front of the line (if any)
				if (line_image.count >= symbol_length) and then (line_image.substring(1, symbol_length).is_equal(symbol)) then
					line_image := line_image.substring(symbol_length + 1, line_image.count)

						-- Rebuild line from the lexer.
					lexer.execute (line_image)
					line.make_from_lexer (lexer)

						-- shift the selection cursor
					end_selection.set_x_in_characters((end_selection.x_in_characters - symbol_length).max(1))
				end
			end
		end

feature -- Element Change

	prepend_line (a_line: like first_displayed_line) is
		local
			first_line_figure	: EV_FIGURE_GROUP
			curr_line_figure	: EV_FIGURE_GROUP
			rel_point			: EV_RELATIVE_POINT
		do
			prepend_data (a_line)
		end

	append_line, extend (a_line: like first_displayed_line) is
		local
			last_line_figure	: EV_FIGURE_GROUP
			curr_line_figure	: EV_FIGURE_GROUP
			rel_point			: EV_RELATIVE_POINT
		do
			append_data (a_line)
		end

end -- class EDITOR_CONTENT
