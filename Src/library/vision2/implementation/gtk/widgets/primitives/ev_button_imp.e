indexing
	description:
		"Eiffel Vision button. GTK implementation."
	status: "See notice at end of class"
	keywords: "press, push, label, pixmap"
	date: "$Date$"
	revision: "$Revision$"
        
class
	EV_BUTTON_IMP
        
inherit
	EV_BUTTON_I
		redefine
			interface
		end
        
	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			make
		end
 
	EV_PIXMAPABLE_IMP
		redefine
			set_pixmap,
			remove_pixmap,
			interface,
			initialize
		end
     
	EV_TEXTABLE_IMP
		redefine
			set_text,
			remove_text,
			interface,
			initialize
		end

--FIXME	EV_BAR_ITEM_IMP

create
        make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			set_c_object (C.gtk_button_new)
		end

	initialize is
			-- Set up action sequence connection and `Precursor' initialization,
			-- create button box to hold label and pixmap.
		do
			{EV_PRIMITIVE_IMP} Precursor
			pixmapable_imp_initialize
			textable_imp_initialize
			initialize_button_box
			connect_signal_to_actions ("clicked", interface.press_actions)
			is_initialized := True
			align_text_center
		end

	initialize_button_box is
			-- Create and initialize button box.
		local
			box: POINTER
		do
			box := C.gtk_hbox_new (False, 0)
			C.gtk_container_add (c_object, box)
			C.gtk_widget_show (box)
			C.gtk_box_pack_start (box, text_label, True, True, padding)
			C.gtk_widget_hide (text_label)
			C.gtk_box_pack_end (box, pixmap_box, True, False, padding)
			C.gtk_widget_hide (pixmap_box)
		ensure
			button_box /= default_pointer
		end
	
feature -- Element change

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
			--| Redefined because we want the text to be:
			--| 	- middle-aligned if there is no pixmap
			--| 	- left-aligned if there is a pixmap
		do
			if text = Void then
				C.gtk_box_set_child_packing (
					button_box,
					pixmap_box,
					False,      -- Don't expand box.
					False,
					padding,
					C.Gtk_pack_end_enum
				)
			end
			{EV_TEXTABLE_IMP} Precursor(a_text)
		end

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		do
			align_text_left
			{EV_PIXMAPABLE_IMP} Precursor (a_pixmap)
		end

	remove_text is
			-- Assign `Void' to text.
		do
			{EV_TEXTABLE_IMP} Precursor
			C.gtk_box_set_child_packing (
				button_box,
				pixmap_box,
				True,       -- Expand pixmap box.
				False,
				padding,
				C.Gtk_pack_end_enum
			)
		end

	remove_pixmap is
			-- Assign Void to `pixmap'.
		do
			{EV_PIXMAPABLE_IMP} Precursor
			C.gtk_widget_hide (pixmap_box)
			align_text_center
		end
	
feature {NONE} -- implementation

	padding: INTEGER is 3
			-- Number of pixels of extra space arround text and pixmap.

	button_box: POINTER is
			-- GtkHBox in button.
			-- Holds label and pixmap.
		do
			Result := C.gtk_container_children (c_object)
			Result := C.g_list_nth_data (Result, 0)
		end

feature {EV_ANY_I} -- implementation

	interface: EV_BUTTON
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	button_box_not_void: is_useable implies button_box /= Void

end -- class EV_BUTTON_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
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
--| Revision 1.27  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.26.6.27  2000/02/04 21:26:03  king
--| Removed hiding and showing of pix/text boxes as this is done in pix/textable_imp
--|
--| Revision 1.26.6.26  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.26.6.25  2000/02/02 18:52:42  oconnor
--| fixed text allignment bug
--|
--| Revision 1.26.6.24  2000/01/28 19:04:39  king
--| Changed to deal with initialize renaming in pixmapable and textable
--|
--| Revision 1.26.6.23  2000/01/27 19:29:45  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.26.6.22  2000/01/27 19:03:40  oconnor
--| use clicked signal instead of pressed for press_actions
--|
--| Revision 1.26.6.21  2000/01/18 23:43:13  oconnor
--| update for new EV_TEXTABLE_IMP that uses GtkLable directly
--|
--| Revision 1.26.6.20  2000/01/18 07:11:16  oconnor
--| comments
--|
--| Revision 1.26.6.19  2000/01/13 22:26:51  king
--| Removed setting of is_initialized to false
--|
--| Revision 1.26.6.18  2000/01/10 21:47:31  king
--| Removed label widget, set_pixmap and remove pixmap
--|
--| Revision 1.26.6.17  2000/01/07 23:32:00  king
--| Altered initialize to account for name change of ev_textable_imp_initialize
--|
--| Revision 1.26.6.16  2000/01/07 22:54:01  king
--| Changed implementation so button has its own hbox to hold label and pixmap
--|
--| Revision 1.26.6.15  1999/12/22 20:53:14  king
--| Tidied up code by removing create_pixmap_place
--| Removed references to foreground and background color
--| Correctly implemented pixmap routines
--|
--| Revision 1.26.6.14  1999/12/15 16:46:34  oconnor
--| formatting
--|
--| Revision 1.26.6.13  1999/12/13 20:02:20  oconnor
--| commented out broken inheritances
--|
--| Revision 1.26.6.12  1999/12/10 00:51:25  brendel
--| Cosmetics.
--|
--| Revision 1.26.6.11  1999/12/04 18:59:20  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.26.6.10  1999/12/03 18:59:32  oconnor
--| use new real_set_*_color features from EV_WIDGET_IMP
--|
--| Revision 1.26.6.9  1999/12/03 00:51:44  brendel
--| Added pressed_actions.
--|
--| Revision 1.26.6.8  1999/12/02 21:03:59  oconnor
--| use new connect_signal_to_actions from EV_ANY
--|
--| Revision 1.26.6.7  1999/12/02 08:02:18  oconnor
--| Changed set color features to pass 16 bit values to C externals.
--| Was wrongly passing 8 bit values.
--|
--| Revision 1.26.6.6  1999/12/01 01:02:33  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that relied on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.26.6.5  1999/11/30 23:14:20  oconnor
--| rename widget to c_object
--| redefine interface to be of mreo refined type
--|
--| Revision 1.26.6.4  1999/11/30 17:25:57  brendel
--| Added redefine of initialize from EV_TEXTABLE_IMP.
--|
--| Revision 1.26.6.3  1999/11/29 17:32:03  brendel
--| Uncommented event connection in `initialize'.
--|
--| Revision 1.26.6.2  1999/11/24 22:48:06  brendel
--| Just managed to compile figure cluster example.
--|
--| Revision 1.26.6.1  1999/11/24 00:01:28  oconnor
--| merged from REVIEW_BRANCH
--|
--| Revision 1.26.2.6  1999/11/23 22:59:25  oconnor
--| rearranged init sequence, see frozen default create in EV_ANY
--|
--| Revision 1.26.2.5  1999/11/18 03:40:42  oconnor
--| rewrote press command handling to use action sequence
--|
--| Revision 1.26.2.4  1999/11/17 01:53:04  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.26.2.3  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.26.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
