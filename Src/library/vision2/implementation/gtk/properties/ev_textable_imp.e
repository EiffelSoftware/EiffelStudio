indexing
	description: 
		"Eiffel Vision textable. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE_IMP
	
inherit
	EV_TEXTABLE_I
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end
	
feature {NONE} -- Initialization
	
	textable_imp_initialize is
			-- Create a GtkLabel to display the text.
		do
			text_label := C.gtk_label_new (eiffel_to_c (""))
			C.gtk_widget_show (text_label)
			C.gtk_misc_set_alignment (text_label, 0.0, 0.5)
		end

feature -- Access

	text: STRING is
			-- Text of the label
		local
			p: POINTER
		do
			p := text_label
			C.gtk_label_get (text_label, $p)
			if p /= NULL then
				create Result.make_from_c (p)
				if Result.is_empty then
					Result := Void
				end
			end
		end

	alignment: EV_TEXT_ALIGNMENT is
			-- Alignment of the text in the label.
		local
			an_alignment_code: INTEGER
		do
			an_alignment_code := C.gtk_label_struct_jtype (text_label)
			if an_alignment_code = C.Gtk_justify_center_enum then
				create Result.make_with_center_alignment
			elseif an_alignment_code = C.Gtk_justify_left_enum then
				create Result.make_with_left_alignment
			elseif an_alignment_code = C.Gtk_justify_right_enum then
				create Result.make_with_right_alignment
			else
				check alignment_code_not_set: False end
			end
		end
	
feature -- Status setting

	align_text_center is
			-- Display `text' centered.
		do
			C.gtk_misc_set_alignment (text_label, 0.5, 0.5)
			C.gtk_label_set_justify (text_label, C.Gtk_justify_center_enum)
		end

	align_text_left is
			-- Display `text' left aligned.
		do
			C.gtk_misc_set_alignment (text_label, 0, 0.5)
			C.gtk_label_set_justify (text_label, C.Gtk_justify_left_enum)
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			C.gtk_misc_set_alignment (text_label, 1, 0.5)
			C.gtk_label_set_justify (text_label, C.Gtk_justify_right_enum)
		end
	
feature -- Element change	
	
	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			C.gtk_widget_show (text_label)
			C.gtk_label_set_text (text_label, eiffel_to_c (a_text))
		end

	remove_text is
			-- Assign `Void' to `text'.
		do
			C.gtk_label_set_text (text_label, NULL)
			C.gtk_widget_hide (text_label)
		end
	
feature {EV_ANY_IMP} -- Implementation
	
	text_label: POINTER
			-- GtkLabel containing `text'.

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXTABLE

invariant
	text_label_not_void: is_usable implies text_label /= Void

end -- class EV_TEXTABLE_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.27  2001/06/07 23:08:04  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.19.4.5  2001/05/10 22:31:38  king
--| Changed text_label export for tree implementation
--|
--| Revision 1.19.4.4  2001/02/16 00:31:27  rogers
--| Replaced is_useable with is_usable.
--|
--| Revision 1.19.4.3  2000/12/15 19:39:59  king
--| Changed .empty to .is_empty
--|
--| Revision 1.19.4.2  2000/08/24 23:55:05  king
--| Implemented alignment
--|
--| Revision 1.19.4.1  2000/05/03 19:08:41  oconnor
--| mergred from HEAD
--|
--| Revision 1.26  2000/05/02 18:55:23  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.25  2000/03/27 18:03:28  brendel
--| Removed unused local variable.
--|
--| Revision 1.24  2000/03/03 20:09:11  king
--| Corrected incorrect equivalence of pointer to void
--|
--| Revision 1.23  2000/03/01 03:17:08  oconnor
--| reverted last commit which was in error
--|
--| Revision 1.21  2000/02/22 18:39:36  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.20  2000/02/14 11:40:28  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.19.6.20  2000/02/04 21:23:40  king
--| Now showing and hiding text label on set/remove text
--|
--| Revision 1.19.6.19  2000/02/04 06:31:50  oconnor
--| fixed allignment
--|
--| Revision 1.19.6.18  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.19.6.17  2000/01/28 19:00:16  king
--| Altered name of initialize to deal with problems of precursor in descendants
--|
--| Revision 1.19.6.16  2000/01/27 19:29:32  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.19.6.15  2000/01/19 08:06:52  oconnor
--| added is_initialized := True to initialize
--|
--| Revision 1.19.6.14  2000/01/18 23:42:19  oconnor
--| use GtkLabel directly instead of packing it in a box
--|
--| Revision 1.19.6.13  2000/01/18 19:33:29  oconnor
--| Removed inheritance of fontable,
--| ont all texables are actualy fontable as well,
--| those that are should now inherit fontable explicitly.
--|
--| Revision 1.19.6.12  2000/01/14 23:36:35  king
--| Removed text_box_parented invariant as this conflicts with ev_label_imp
--|
--| Revision 1.19.6.11  2000/01/10 21:45:13  king
--| Set initialized to true in initialize
--|
--| Revision 1.19.6.10  2000/01/07 23:30:53  king
--| Changed ev_textable_imp_initialize back to initialize
--|
--| Revision 1.19.6.9  2000/01/07 22:48:42  king
--| Corrected text function, changed text_label so it uses local variable for
--| pointer
--|
--| Revision 1.19.6.8  2000/01/07 16:50:54  oconnor
--| cleaned up to match new _I
--|
--| Revision 1.19.6.7  1999/12/04 18:59:13  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.19.6.6  1999/11/30 22:57:02  oconnor
--| removed STRING.to_c style, use eiffel_to_c instead
--|
--| Revision 1.19.6.5  1999/11/30 22:08:00  brendel
--| Changed back the initialize stuuf, but renamed initialize_text_box as
--| ev_textable_imp_initialize.
--|
--| Revision 1.19.6.4  1999/11/30 17:27:04  brendel
--| "renamed" initialize_text_box to initialize. Declared old one obsolete.
--|
--| Revision 1.19.6.3  1999/11/29 17:24:48  brendel
--| Undone changes to previous version. Uncommented statements with `box' in
--| them.
--|
--| Revision 1.19.6.2  1999/11/24 22:48:06  brendel
--| Just managed to compile figure cluster example.
--|
--| Revision 1.19.6.1  1999/11/24 17:29:47  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.19.2.4  1999/11/17 01:53:01  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.19.2.3  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.19.2.2  1999/11/02 17:20:03  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
