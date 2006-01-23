indexing

	description:
		"EiffelVision Implementation of global cursor."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class ALL_CURS_X 

inherit

	W_MAN_GEN
		export
			{NONE} all
		end;

	G_ANY_I

feature -- Access

	global_cursor: SCREEN_CURSOR;
			-- Global cursor for the whole application.
			-- Void if no global cursor has been defined
			-- with `set_global_cursor'.

feature -- Element change

	restore_cursors is
			-- Restore the cursors as they were before `set_global_cursors'.
		local
			widget_m: WIDGET_IMP;
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
				widget_m ?= area.item (i).implementation;
				widget_m.undefine_cursor_if_shell;
				if widget_m.cursor /= Void then
					widget_m.update_cursor;
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
			widget_m: WIDGET_IMP;
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
				widget_m ?= area.item (i).implementation;
				widget_m.define_cursor_if_shell (cursor);
				i := i + 1
			end;
			global_cursor := cursor
		ensure
			correctly_set: global_cursor = cursor
		end

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




end -- class ALL_CURS_X


