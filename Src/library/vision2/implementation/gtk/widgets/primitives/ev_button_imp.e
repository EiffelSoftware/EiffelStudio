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
			make,
			pointer_over_widget,
			set_foreground_color,
			foreground_color_pointer,
			visual_widget
		end
 
	EV_PIXMAPABLE_IMP
		redefine
			set_pixmap,
			remove_pixmap,
			interface,
			initialize,
			visual_widget
		end
     
	EV_TEXTABLE_IMP
		redefine
			set_text,
			remove_text,
			interface,
			initialize,
			visual_widget
		end

	EV_BUTTON_ACTION_SEQUENCES_IMP
		redefine
			interface,
			visual_widget
		end

create
        make

feature {NONE} -- Initialization

	button_widget: POINTER is
		-- Pointer to gtk*button as c_object is event box in check button.
		do
			Result := c_object
		end
	
	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			set_c_object (C.gtk_button_new)
		end

	initialize is
			-- `Precursor' initialization,
			-- create button box to hold label and pixmap.
		do
			{EV_PRIMITIVE_IMP} Precursor
			pixmapable_imp_initialize
			textable_imp_initialize
			initialize_button_box
			is_initialized := True
			align_text_center
		end

	initialize_button_box is
			-- Create and initialize button box.
		local
			box: POINTER
		do
			box := C.gtk_hbox_new (False, 0)
			C.gtk_container_add (button_widget, box)
			C.gtk_widget_show (box)
			C.gtk_box_pack_start (box, text_label, True, True, padding)
			C.gtk_widget_hide (text_label)
			C.gtk_box_pack_end (box, pixmap_box, True, False, padding)
			C.gtk_widget_hide (pixmap_box)
			--| FIXME IEK Remove magic numbers, have some standard for
			--| default minimum sizes of buttons.
			C.gtk_widget_set_usize (box, 0, 20)
		ensure
			button_box /= NULL
		end
	
feature -- Access

	is_default_push_button: BOOLEAN is
			-- Is this button currently a default push button 
			-- for a particular container?
		do
			Result := GTK_WIDGET_HAS_DEFAULT (button_widget)
		end

feature -- Status Setting

	enable_default_push_button is
			-- Set the style of the button corresponding
			-- to the default push button.
		do
			enable_can_default
			C.gtk_widget_grab_default (button_widget)
		end

	disable_default_push_button is
			-- Remove the style of the button corresponding
			-- to the default push button.
		local
			par_ptr: POINTER
		do
			GTK_WIDGET_UNSET_FLAGS (button_widget, C.GTK_HAS_DEFAULT_ENUM)
			C.gtk_widget_draw_default (button_widget)
			from
				par_ptr := C.gtk_widget_struct_parent (button_widget)
			until
				GTK_IS_WINDOW (par_ptr) or else par_ptr = NULL
			loop
				par_ptr := C.gtk_widget_struct_parent (par_ptr)
			end

			if par_ptr /= NULL then
				C.gtk_window_set_default (par_ptr, NULL)
			end			
		end

	enable_can_default is
			-- Allow the style of the button to be the default push button.
		do
			GTK_WIDGET_SET_FLAGS (button_widget, C.GTK_CAN_DEFAULT_ENUM)
		end

	set_foreground_color (a_color: EV_COLOR) is
		do
			real_set_foreground_color (text_label, a_color)
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
			{EV_TEXTABLE_IMP} Precursor (a_text)
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

feature {EV_APPLICATION_IMP} -- Implementation

	pointer_over_widget (a_gdkwin: POINTER; a_x, a_y: INTEGER): BOOLEAN is
			-- Comparison of gdk window and widget position to determine
			-- if mouse pointer is over widget.
		local
			a_gtk_pix: POINTER
		do
			if is_displayed then
				Result := Precursor (a_gdkwin, a_x, a_y)
				if not Result then
					a_gtk_pix := gtk_pixmap
					if a_gtk_pix /= NULL then
						-- No struct member call if gtk_pix is a NULL pointer.
						Result := a_gdkwin = C.gtk_widget_struct_window (a_gtk_pix)
					end
				end
			end
		end
	
feature {NONE} -- implementation

	foreground_color_pointer: POINTER is
		do
			Result := C.gtk_style_struct_fg (
				C.gtk_widget_struct_style (text_label)
			)
		end

	padding: INTEGER is 3
			-- Number of pixels of extra space arround text and pixmap.

	button_box: POINTER is
			-- GtkHBox in button.
			-- Holds label and pixmap.
		do
			Result := C.gtk_container_children (button_widget)
			Result := C.g_list_nth_data (Result, 0)
		end

	visual_widget: POINTER is
		do
			Result := button_widget
		end

feature {NONE} -- Externals

	gtk_is_window (a_widget: POINTER): BOOLEAN is
		external
			"C [macro <gtk/gtk.h>]: EIF_BOOLEAN"
		alias
			"GTK_IS_WINDOW"
		end

	gtk_widget_can_default (a_widget: POINTER): BOOLEAN is
		external
			"C [macro <gtk/gtk.h>]: EIF_BOOLEAN"
		alias
			"GTK_WIDGET_CAN_DEFAULT"
		end

	gtk_widget_has_default (a_widget: POINTER): BOOLEAN is
		external
			"C [macro <gtk/gtk.h>]: EIF_BOOLEAN"
		alias
			"GTK_WIDGET_HAS_DEFAULT"
		end

feature {EV_ANY_I} -- implementation

	interface: EV_BUTTON
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	button_box_not_void: is_usable implies button_box /= Void

end -- class EV_BUTTON_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.40  2001/07/14 12:46:23  manus
--| Replace --! by --|
--|
--| Revision 1.39  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.38  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.26.4.19  2001/04/17 17:04:29  king
--| Optimized pointer_over_widget
--|
--| Revision 1.26.4.18  2001/02/16 00:25:31  rogers
--| Replaced useable with usable.
--|
--| Revision 1.26.4.17  2000/10/27 16:54:43  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.26.4.16  2000/10/07 00:08:08  andrew
--| Redefining visual_widget to return button_widget
--|
--| Revision 1.26.4.15  2000/08/23 00:33:38  king
--| Moved macros up to widget_imp
--|
--| Revision 1.26.4.14  2000/08/16 18:44:01  king
--| Corrected set_foreground functionality
--|
--| Revision 1.26.4.13  2000/08/08 00:03:15  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.26.4.12  2000/07/24 21:36:10  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.26.4.11  2000/07/05 23:57:49  king
--| Removed obscure fixme
--|
--| Revision 1.26.4.10  2000/06/22 22:13:54  king
--| Correctly implemented disable_default_push_button
--|
--| Revision 1.26.4.8  2000/06/15 21:18:03  king
--| Made button_widget a function to return c_object for previous compatibility
--|
--| Revision 1.26.4.7  2000/06/15 19:06:58  king
--| routines now call button_widget instead of c_object
--|
--| Revision 1.26.4.6  2000/06/01 22:04:32  king
--| Implemented pointer_over_widget to deal with pixmap
--|
--| Revision 1.26.4.5  2000/05/05 23:21:59  king
--| Added feature clause to default push button externals
--|
--| Revision 1.26.4.4  2000/05/04 18:34:07  king
--| Setting min size for vbox for default style
--|
--| Revision 1.26.4.3  2000/05/04 00:16:48  king
--| Implemented enable_can_default
--|
--| Revision 1.26.4.2  2000/05/03 22:22:55  king
--| Merged with devel branch from head
--|
--| Revision 1.35  2000/05/03 18:19:07  king
--| Added push button style implementation
--|
--| Revision 1.34  2000/05/03 02:28:10  bonnard
--| Fixed "default_button" features so they do not trigger assertion violations.
--| Features still have to be implemented.
--|
--| Revision 1.33  2000/05/02 18:55:30  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.32  2000/04/29 03:16:08  pichery
--| Added feature `is_default_push_button',
--| `enable/disable_push_button'
--| Need to be implemented
--|
--| Revision 1.31  2000/04/20 00:28:41  oconnor
--| fixed signal connection
--|
--| Revision 1.30  2000/04/04 20:51:57  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.29  2000/03/22 23:53:18  brendel
--| Replaced obsolete call.
--|
--| Revision 1.28  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.27  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.26.6.27  2000/02/04 21:26:03  king
--| Removed hiding and showing of pix/text boxes as this is done in
--| pix/textable_imp
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
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that
--| relied on specific things like return value BOOLEAN instead of INTEGER.
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
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
