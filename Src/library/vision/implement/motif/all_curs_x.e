indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class ALL_CURS_X 

inherit

	W_MAN_GEN
		export
			{NONE} all
		end;

	G_ANY_I
		export
			{NONE} all
		end
	
feature 

	global_cursor: SCREEN_CURSOR;
			-- Global cursor for the whole application.
			-- Void if no global cursor has been defined
			-- with `set_global_cursor'.

	restore_cursors is
			-- Restore the cursors as they were before `set_global_cursors'.
		local
			widget_x: WIDGET_X;
			area: SPECIAL [WIDGET];
			count, i: INTEGER
		do
			area := widget_manager.area;
			count := widget_manager.count
			from
				i := 0
			until
				i >= count
			loop
				widget_x ?= area.item (i).implementation;
				widget_x.undefine_cursor_if_shell;
				if widget_x.cursor /= Void then
					widget_x.update_cursor
				end;
				i := i + 1
			end;
			global_cursor := Void
		ensure
			no_global_cursor_anymore: (global_cursor = Void)
		end;

	set_global_cursor (cursor: SCREEN_CURSOR) is
			-- Set a global cursor for the whole application.
			-- Warning: the effect of modifying a SCREEN_CURSOR class between
			-- `set_global_cursors' and `restore_global_cursors' is not defined.
			-- It depends on the specific implementation.
		require
			a_cursor_exists: cursor /= Void;
		local
			widget_x: WIDGET_X;
			area: SPECIAL [WIDGET];
			count, i: INTEGER
		do
			area := widget_manager.area;
			count := widget_manager.count
			from
				i := 0
			until
				i >= count
			loop
				widget_x ?= area.item (i).implementation;
				widget_x.define_cursor_if_shell (cursor);
				i := i + 1
			end;
			global_cursor := cursor
		ensure
			correctly_set: global_cursor = cursor
		end

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
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
