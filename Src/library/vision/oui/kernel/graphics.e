--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Parent of any graphic application.
-- Contains some global operations such as `set_global_cursor' or `show_tree'.

indexing

	date: "$Date$";
	revision: "$Revision$"

class GRAPHICS 

inherit

	G_ANY;

	W_MAN_GEN
		export
			{NONE} all
		end

feature 

	exit is
			-- Exit from the application.
		do
			toolkit.exit
		end;

	global_cursor: SCREEN_CURSOR is
			-- Global cursor for the whole application.
			-- Void if no global cursor has been defined
			-- with `set_global_cursor'.
		do
			Result := toolkit.global_cursor
		end;

	iterate is
			-- Loop the application.
		do
			toolkit.iterate
		end;

	restore_cursors is
			-- Restore the cursors as they were before `set_global_cursor'.
		require
--			a_global_cursor_set_before: not (global_cursor = Void)
		do
			toolkit.restore_cursors
		ensure
			no_global_cursor_anymore: (global_cursor = Void)
		end;

	set_global_cursor (cursor: SCREEN_CURSOR) is
			-- Set a global cursor for the whole application.
			-- Warning: the effect of calling `set_type' on a CURSOR or
			-- `set_cursor' on a WIDGET is not defined.
			-- It depends on the specific implementation.
		require
			a_cursor_exists: not (cursor = Void);
			--no_global_cursor_already_set: (global_cursor = Void)
		do
			toolkit.set_global_cursor (cursor)
		ensure
			correctly_set: global_cursor = cursor
		end; 

	show_tree (a_file: UNIX_FILE) is
			-- Print a textual representation of the widgets tree on `a_file'.
		require
			a_file_exists: not (a_file = Void);
			a_file_opened_for_writing: a_file.is_open_write
		do
			widget_manager.show_tree (a_file)
		end 

end 
