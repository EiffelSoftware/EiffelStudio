
-- Graphic history based on a linear list of undoable commands, represented on
-- screen with a popup containing a scroll list to show the previous commands
-- names, and buttons to undo and redo commands.

indexing

	date: "$Date$";
	revision: "$Revision$"

class HISTORY_LIST 

inherit

	HISTORY;

	LINKED_LIST [UNDOABLE]
		rename
			make as linked_list_make,
			go_i_th as list_go_i_th,
			back as list_back,
			forth as list_forth,
			wipe_out as list_wipe_out
		export
			{NONE} all;
			{ANY} before, isfirst, islast, count, index, first, last, i_th, empty
		end

creation

	make

feature -- Creation

    make is
            -- Create a history based on a list.
        do
			linked_list_make;
            !! history_windows.make
        end;

feature {HISTORY_L_W}

	add_history_window (history_window: HISTORY_L_W) is
			-- Add `history_window' to the list of the current history.
		require
			not (history_window = Void)
		do
			history_windows.finish;
			history_windows.add_right (history_window)
		end;

feature 

	back is
			-- Move cursor backward one position.
		require
			not_offleft: index > 0
		do
			item.undo;
			list_back;
			from
				history_windows.start
			until
				history_windows.off
			loop
				history_windows.item.back;
				history_windows.forth
			end
		ensure
--			position = old position - 1
		end;

	forth is
			-- Move cursor forward one position.
		require
			not_empty_nor_islast: count > 0 and then index < count
		do
			list_forth;
			item.redo;
			from
				history_windows.start
			until
				history_windows.off
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
			not_zero_unless_empty: not empty or i = 0
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
				history_windows.off
			loop
				history_windows.item.go_i_th (i);
				history_windows.forth
			end
		ensure
			index = i
		end;

feature {NONE}

	history_windows: LINKED_LIST [HISTORY_L_W];
			-- List of popup windows representing current history

feature 

	record (a_command: UNDOABLE) is
			-- Insert `a_command' after the cursor position, and place
			-- cursor upon it
		do
			put_right (a_command);
			list_forth;
			from
				history_windows.start
			until
				history_windows.off
			loop
				history_windows.item.record (a_command.n_ame);
				history_windows.forth
			end
		end;

	remove_after is
			-- Remove all commands after the cursor position.
		do
			if (not islast) and (not empty) then
				remove_n_right (count-position);
				from
					history_windows.start
				until
					history_windows.off
				loop
					history_windows.item.remove_after;
					history_windows.forth
				end
			end
		ensure
			islast_unless_empty: (not empty) implies islast
		end;

feature {HISTORY_L_W}

	remove_history_window (history_window: HISTORY_L_W) is
			-- Remove `history_window' to the list of the current history.
		require
			not (history_window = Void)
		do
			-- not currently implemented
		end;

feature 

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

invariant

	not_offright_unless_empty: (not empty) implies (not after)

end


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
