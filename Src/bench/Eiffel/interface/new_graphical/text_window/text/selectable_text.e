indexing
	description: "[
		Read only text with cursor and selection.
	]"
	author: "Etienne Amodeo"
	date: "$Date$"
	revision: "$Revision$"

class
	SELECTABLE_TEXT

inherit
	TEXT
		redefine
			reset_text,
			on_text_block_loaded
		end
	
create
	make

feature -- Initialization

	reset_text is
		do
			if has_selection then
				disable_selection
			end
			Precursor
			cursor := Void
			selection_cursor := Void
		end

feature -- Access

	cursor: TEXT_CURSOR
			-- Current cursor.

	selection_cursor: like cursor
			-- Position where the user has started to select
			-- the text. This position can be below the current
			-- cursor (and therefore represent the end of the
			-- selection)

	current_line_number : INTEGER is
			-- Current line number.
		require
			text_is_not_empty: not is_empty
		do
			Result := cursor.y_in_lines
		end

	selection_start: like cursor is
			-- Beggining of the selection (always < than
			-- `selection_end').
		require
			text_is_not_empty: not is_empty
		do
			check
				selection_cursor_exists: selection_cursor /= Void
			end
			if cursor > selection_cursor then
				Result := selection_cursor
			else
				Result := cursor
			end
		end

	selection_end: like cursor is
			-- End of the selection (always > than
			-- `selection_start').
		require
			text_is_not_empty: not is_empty
		do
			check
				selection_cursor_exists: selection_cursor /= Void
			end
			if cursor > selection_cursor then
				Result := cursor
			else
				Result := selection_cursor
			end
		end

	selected_string: STRING is
		require
			text_is_not_empty: not is_empty
		do
			Result := string_selected (selection_start, selection_end)
		end

feature -- Status report

	has_selection: BOOLEAN
			-- Is there a selection?

	selection_is_empty: BOOLEAN is
			-- Is the selection empty ?
		require
			text_is_not_empty: not is_empty
		do
			Result := (not has_selection) or else cursor.is_equal (selection_cursor)
		end

feature -- Status setting

	enable_selection is
			-- Set that there is text selected in the editor
		require
			text_is_not_empty: not is_empty
		do
			has_selection := True
			on_selection_begun
		ensure
			selection: has_selection	
		end

	disable_selection is
			-- Set that no text is selected in the editor
		require
			text_is_not_empty: not is_empty
			selection_exists: has_selection
		do
			has_selection := False
			on_selection_finished
		ensure
			no_selection: not has_selection
		end

feature -- Selection Changes

	set_selection_cursor (c: like cursor) is
			-- Set the selection to be from `c' to `cursor'.
			-- Allows empty selections. Be careful about this.
		require
			text_is_not_empty: not is_empty
			cursor_not_void: c /= Void
		do
			selection_cursor := clone (c)
			enable_selection
		ensure
			selection_cursor.is_equal (c)
		end

	select_region (start_pos, end_pos: INTEGER) is
			-- Select characters between indexes start_pos and end_pos.
		require
			text_is_not_empty: not is_empty
			text_loading_completed: reading_text_finished
			right_order: start_pos <= end_pos
		local
			had_selection: BOOLEAN
		do
			had_selection := has_selection
			has_selection := False
			selection_cursor.make_from_integer (start_pos, Current)
			cursor.make_from_integer (end_pos, Current)
			if not cursor.is_equal (selection_cursor) then
				has_selection := True
				if not had_selection then
					on_selection_begun
				end
			elseif had_selection then
				on_selection_finished
			end
		end

	select_all is
			-- Select the entire text.
		require
			text_is_not_empty: not is_empty
		do
			selection_cursor.set_line (first_line)
			selection_cursor.go_start_line
			cursor.set_line (last_line)
			cursor.go_end_line
			enable_selection
		ensure
			selection: has_selection
			cursor_positioned: cursor.line = last_line and then cursor.token = last_line.eol_token
			selection_cursor_positioned: selection_cursor.line = last_line and then selection_cursor.token = last_line.eol_token
		end

	forget_selection is
			-- Unselect all.
		require
			text_is_not_empty: not is_empty
		do
			if has_selection then
				disable_selection
			end
		ensure
			no_selection: not has_selection
		end

feature -- Search

	search_string (searched_string: STRING) is
			-- Search the text for the string `searched_string'.
			-- If the search was successful, `successful_search' is
			-- set to True and `found_string_line' & 
			-- `found_string_character_position' are set.
		require
			text_is_not_empty: not is_empty
		local
			line_string: STRING
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

feature -- Search status

	found_string_line: INTEGER
			-- Line number of the last found string.
			-- Valid only if `successful_search' is set.

	found_string_character_position: INTEGER
			-- Position of the first character within the line of the last string.
			-- Valid only if `successful_search' is set.
	
	successful_search: BOOLEAN
			-- Was the last call to `search_string' successful?

feature {NONE} -- Implementation

	on_text_block_loaded (was_first_block: BOOLEAN) is
			-- Create cursors as the first block of text has been read.
		do
			if was_first_block then
				create cursor.make_from_integer (1, Current)
				selection_cursor := clone (cursor)
			end
			{TEXT} Precursor (was_first_block)
		end

	string_selected (start_sel, end_sel: like cursor): STRING is
			-- String between cursors `start_sel' and `end_sel'.
		require
				right_order: start_sel < end_sel
		local
			ln: like current_line
			t, t2 : EDITOR_TOKEN
		do
				-- Retrieving line after `start_selection'.
			t := start_sel.token
			t2 := end_sel.token
			if t = t2 then
				if start_sel.pos_in_token = end_sel.pos_in_token then
					Result := ""
				else
					Result := t.image.substring (start_sel.pos_in_token, end_sel.pos_in_token -1)
				end
			else
				ln := start_sel.line
				from
					if t = ln.eol_token then
						Result := "%N"
						ln := ln.next
						if ln = Void then
							check
								never_reached: False
							end
						else
							t := ln.first_token
						end
					else
						Result := t.image.substring (start_sel.pos_in_token, t.image.count)
						t := t.next
					end
				until
					t = t2
				loop
					if t = ln.eol_token then
						Result.extend ('%N')
						ln := ln.next
						if ln = Void then
							check
								never_reached: False
							end
						else
							t := ln.first_token
						end
					else
						Result.append (t.image)
						t := t.next
					end
				end
				check
					good_line: ln = end_sel.line
				end
				Result.append (t2.image.substring (1, end_sel.pos_in_token -1))
			end
		end

invariant
	valid_selection: has_selection implies selection_cursor /= Void
	cursor_exists: not is_empty implies cursor /= Void
	selection_cursor_exists: not is_empty implies selection_cursor /= Void
	no_cursor_when_empty: is_empty implies cursor = Void and then selection_cursor = Void

end -- class SELECTABLE_TEXT
