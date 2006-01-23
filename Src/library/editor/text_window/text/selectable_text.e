indexing
	description: "[
		Read only text with cursor and selection.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			-- Beginning of the selection (always < than
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
		ensure
			result_cursor_position_lesser: Result <= selection_end
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
		ensure
			result_cursor_position_greater: Result >= selection_start
		end

	selected_string: STRING is
		require
			text_is_not_empty: not is_empty
		do
			Result := string_selected (selection_start, selection_end)
		end

feature -- Status report

	has_selection: BOOLEAN is
			-- Is there a selection?
		do
			if selection_cursor /= Void then
				Result := internal_has_selection and then not selection_cursor.is_equal (cursor)
			end
		end

	selection_is_empty: BOOLEAN is
			-- Is the selection empty ?
		require
			text_is_not_empty: not is_empty
		do
			Result := (not has_selection) or else cursor.is_equal (selection_cursor)
		end

feature -- Status setting

	enable_selection is
			-- Set that text can be selected in the editor
		require
			text_is_not_empty: not is_empty
		do
			internal_has_selection := True
			on_selection_begun
		end

	disable_selection is
			-- Set that text cannot be selected in the editor
		require
			text_is_not_empty: not is_empty
		do
			internal_has_selection := False
			on_selection_finished
		ensure
			no_selection: not has_selection
		end

	internal_has_selection: BOOLEAN
			-- here for debugging

feature -- Selection Changes

	set_selection_cursor (c: like cursor) is
			-- Set the selection to be from `c' to `cursor'.
			-- Allows empty selections. Be careful about this.
		require
			text_is_not_empty: not is_empty
			cursor_not_void: c /= Void
		do
			selection_cursor := c.twin			
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
			internal_has_selection := False
			disable_selection
			selection_cursor.make_from_integer (start_pos, Current)
			cursor.make_from_integer (end_pos, Current)
			if not cursor.is_equal (selection_cursor) then
				internal_has_selection := True
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
			selection_cursor_positioned: selection_cursor.line = first_line and then selection_cursor.token = first_line.first_token
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

	search_string_from_cursor (searched_string: STRING) is
			-- Search the text for the string `searched_string'.  
			-- Begin search from position of cursor.
			-- If the search was successful, `successful_search' is
			-- set to True and `found_string_line' & 
			-- `found_string_character_position' are set.
		require
			text_is_not_empty: not is_empty
		local
			line_string: STRING
			found_index,
			line_number,
			full_found_index: INTEGER			
		do			
				-- Reset the success tag.
			successful_search := False

				-- Search the string.
			from
				go_i_th (cursor.y_in_lines)
				line_number := cursor.y_in_lines
				line_string := current_line.image
				full_found_index := cursor.pos_in_characters
				if line_string.count >= searched_string.count then
					found_index := line_string.substring (cursor.x_in_characters, line_string.count).substring_index (searched_string, 1) - 1
				end
				if found_index > 0 then
					full_found_index := full_found_index + found_index
				else
					full_found_index := full_found_index + current_line.image.count - cursor.x_in_characters
				end				
				forth
			until
				found_index > 0 or else after
			loop
				line_string := current_line.image
				if line_string.count >= searched_string.count then
					found_index := line_string.substring_index (searched_string, 1)
				end
				line_number := line_number + 1
				if found_index > 0 then
					full_found_index := full_found_index + found_index + 1
				else
					full_found_index := full_found_index + current_line.image.count + 1
				end

					-- Prepare next iteration.
				forth
			end

				-- If the search was successful, set the results attributes.
			if found_index > 0 then
				successful_search := True
				found_string_line := line_number
				found_string_character_position := found_index
				found_string_total_character_position := full_found_index
			end
		end

feature {NONE} -- Implementation

	on_text_block_loaded (was_first_block: BOOLEAN) is
			-- Create cursors as the first block of text has been read.
		do
			if was_first_block then
				create cursor.make_from_integer (1, Current)
				set_selection_cursor (cursor)
			end
			Precursor {TEXT} (was_first_block)
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
						t = t2 or t = end_sel.line.eol_token
					loop
						if t = Void or else t = ln.eol_token then
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
--	cursor_exists: not is_empty implies cursor /= Void
--	selection_cursor_exists: not is_empty implies selection_cursor /= Void
	no_cursor_when_empty: is_empty implies cursor = Void and then selection_cursor = Void
	
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




end -- class SELECTABLE_TEXT
	
