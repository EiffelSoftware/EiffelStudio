indexing

	description:
		"Graphic history based on a linear list of undoable commands, represented on %
		%screen with a popup containing a scroll list to show the previous commands %
		%names, and buttons to undo and redo commands";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	HISTORY_LIST 

inherit
	HISTORY
		undefine
			copy, is_equal
		end

	LINKED_LIST [UNDOABLE]
		rename
			make as linked_list_make,
			go_i_th as list_go_i_th,
			back as list_back,
			forth as list_forth,
			wipe_out as list_wipe_out
		export
			{NONE} all;
			{ANY} off, after, before, isfirst, islast, count, index, first, last, i_th, is_empty
		end

creation
	make

feature -- Initialization

	make is
			-- Create a history based on a list.
		do
			linked_list_make;
			!! history_windows.make
		end;

feature -- Cursor movement

	back is
			-- Move cursor backward one position.
		require
			not_off: not off
		do
			item.undo;
			list_back;
			from
				history_windows.start
			until
				history_windows.after
			loop
				history_windows.item.back;
				history_windows.forth
			end
		ensure
			index = old index - 1
		end;

	forth is
			-- Move cursor forward one position.
		require
			not_after: not after
		do
			list_forth;
			item.redo;
			from
				history_windows.start
			until
				history_windows.after
			loop
				history_windows.item.forth;
				history_windows.forth
			end
		ensure
			(index >= 1) and (index <= count)
		end;

	go_i_th (i: INTEGER) is
			-- Move cursor to position `i'.
		require
			index_large_enough: i >= 0;
			index_small_enough: i <= count;
			not_zero_unless_empty: not is_empty or i = 0
		do
			if i > index then
				from
				until
					i = index
				loop
					list_forth;
					item.redo
				end
			elseif i < index then
				from
				until
					i = index
				loop
					item.undo;
					list_back
				end
			end;
			from
				history_windows.start
			until
				history_windows.after
			loop
				history_windows.item.go_i_th (i);
				history_windows.forth
			end
		ensure
			index = i
		end;

feature -- Element change

	record (a_command: UNDOABLE) is
			-- Insert `a_command' after the cursor position, and place
			-- cursor upon it
		do
			put_right (a_command);
			list_forth;
			from
				history_windows.start
			until
				history_windows.after
			loop
				history_windows.item.record (a_command);
				history_windows.forth
			end
		end;

feature -- Removal

	remove_after is
			-- Remove all commands after the cursor position.
		local
			i, n: INTEGER
		do
			if (not islast) and (not is_empty) then
				from
					n := count-index
					i := 1
				until
					islast or else (i > n)
				loop
					from
						history_windows.start
					until
						history_windows.after
					loop
						history_windows.item.remove_after;
						history_windows.forth
					end;
					remove_right;
					i := i + 1
				end
				from
					history_windows.start
				until
					history_windows.after
				loop
					history_windows.item.update_widgets;
					history_windows.forth
				end;
			end
		ensure
			islast_unless_empty: (not is_empty) implies islast
		end;

	wipe_out is
			-- Make history empty.
		do
			list_wipe_out;
			from
				history_windows.start
			until
				history_windows.off
			loop
				history_windows.item.wipe_out;
				history_windows.forth
			end
		end;

feature {HISTORY_L_W} -- Implementation

	history_windows: LINKED_LIST [HISTORY_L_W];
			-- List of popup windows representing current history

	add_history_window (history_window: HISTORY_L_W) is
			-- Add `history_window' to the list of the current history.
		require
			history_window_not_void: history_window /= Void
		do
			history_windows.finish;
			history_windows.put_right (history_window)
		end;

	remove_history_window (history_window: HISTORY_L_W) is
			-- Remove `history_window' to the list of the current history.
		require
			history_window_not_void: history_window /= Void
		do
			history_windows.start;
			history_windows.prune (history_window)
		end;

end -- class HISTORY_LIST


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

