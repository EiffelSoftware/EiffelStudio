indexing

	description: 
		"Text widget where tabulation characters are expanded %
			%to `tablength' blank characters.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	TABBED_TEXT_M

inherit

	TABBED_TEXT_I
		rename
			append as i_append,
			insert as i_insert,
			replace as i_replace,
			set_text as i_set_text,
			text as i_text,
			clear as i_clear,
			count as i_count,
			cursor_position as i_cursor_position,
			set_cursor_position as i_set_cursor_position,
			set_selection as i_set_selection,
			begin_of_selection as i_begin_of_selection,
			end_of_selection as i_end_of_selection,
			x_coordinate as i_x_coordinate,
			y_coordinate as i_y_coordinate,
			character_position as i_character_position
		select
			i_append, i_insert, i_replace, i_set_text, i_text, 
			i_clear, i_count, i_cursor_position, i_set_cursor_position,
			i_set_selection, i_begin_of_selection, i_end_of_selection,
			i_x_coordinate, i_y_coordinate, i_character_position
		end;

	SCROLLED_T_M
		rename
			make as st_make,
			make_word_wrapped as st_make_word_wrapped,
            append as st_append,
            replace as st_replace,
            set_text as st_set_text,
            text as st_text,
            clear as st_clear,
            count as st_count,
            cursor_position as st_cursor_position,
            set_cursor_position as st_set_cursor_position,
            set_selection as st_set_selection,
            begin_of_selection as st_begin_of_selection,
            end_of_selection as st_end_of_selection,
            x_coordinate as st_x_coordinate,
            y_coordinate as st_y_coordinate,
            character_position as st_character_position
		end;

	COMMAND
		redefine
			context_data_useful
		end

creation
	make, make_word_wrapped

feature -- Initialization

	make (a_scrolled_text: TEXT; man: BOOLEAN; oui_parent: COMPOSITE) is
			--  Create a text with `a_name' as identifier,
			--  `a_parent' as parent and call `set_default'.
		do
			st_make (a_scrolled_text, man, oui_parent);
			disable_verify_bell;
			!! tab_list.make;
				-- Insert the end of text.
			tab_list.extend (0);
			tab_list.finish;
			tab_length := 8;
			add_callbacks
		end;

	make_word_wrapped (a_scrolled_text: TEXT; man: BOOLEAN; oui_parent: COMPOSITE) is
			--  Create a text with `a_name' as identifier,
			--  `a_parent' as parent and call `set_default'.
		do
			st_make_word_wrapped (a_scrolled_text, man, oui_parent);
			disable_verify_bell;
			!! tab_list.make;
				-- Insert the end of text.
			tab_list.extend (0);
			tab_list.finish;
			tab_length := 8;
			add_callbacks
		end;

feature -- Status report

    tab_length: INTEGER;
            -- Number of blank characters in a tabulation

feature -- Status setting

	set_tab_length (new_length: INTEGER) is
			-- Assign `new_length' to `tab_length'.
			-- Update the text in the widget.
		local
			unexpanded_text: STRING;
			last_cursor_position: INTEGER
		do
			last_cursor_position := i_cursor_position;
			unexpanded_text := i_text;
			tab_length := new_length;
			i_set_text (unexpanded_text);
			i_set_cursor_position (last_cursor_position)
		end;

feature -- Access

	i_character_position (x_pos, y_pos: INTEGER): INTEGER is
			-- Character position at cursor position `x' and `y'
		do	
			Result := unexpanded_position 
				(st_character_position (x_pos, y_pos))
		end;

	i_x_coordinate (char_pos: INTEGER): INTEGER is
			-- X coordinate relative to the upper left corner
			-- of Current text widget at character position `char_pos'.
		do
			Result := st_x_coordinate (expanded_position (char_pos))
		end;

	i_y_coordinate (char_pos: INTEGER): INTEGER is
			-- Y coordinate relative to the upper left corner
			-- of Current text widget at character position `char_pos'.
		do
			Result := st_y_coordinate (expanded_position (char_pos))
		end;

feature -- Text manipulation

	i_replace (from_position, to_position: INTEGER; a_text: STRING) is
			--  Replace text from `from_position' to `to_position' by `a_text'.
		local
			w_start, w_end, i, text_count: INTEGER;
			start_offset, tab_nb: INTEGER;
			expanded_text, tab: STRING;
			text_area: SPECIAL [CHARACTER];
			at_last_char: BOOLEAN
		do
			text_count := a_text.count;
			!! expanded_text.make (text_count + 20);
			!! tab.make (tab_length); tab.fill_blank;
			w_start := expanded_position (from_position);
			start_offset := tab_list.item - last_offset;
			w_end := expanded_position (to_position);
				-- Remove all tabs between `from_position' and `to_position'.
			from 
				tab_nb := (w_end - w_start - to_position + from_position) 
															// (tab_length - 1);
				tab_list.put (last_offset + start_offset);
				last_unexp_position := last_unexp_position - 
												(to_position - from_position);
				last_exp_position := last_exp_position - (w_end - w_start);
				i := 1 
			until 
				i > tab_nb 
			loop
				tab_list.remove_left
				i := i + 1
			end;

			from 
				text_area := a_text.area;
				i := 0
			until 
				i >= text_count 
			loop
				if text_area.item (i) = '%T' then
					tab_list.put_left (tab_list.item - last_offset);
					tab_list.put (last_offset);
					last_exp_position := last_exp_position + tab_length;
					last_unexp_position := last_unexp_position + 1;
					expanded_text.append (tab)
				else
					tab_list.put (tab_list.item + 1);
					last_exp_position := last_exp_position + 1;
					last_unexp_position := last_unexp_position + 1;
					expanded_text.extend (text_area.item (i))
				end;
				i := i + 1
			end;
			internal_action := True;
			if i_count = st_cursor_position then
					-- This is a hack. On some platforms, the cursor
					-- stays before the character we just type if this
					-- character is the last one in the text.
				at_last_char := true
			end;
			st_replace (w_start, w_end, expanded_text);
			if at_last_char then
				st_set_cursor_position (st_cursor_position)
			end
			internal_action := False
debug ("TABULATION")
	io.error.putstring ("tabulations after `replace': %N");
	tabulations_trace
end;
		end;

	i_insert (a_text: STRING; a_position: INTEGER) is
			--  Insert `a_text' in current text field at `a_position'.
		local
			w_pos, i, text_count: INTEGER;
			expanded_text, tab: STRING;
			text_area: SPECIAL [CHARACTER]
		do
			text_count := a_text.count;
			!! expanded_text.make (text_count + 20);
			!! tab.make (tab_length); tab.fill_blank;
			w_pos := expanded_position (a_position);
			from
				text_area := a_text.area
			until
				i >= text_count
			loop
				if text_area.item (i) = '%T' then
					tab_list.put_left (tab_list.item - last_offset);
					tab_list.put (last_offset);
					last_exp_position := last_exp_position + tab_length;
					last_unexp_position := last_unexp_position + 1;
					expanded_text.append (tab)
				else
					tab_list.put (tab_list.item + 1);
					last_exp_position := last_exp_position + 1;
					last_unexp_position := last_unexp_position + 1;
					expanded_text.extend (text_area.item (i))
				end;
				i := i + 1
			end;
			internal_action := True;
			mel_insert (w_pos, expanded_text);
			internal_action := False
debug ("TABULATION")
	io.error.putstring ("tabulations after `insert': %N");
	tabulations_trace
end;
		end;

	i_append (a_text: STRING) is
			--  Append `a_text' at the end of current text.
		local
			i, text_count: INTEGER;
			text_area: SPECIAL [CHARACTER];
			expanded_text, tab: STRING;
		do
			text_count := a_text.count;
			!! expanded_text.make (text_count + 20);
			!! tab.make (tab_length); tab.fill_blank;
			tab_list.finish;
			last_offset := 0;
			last_exp_position := st_count;
			last_unexp_position := i_count;
			from
				text_area := a_text.area
			until
				i >= text_count
			loop
				if text_area.item (i) = '%T' then
					tab_list.put_right (0); tab_list.forth;
					last_exp_position := last_exp_position + tab_length;
					last_unexp_position := last_unexp_position + 1;
					expanded_text.append (tab)
				else
					tab_list.put (tab_list.item + 1);
					last_exp_position := last_exp_position + 1;
					last_unexp_position := last_unexp_position + 1;
					expanded_text.extend (text_area.item (i))
				end;
				i := i + 1
			end;
			internal_action := True;
			st_append (expanded_text);
			internal_action := False
debug ("TABULATION")
	io.error.putstring ("tabulations after `append': %N");
	tabulations_trace
end;
		end;

	i_set_text (a_text: STRING) is
			--  Set `text' to `a_text'.
		local
			i, text_count: INTEGER;
			text_area: SPECIAL [CHARACTER];
			expanded_text, tab: STRING;
		do
			text_count := a_text.count;
			!! expanded_text.make (text_count + 20);
			!! tab.make (tab_length); tab.fill_blank;
			tab_list.wipe_out; tab_list.extend (0);
			tab_list.finish;
			from
				text_area := a_text.area
			until
				i >= text_count
			loop
				if text_area.item (i) = '%T' then
					tab_list.put_right (0); tab_list.forth;
					expanded_text.append (tab)
				else
					tab_list.put (tab_list.item + 1);
					expanded_text.extend (text_area.item (i))
				end;
				i := i + 1
			end;
			tab_list.start;
			last_unexp_position := 0;
			last_exp_position := 0;
			last_offset := tab_list.item;
			internal_action := True;
			st_set_text (expanded_text);
			internal_action := False
debug ("TABULATION")
	io.error.putstring ("tabulations after `set_text': %N");
	tabulations_trace
end;
		end;
		
	i_clear is
			--  Clear current text field.
		do
			tab_list.wipe_out;
			tab_list.extend (0);
			tab_list.start;
			last_unexp_position := 0;
			last_exp_position := 0;
			last_offset := 0;
			internal_action := True;
			st_clear;
			internal_action := False
debug ("TABULATION")
	io.error.putstring ("tabulations after `clear': %N");
	tabulations_trace
end;
		end;

	i_text: STRING is
			-- Text with non expanded tabs
		local
			expanded_text: STRING;
			old_index, tab_pos: INTEGER;
			tab, exp_tab: STRING
		do
			internal_action := True;
			expanded_text := st_text;
			internal_action := False;
			!! Result.make (expanded_text.count);
			!!tab.make (tab_length);
			tab.fill_blank;
			from
				old_index := tab_list.index;
				tab_list.start;
				tab_pos := tab_list.item + 1
			until
				tab_list.islast
			loop
				if tab_list.item /= 0 then
					Result.append (expanded_text.substring 
										(tab_pos - tab_list.item, tab_pos - 1))
				end;
				exp_tab := expanded_text.substring (tab_pos, tab_pos + tab_length -1);
				if exp_tab.is_equal (tab) then
					Result.extend ('%T')
				else
						-- Just to be sure the relevant text will not be lost...
					Result.append (exp_tab)
				end;
				tab_list.forth;
				tab_pos := tab_pos + tab_length + tab_list.item
			end;
			if tab_list.item /= 0 then
				Result.append (expanded_text.substring 
										(tab_pos - tab_list.item, tab_pos - 1))
			end;
			tab_list.go_i_th (old_index)
print ("Result count: ")
print (Result.count)
print (" i_count: ")
print (i_count)
print (" st_count: ")
print (st_count)
io.new_line
		end;

feature -- Text count

	i_count: INTEGER is
			--  Number of character in current text
		do
			internal_action := True;
			Result := st_count - (tab_list.count - 1) * (tab_length - 1);
			internal_action := False
		end;

feature -- Text cursor position

	i_cursor_position: INTEGER is
			--  Current position of the text cursor (it indicates the position
			--  where the next character pressed by the user will be inserted)
		do
			internal_action := True;
			Result := unexpanded_position (st_cursor_position);
			internal_action := False
		end;

	i_set_cursor_position (a_position: INTEGER) is
			--  Set `cursor_position' to `a_position'.
		do
			internal_action := True;
			st_set_cursor_position (expanded_position (a_position));
			internal_action := False
		end;

feature -- Text selection

	i_set_selection (first, last: INTEGER) is
			--  Select the text between `first' and `last'.
			--  This text will be physically highlightened on the screen.
		local
			w_first, w_last: INTEGER
		do
			if last <= i_count then
				w_first := expanded_position (first);
				w_last := expanded_position (last);
				internal_action := True;
				st_set_selection (w_first, w_last);
				internal_action := False
			end
		end;

	i_begin_of_selection: INTEGER is
			--  Position of the beginning of the current selection highlightened
		do
			internal_action := True;
			Result := unexpanded_position (st_begin_of_selection);
			internal_action := False
		end;

	i_end_of_selection: INTEGER is
			--  Position of the end of the current selection highlightened
		do
			internal_action := True;
			Result := unexpanded_position (st_end_of_selection);
			internal_action := False
		end;
	
feature {NONE} -- Access

	tab_list: TWO_WAY_LIST [INTEGER];
			-- List of tabulations in the text. The last element stands for
			-- the end of text and the recorded integers are the number of
			-- characters between the current tab and its previous sibling

	last_unexp_position: INTEGER;
			-- Last unexpanded position computed

	last_exp_position: INTEGER;
			-- Last expanded position computed

	last_offset: INTEGER;
			-- Number of characters between the last position computed and the
			-- next tab (The next tab should be the current item of `tab_list')

feature {NONE} -- Conversion

	expanded_position (pos: INTEGER): INTEGER is
			-- Position in the text after tabulation expansion
		require
			valid_pos: pos >= 0 and pos <= i_count
		local
			offset, tab_nb: INTEGER
		do
			if pos >= last_unexp_position then
				from
					offset := pos - last_unexp_position
				until
					offset <= last_offset
				loop
					offset := offset - last_offset - 1;
					tab_list.forth; tab_nb := tab_nb + 1;
					last_offset := tab_list.item
				end;
				last_offset := last_offset - offset;
				offset := pos - last_unexp_position;
				last_unexp_position := pos;
				last_exp_position := last_exp_position + offset + 
													tab_nb * (tab_length - 1)
			else
				from
					offset := last_unexp_position - pos;
					last_offset := tab_list.item - last_offset
				until
					offset <= last_offset
				loop
					offset := offset - last_offset - 1;
					tab_list.back; tab_nb := tab_nb + 1;
					last_offset := tab_list.item
				end;
				last_offset := tab_list.item - last_offset + offset;
				offset := last_unexp_position - pos;
				last_unexp_position := pos;
				last_exp_position := last_exp_position - offset - 
													tab_nb * (tab_length -  1)
			end;
			Result := last_exp_position
debug ("TABULATION")
	io.error.putstring ("tabulations after `expanded_position': %N");
	tabulations_trace
end;
		ensure
			valid_result: Result >= 0 and Result <= st_count
		end;

	unexpanded_position (pos: INTEGER): INTEGER is
			-- Position in the text before tabulation expansion
		require
			valid_pos: pos >= 0 and pos <= st_count
		local
			offset, tab_nb: INTEGER
		do
			if pos >= last_exp_position then
				from
					offset := pos - last_exp_position
				until
					offset <= last_offset + tab_length - 1
				loop
					offset := offset - last_offset - tab_length;
					tab_list.forth; tab_nb := tab_nb + 1;
					last_offset := tab_list.item
				end;
				last_offset := last_offset - offset;
				offset := pos - last_exp_position;
				last_exp_position := pos;
				last_unexp_position := last_unexp_position + offset - 
													tab_nb * (tab_length - 1);
				if last_offset < 0 then
						-- In a middle of a tab. Set position to the beginning
						-- of the tab.
					last_exp_position := last_exp_position + last_offset;
					last_unexp_position := last_unexp_position + last_offset;
					last_offset := 0
				end
			else
				from
					offset := last_exp_position - pos;
					last_offset := tab_list.item - last_offset
				until
					offset <= last_offset
				loop
					offset := offset - last_offset - tab_length;
					tab_list.back; tab_nb := tab_nb + 1;
					last_offset := tab_list.item
				end;
				last_offset := tab_list.item - last_offset + offset;
				offset := last_exp_position - pos;
				last_exp_position := pos;
				last_unexp_position := last_unexp_position - offset + 
													tab_nb * (tab_length -  1);
				if last_offset < 0 then
						-- In a middle of a tab. Set position to the beginning
						-- of the tab.
					last_exp_position := last_exp_position + last_offset;
					last_unexp_position := last_unexp_position + last_offset;
					last_offset := 0
				end
			end;
			Result := last_unexp_position
debug ("TABULATION")
	io.error.putstring ("tabulations after `unexpanded_position': %N");
	tabulations_trace
end;
		ensure
			valid_result: Result >= 0 and Result <= i_count
		end;

feature {NONE} -- Default callbacks

	add_callbacks is
			-- Set the default callbacks.
		do
			add_modify_action (Current, modify_event);
			add_motion_action (Current, motion_event);
		end;

	modify_event, motion_event: ANY is
			-- Event used for the call backs.
		once
			!! Result
		end;

	context_data_useful: BOOLEAN is True;

	internal_action, in_execute: BOOLEAN;

	execute (argument: ANY) is
			-- Execute the command.
		local
			motion_data: MOTION_DATA;
			modify_data: MODIFY_DATA;
			next_pos, cur_pos, u_cur_pos, u_next_pos: INTEGER
			start_pos, u_start_pos: INTEGER
			last_pos, u_last_pos: INTEGER;
			u_start_select_pos, u_last_select_pos: INTEGER;
			new_cur_pos, start_offset, i, tab_nb: INTEGER;
			new_text: STRING;
			step: INTEGER;

			clicked_type: INTEGER;
			cursor_x, cursor_y: INTEGER;
			start_posi: INTEGER
		do
print ("1%N")
			if not internal_action and not in_execute then
print ("2%N")
				in_execute := True;
				if argument = modify_event then
print ("in modify%N")
					modify_data ?= context_data;
					if modify_data /= Void then
						start_pos := modify_data.start_position;
						last_pos := modify_data.last_position;
						step := last_pos - start_pos;
						u_start_pos := unexpanded_position (start_pos);
						u_last_pos := unexpanded_position (last_pos);
						if 
							start_pos /= last_pos and 
							u_start_pos = u_last_pos 
						then
							u_last_pos := u_last_pos + 1
						end;
						start_pos := expanded_position (u_start_pos);
						start_offset := tab_list.item - last_offset;
						last_pos := expanded_position (u_last_pos);
						u_next_pos :=  u_start_pos + modify_data.text.count;
						tab_nb := (last_pos - start_pos - u_last_pos + 
											u_start_pos) // (tab_length - 1);
						new_text := modify_data.text;
						if not new_text.empty or (tab_nb = 1 and step = 1) then
--							disable_verify_bell;
							forbid_action;
--							enable_verify_bell;
							i_replace (u_start_pos, u_last_pos, new_text)
						else
								-- PB: the reverse video stays when we delete
								-- characters even after a `clear_selection'.
								-- When we replaced the selected text by other
								-- characters, the reverse video disappears.
							from 
								tab_list.put (last_offset + start_offset);
								last_unexp_position := last_unexp_position - 
													(u_last_pos - u_start_pos);
								last_exp_position := last_exp_position - 
														(last_pos - start_pos);
								i := 1 
							until 
								i > tab_nb 
							loop
								tab_list.remove_left
								i := i + 1
							end;
debug ("TABULATION")
	io.error.putstring ("tabulations after `delete or backspace': %N");
	tabulations_trace
end;
						end;
						if is_selection_active then
							clear_selection
						end;
						i_set_cursor_position (u_next_pos)
					end
				elseif argument = motion_event then
print ("in motio%N")
					motion_data ?= context_data;
					if motion_data /= Void then
						next_pos := motion_data.next_cursor_position;
						cur_pos := motion_data.current_cursor_position;
						if is_selection_active then
							u_start_select_pos := i_begin_of_selection;
							u_last_select_pos := i_end_of_selection;
							if next_pos > cur_pos then
								if 
									expanded_position (u_last_select_pos) /= 
									st_end_of_selection
								then
									-- We have some problem to span this tab.
									u_last_select_pos := u_last_select_pos + 1
								end
								if 
									expanded_position (u_start_select_pos) /= 
									st_begin_of_selection
								then
									-- We have some problem to span this tab.
									u_start_select_pos := u_start_select_pos + 1
								end
							end;
							clear_selection
						end;
--						disable_verify_bell;
						forbid_action;
--						enable_verify_bell;
						if u_start_select_pos /= u_last_select_pos then
							i_set_selection (u_start_select_pos,u_last_select_pos)
						end
						u_next_pos := unexpanded_position (next_pos);
						if 
							next_pos > cur_pos and 
							u_next_pos = unexpanded_position (cur_pos)
						then
								-- We have some problem to span this tab.
							i_set_cursor_position (u_next_pos + 1)
						else
							i_set_cursor_position (u_next_pos)
						end
					end
				end;
				in_execute := False
			end;
		end;

feature {NONE} -- Trace

	tabulations_trace is
			-- Display `tab_list'.
		local
			index: INTEGER
		do
			from
				index := tab_list.index;
				tab_list.start
			until
				tab_list.exhausted
			loop
				io.error.putint (tab_list.item);
				io.error.putstring (" ~ ");
				tab_list.forth
			end;
			tab_list.go_i_th (index);
			io.error.new_line;
			io.error.putstring ("tab nb : ");
			io.error.putint (tab_list.index);
			io.error.new_line;
			io.error.putstring ("exp pos : ");
			io.error.putint (last_exp_position);
			io.error.new_line;
			io.error.putstring ("unexp pos : ");
			io.error.putint (last_unexp_position);
			io.error.new_line;
			io.error.putstring ("offset : ");
			io.error.putint (last_offset);
			io.error.new_line
		end;

invariant

	eot_exists: tab_list.count >= 1

end -- class TABBED_TEXT_M


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
