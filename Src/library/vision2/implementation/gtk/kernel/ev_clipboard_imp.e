indexing
	description: "Objects that allow access to the operating %N%
	%system clipboard."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CLIPBOARD_IMP

inherit
	EV_CLIPBOARD_I
		redefine
			interface
		end

	EV_ANY_IMP
		rename
			c_object as clipboard_widget
		redefine
			interface
		end
create
	make

feature {NONE}-- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			set_c_object (C.gtk_text_new (NULL, NULL))
		end

	initialize is
			-- initialize `Current'.
		do
			C.gtk_container_add (default_window_imp.hbox, clipboard_widget)
			C.gtk_widget_show (clipboard_widget)
			is_initialized := True
		end

feature -- Access

	text: STRING is
			-- `Result' is current clipboard content.
		local
			a_success: INTEGER
			a_gs1, a_gs2: GEL_STRING
			edit_chars: POINTER
		do
			create a_gs1.make ("CLIPBOARD")
			create a_gs2.make ("COMPOUND_TEXT")
			a_success := C.gtk_selection_convert (
				clipboard_widget,
				C.gdk_atom_intern (a_gs1.item, 0),
				C.gdk_atom_intern (a_gs2.item, 0),
				C.GDK_CURRENT_TIME
			)
			edit_chars := C.gtk_editable_get_chars (clipboard_widget, 0, -1)
			create Result.make_from_c (edit_chars)
			C.g_free (edit_chars)
		end

feature -- Status Setting

	set_text (a_text: STRING) is
			-- Assign `a_text' to clipboard.
		local
			a_success: INTEGER
			clip_text: STRING
			a_gs: GEL_STRING
		do
			if a_text /= Void then
				clip_text := a_text
			else
				clip_text := ""
			end
			create a_gs.make (clip_text)
			C.gtk_text_set_point (clipboard_widget, 0)
			a_success := C.gtk_text_forward_delete (clipboard_widget, C.gtk_text_get_length (clipboard_widget))
			C.gtk_text_insert (clipboard_widget, NULL, NULL, NULL, a_gs.item, -1)
			C.gtk_editable_select_region (clipboard_widget, 0, -1)
			
			create a_gs.make ("CLIPBOARD")
     		a_success := C.gtk_selection_owner_set (
				clipboard_widget,
				C.gdk_atom_intern (a_gs.item, 0),
 				C.GDK_CURRENT_TIME
			)
		end

feature {EV_ANY_I}

	interface: EV_CLIPBOARD
		-- Interface of `Current'

end -- class EV_CLIPBOARD_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

