--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

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
			go as list_go,
			back as list_back,
			forth as list_forth,
			wipe_out as list_wipe_out
		export
			{NONE} all;
			{ANY} offleft, isfirst, islast, count, position, first, last, i_th
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
			not_offleft: position > 0
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
			not_empty_nor_islast: count > 0 and then position < count
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
			(position >= 1) and (position <= count)
		end;

	go (i: INTEGER) is
			-- Move cursor to position `i'.
		require
			index_large_enough: i >= 0;
			index_small_enough: i <= count;
			not_zero_unless_empty: not empty or i = 0
		do
			if i > position then
				from
				until
					i = position
				loop
					list_forth;
					item.redo
				end
				elseif i < position then
				from
				until
					i = position
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
				history_windows.item.go (i);
				history_windows.forth
			end
		ensure
			position = i
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
			history_windows.remove_all_occurrences (history_window)
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

	not_offright_unless_empty: (not empty) implies (not offright)

end
