indexing

	description: 
		"Graphic history based on a linear list of undoable commands, represented on %
		%screen with a popup containing a scroll list to show the previous commands %
		%names, and buttons to undo and redo commands";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	HISTORY_L_W 

inherit

	FORM_D
		rename
			make as form_d_make
		end

creation

	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: COMPOSITE) is
			-- Create a graphic representation of the history.
		require
			name_not_void: a_name /= Void;
			parent_not_void: a_parent /= Void
		do
			form_d_make (a_name, a_parent);
			set_size (200,200);
			set_fraction_base (3);
			!! scroll_list.make ("list", Current);
			!! undo_button.make ("undo", Current);
			!! redo_button.make ("redo", Current);
			!! close_button.make ("close", Current);
			attach_top (scroll_list, 5);
			attach_left (scroll_list, 5);
			attach_right (scroll_list, 5);
			attach_bottom_widget (undo_button, scroll_list, 5);
			detach_top (undo_button);
			attach_left (undo_button, 5);
			attach_right_position (undo_button, 1);
			attach_bottom (undo_button, 5);
			detach_top (redo_button);
			attach_left_widget (undo_button, redo_button, 5);
			attach_right_position (redo_button, 2);
			attach_bottom (redo_button, 5);
			detach_top (close_button);
			attach_left_widget (redo_button, close_button, 5);
			attach_right (close_button, 5);
			attach_bottom (close_button, 5);
			scroll_list.set_single_selection;
			undo_button.set_text ("Undo");
			redo_button.set_text ("Redo");
			close_button.set_text ("Close");
			undo_button.add_activate_action (undo_command, Current);
			redo_button.add_activate_action (redo_command, Current);
			close_button.add_activate_action (close_commmand, Current);
			scroll_list.add_click_action (click_command, Current);
			scroll_list.start;
			update_widgets;
		end;

feature -- Access

	history_list: HISTORY_LIST;
			-- History based on a list currently associated

feature -- Element change

	set_history_list (a_history_list: HISTORY_LIST) is
			-- Set the `history_list' to `a_history_list'.
		local
			i: INTEGER
		do
			if history_list /= Void then
				history_list.remove_history_window (Current)
			end;
			history_list := a_history_list;
			scroll_list.wipe_out;
			if history_list /= Void then
				history_list.add_history_window (Current);
				from
					i := 1
				until
					i > history_list.count
				loop
					scroll_list.extend (history_list.i_th (i));
					i := i+1
				end;
				if not scroll_list.is_empty then
					scroll_list.set_visible_item_count (scroll_list.count)
				end;
				scroll_list.go_i_th (scroll_list.index);
				update_widgets
			end
		end;

feature {HISTORY_LIST} -- Implementation

	back is
			-- Move cursor backward one position.
		do
			if not scroll_list.off then
				scroll_list.deselect_item;
			end;
			scroll_list.back;
			update_widgets
		end;

	forth is
			-- Move cursor forward one position.
		do
			if not scroll_list.off then
				scroll_list.deselect_item
			end;
			scroll_list.forth;
			update_widgets
		end;

	go_i_th (i: INTEGER) is
			-- Move cursor to position `i'.
		do
			if not scroll_list.off then
				scroll_list.deselect_item;
			end;
			scroll_list.go_i_th (i);
			update_widgets
		end;

feature {HISTORY_LIST}

	record (a_command: UNDOABLE) is
			-- Insert `a_command' after the cursor position, and place
			-- cursor upon it
		do
			if not scroll_list.off then
				scroll_list.deselect_item;
			end;
			scroll_list.put_right (a_command);
			scroll_list.forth;
			update_widgets
		end;

	remove_after is
			-- Remove all commands after the cursor position.
		do
			scroll_list.remove_right
		end;

	wipe_out is
			-- Make history empty.
		do
			scroll_list.wipe_out;
			update_widgets
		end;

	update_widgets is
			-- Update the state of different widgets (scroll list, buttons).
		do
			if not scroll_list.off then
				scroll_list.scroll_to_current;
				scroll_list.select_item
			end;
			if scroll_list.before then
				undo_button.set_insensitive
			else
				undo_button.set_sensitive
			end;
			if scroll_list.islast or scroll_list.is_empty then
				redo_button.set_insensitive 
			else
				redo_button.set_sensitive 
			end
		end;

feature {NONE} -- Implementation

	redo_button: PUSH_B;
			-- Button to redo a command

	scroll_list: SCROLLABLE_LIST;
			-- Scroll list to show command names.

	undo_button: PUSH_B;
			-- Button to undo a command

	undo_command: HISTORY_UNDO is
			-- Command associated with the `undo' button.
		once
			!! Result
		end;

	redo_command: HISTORY_REDO is
			-- Command associated with the `redo' button.
		once
			!! Result
		end;

	click_command: HISTORY_CLCK is
			-- Command associated with a direct click in the scroll list.
		once
			!! Result
		end;

	close_button: PUSH_B;
			-- Button to close the history window

	close_commmand: POPDOWN_COM is
			-- Command associated with the `close' button.
		once
			!! Result
		end;

invariant

	valid_history: (history_list /= Void) implies ((history_list.count = scroll_list.count)
			and (history_list.index = scroll_list.index ))

end -- class HISTORY_L_W


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

