indexing

	description: 
		"Motif Eiffel Library widget manager.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_WIDGET_MANAGER

inherit

	ANY
		undefine
			is_equal, copy, setup, consistent
		end;

	HASH_TABLE [MEL_OBJECT, POINTER]
		rename
			make as hash_table_make
		export
			{NONE} put
		end

creation 
	make

feature {NONE} -- Initialization

	make is
			-- Create a widget manager.
		do
			hash_table_make (0)
		end;

feature -- Miscellaneous

	add (a_widget: MEL_OBJECT) is
			-- Add `a_widget' to the manager.
		require
			widget_not_null: a_widget /= Void;
			not_destroyed: not a_widget.is_destroyed;
			parent_set: a_widget.parent /= Void;
			has_parent: has (a_widget.parent.screen_object);
			not_added: not has (a_widget.screen_object);
		do
			put (a_widget, a_widget.screen_object)
		ensure
			has_widget: has (a_widget.screen_object)
		end;

	add_popup_shell (a_popup: MEL_SHELL) is
			-- Add a popup shell `a_shell' to the manager.
		require
			widget_not_null: a_popup /= Void;
			not_destroyed: not a_popup.is_destroyed;
			parent_set: a_popup.parent /= Void;
			has_parent: has (a_popup.parent.screen_object);
			not_added: not has (a_popup.screen_object);
		local
			a_parent: MEL_COMPOSITE
		do
			a_popup.parent.add_popup_child (a_popup);
			put (a_popup, a_popup.screen_object)
		ensure
			has_widget: has (a_popup.screen_object);
			has_popup_child: a_popup.parent.mel_popup_children.has (a_popup)
		end;

	add_without_parent (a_widget: MEL_OBJECT) is
			-- Add `a_widget' to the manager without
			-- checking the consistency of the `a_widget' parent.
		require
			widget_not_null: a_widget /= Void;
			not_destroyed: not a_widget.is_destroyed;
			not_added: not has (a_widget.screen_object)
		do
			put (a_widget, a_widget.screen_object)
		ensure
			has_widget: has (a_widget.screen_object)
		end;

	window_to_widget (a_display: POINTER; a_window: POINTER): MEL_WIDGET is
			-- Mel widget associated with window `a_window' in
			-- display 	`a_display' (Useful in MEL_EVENTS or external
			-- routines returning window identifier instead of a
			-- widget handle.)
		require
			a_display_not_null: a_display /= default_pointer;
			a_window_not_null: a_window /= default_pointer
		local
			w: POINTER
		do
			w := xt_window_to_widget (a_display, a_window);
			if w /= default_pointer then
				Result ?= item (w)
			end
		end;

    xt_window_to_widget (a_display, a_window: POINTER): POINTER is
        external
            "C (Display *, Window): EIF_POINTER | <X11/Intrinsic.h>"
        alias
            "XtWindowToWidget"
        end;

end -- class MEL_WIDGET_MANAGER


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

