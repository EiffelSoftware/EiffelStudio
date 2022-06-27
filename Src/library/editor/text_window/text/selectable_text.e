note
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

	reset_text
		do
			if has_selection then
				disable_selection
			end
			cursor := Void
			selection_cursor := Void
			Precursor
		end

feature -- Access

	cursor: detachable TEXT_CURSOR
			-- Current cursor.

	attached_cursor: attached like cursor
			-- Attached `cursor'.
		require
			not_is_empty: not is_empty and then has_cursor
		local
			l_cursor: like cursor
		do
			l_cursor := cursor
			check l_cursor /= Void end
			Result := l_cursor
		end

	selection_cursor: like cursor
			-- Position where the user has started to select
			-- the text. This position can be below the current
			-- cursor (and therefore represent the end of the
			-- selection)

	attached_selection_cursor: attached like cursor
			-- Attached `selection_cursor'.
		require
			not_is_empty: not is_empty
		local
			l_c: like selection_cursor
		do
			l_c := selection_cursor
			check l_c /= Void end -- Implied by precondition and invariant
			Result := l_c
		end

	current_line_number : INTEGER
			-- Current line number.
		require
			text_is_not_empty: not is_empty
		do
			Result := attached_cursor.y_in_lines
		end

	selection_start: attached like cursor
			-- Beginning of the selection (always < than
			-- `selection_end').
		require
			text_is_not_empty: not is_empty
		local
			l_sel, l_cur: like attached_cursor
		do
			l_sel := attached_selection_cursor
			l_cur := attached_cursor
			if l_cur > l_sel then
				Result := l_sel
			else
				Result := l_cur
			end
		ensure
			result_cursor_position_lesser: Result <= selection_end
		end

	selection_end: attached like cursor
			-- End of the selection (always > than
			-- `selection_start').
		require
			text_is_not_empty: not is_empty
		local
			l_sel, l_cur: like attached_cursor
		do
			l_sel := attached_selection_cursor
			l_cur := attached_cursor
			if l_cur > l_sel then
				Result := l_cur
			else
				Result := l_sel
			end
		ensure
			result_cursor_position_greater: Result >= selection_start
		end

	selected_string: STRING
		obsolete
			"Use `selected_wide_string' instead. [2017-05-31]"
		require
			text_is_not_empty: not is_empty
		do
			Result := selected_wide_string.as_string_8
		end

	selected_wide_string: STRING_32
		require
			text_is_not_empty: not is_empty
		do
			Result := string_selected (selection_start, selection_end)
		end

	current_char: CHARACTER_32
			-- Current character at cursor position
		require
			text_is_not_empty: not is_empty
		do
			Result := attached_cursor.wide_item
		end

feature -- String

	string_between_pos_in_text (a_start_pos, a_end_pos: INTEGER): STRING_32
			-- String between pos_in_text `a_start_pos' and `a_end_pos'.	
		require
			pos_valid: a_start_pos > 0 and a_end_pos > 0
			right_order: a_start_pos <= a_end_pos
		local
			l_start_cursor, l_end_cursor: like cursor
		do
			create l_start_cursor.make_from_integer (a_start_pos, Current)
			create l_end_cursor.make_from_integer (a_end_pos, Current)
			Result := string_between_cursor (l_start_cursor, l_end_cursor)
		end

	string_between_cursor (a_start_cursor, a_end_cursor: like cursor): STRING_32
			-- String between cursors `a_start_cursor' and `a_end_cursor'.
		require
			attached_cursors: a_start_cursor /= Void and then a_end_cursor /= Void
			right_order: a_start_cursor <= a_end_cursor
		local
			ln: like current_line
			t, t2 : detachable EDITOR_TOKEN
		do
				-- Retrieving line after `start_selection'.
			t := a_start_cursor.token
			t2 := a_end_cursor.token
			if t = t2 then
				if a_start_cursor.pos_in_token = a_end_cursor.pos_in_token then
					create Result.make_empty
				else
					create Result.make (t.wide_image.count)
					Result.append_substring (t.wide_image, a_start_cursor.pos_in_token, a_end_cursor.pos_in_token - 1)
				end
			else
				ln := a_start_cursor.line
				from
					if t = ln.eol_token then
						Result := "%N"
						ln := ln.next
						check ln /= Void end -- Never, otherwise a bug.
						t := ln.first_token
					else
						create Result.make (t.wide_image.count)
						Result.append_substring (t.wide_image, a_start_cursor.pos_in_token, t.wide_image.count)
						t := t.next
					end
				until
					t = t2 or t = a_end_cursor.line.eol_token
				loop
					if t = Void or else t = ln.eol_token then
						Result.extend ('%N')
						ln := ln.next
						if ln /= Void then
							t := ln.first_token
						else
						 		-- Never, otherwise a bug.									
							check ln_set: False end
						end
					else
						Result.append (t.wide_image)
						t := t.next
					end
				end
				check
					good_line: ln = a_end_cursor.line
				end
				Result.append_substring (t2.wide_image, 1, a_end_cursor.pos_in_token - 1)
			end
		end

feature -- Status report

	has_selection: BOOLEAN
			-- Is there a selection?
		do
			if attached selection_cursor as l_sel and attached cursor as l_cur then
				Result := internal_has_selection and then not l_sel.is_equal (l_cur)
			end
		end

	selection_is_empty: BOOLEAN
			-- Is the selection empty ?
		require
			text_is_not_empty: not is_empty
		do
			Result := (not has_selection) or else attached_cursor.is_equal (attached_selection_cursor)
		end

	has_cursor: BOOLEAN
			-- is `cursor' set?
		do
			Result := cursor /= Void
		end

feature -- Status setting

	enable_selection
			-- Set that text can be selected in the editor
		require
			text_is_not_empty: not is_empty
		do
			internal_has_selection := True
			on_selection_begun
		end

	disable_selection
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

	set_selection_cursor (c: like cursor)
			-- Set the selection to be from `c' to `cursor'.
			-- Allows empty selections. Be careful about this.
		require
			text_is_not_empty: not is_empty
			cursor_not_void: c /= Void
		do
			selection_cursor := c.twin
		ensure
			selection_cursor_set: attached selection_cursor as l_c and then l_c.is_equal (c)
		end

	select_region (start_pos, end_pos: INTEGER)
			-- Select characters between indexes start_pos and end_pos.
		require
			text_is_not_empty: not is_empty
			text_loading_completed: reading_text_finished
			right_order: start_pos <= end_pos
		local
			had_selection: BOOLEAN
			l_selection_cursor: like attached_selection_cursor
		do
			had_selection := has_selection
			internal_has_selection := False
			disable_selection
			l_selection_cursor := attached_selection_cursor
			l_selection_cursor.set_from_integer (start_pos, Current)
			attached_cursor.set_from_integer (end_pos, Current)
			if not attached_cursor.is_equal (l_selection_cursor) then
				internal_has_selection := True
				if not had_selection then
					on_selection_begun
				end
			elseif had_selection then
				on_selection_finished
			end
		end

	select_all
			-- Select the entire text.
		require
			text_is_not_empty: not is_empty
		local
			l_line: like first_line
		do
			l_line := first_line
			check l_line /= Void end -- Implied by not `empty'.
			attached_selection_cursor.set_line (l_line)
			attached_selection_cursor.go_start_line
			l_line := last_line
			check l_line /= Void end -- Implied by not `empty'.
			attached_cursor.set_line (l_line)
			attached_cursor.go_end_line
			enable_selection
		ensure
			selection: has_selection
			cursor_positioned: attached last_line as l_last_line and then
							attached_cursor.line = l_last_line and then attached_cursor.token = l_last_line.eol_token
			selection_cursor_positioned: attached first_line as l_first_line and then
										attached_selection_cursor.line = l_first_line and then attached_selection_cursor.token = l_first_line.first_token
		end

	forget_selection
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

	search_string_from_cursor (searched_string: STRING)
			-- Search the text for the string `searched_string'.
			-- Begin search from position of cursor.
			-- If the search was successful, `successful_search' is
			-- set to True and `found_string_line' &
			-- `found_string_character_position' are set.
		require
			text_is_not_empty: not is_empty
		local
			line_string: STRING_32
			found_index,
			line_number,
			full_found_index: INTEGER
			l_cursor: like attached_cursor
			l_cur_line: like current_line
		do
				-- Reset the success tag.
			successful_search := False

				-- Search the string.
			l_cursor := attached_cursor
			from
				go_i_th (l_cursor.y_in_lines)
				line_number := l_cursor.y_in_lines
				l_cur_line := current_line
				check l_cur_line /= Void end -- Implied by `go_i_th'
				line_string := l_cur_line.wide_image
				full_found_index := l_cursor.pos_in_characters
				if line_string.count >= searched_string.count then
					found_index := line_string.substring (l_cursor.x_in_characters, line_string.count).substring_index (searched_string, 1) - 1
				end
				if found_index > 0 then
					full_found_index := full_found_index + found_index
				else
					full_found_index := full_found_index + l_cur_line.wide_image.count - l_cursor.x_in_characters
				end
				forth
			until
				found_index > 0 or else after
			loop
				l_cur_line := current_line
				check l_cur_line /= Void end -- Implied by not `after'
				line_string := l_cur_line.wide_image
				if line_string.count >= searched_string.count then
					found_index := line_string.substring_index (searched_string, 1)
				end
				line_number := line_number + 1
				if found_index > 0 then
					full_found_index := full_found_index + found_index + 1
				else
					full_found_index := full_found_index + l_cur_line.wide_image.count + 1
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

	on_text_block_loaded (was_first_block: BOOLEAN)
			-- Create cursors as the first block of text has been read.
		local
			l_line: like first_line
			l_token: detachable EDITOR_TOKEN
		do
			if was_first_block then
				l_line := first_line
				check l_line /= Void end -- Implied by text is loaded.
				l_token := l_line.first_token
				check l_token /= Void end -- First token not void.
				create cursor.make_from_relative_pos (l_line, l_token, 1, Current)
				set_selection_cursor (cursor)
			end
			Precursor {TEXT} (was_first_block)
		end

	string_selected (start_sel, end_sel: like cursor): STRING_32
			-- String between cursors `start_sel' and `end_sel'.
		require
			attached_cursors: start_sel /= Void and then end_sel /= Void
			right_order: start_sel <= end_sel
		do
			Result := string_between_cursor (start_sel, end_sel)
		end

invariant
	valid_selection: has_selection implies selection_cursor /= Void
	-- cursor_exists: not is_empty implies cursor /= Void
	-- selection_cursor_exists: not is_empty implies selection_cursor /= Void
	-- no_cursor_when_empty: is_empty implies cursor = Void and then selection_cursor = Void

note
	copyright:	"Copyright (c) 1984-2022, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class SELECTABLE_TEXT

