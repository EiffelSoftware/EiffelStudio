indexing
	description: "Eiffel Vision radio button. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
		
class
	EV_RADIO_BUTTON_IMP

inherit
	EV_RADIO_BUTTON_I
		redefine
			interface
		end
	
	EV_BUTTON_IMP
		export
			{NONE}
				c_object
		redefine
			interface,
			make,
			initialize,
			button_widget
		end

	EV_RADIO_PEER_IMP
		undefine
			visual_widget
		redefine
			interface, widget_object
		end

create
	make

feature {NONE} -- Initialization

        make (an_interface: like interface) is
                        -- Create radio button.
		do
			base_make (an_interface)
			set_c_object (C.gtk_event_box_new)
			button_widget := C.gtk_radio_button_new (NULL)
			C.gtk_widget_show (button_widget)
			C.gtk_container_add (c_object, button_widget)
                end

	initialize is
		do
			Precursor
			align_text_left
		end

feature {EV_CONTAINER_IMP} -- Access

	button_widget: POINTER
			-- Pointer to the gtkbutton widget as c_object is event box.

feature -- Status report
	
	is_selected: BOOLEAN is
			-- Is toggle button pressed?
		do
			Result := C.gtk_toggle_button_get_active (button_widget)
		end 
	
feature -- Status setting

	enable_select is
			-- Set `is_selected' `True'.
		do
			C.gtk_toggle_button_set_active (button_widget, True)
		end

feature {EV_ANY_I} -- Implementation

	widget_object (a_list: POINTER): POINTER is
			-- Returns the c_object of the radio item in `a_list'.
		local
			item_ptr: POINTER
		do
			item_ptr := C.gslist_struct_data (a_list)
			Result := C.gtk_widget_struct_parent (item_ptr)
		end

	radio_group: POINTER is
		do
			Result := C.gtk_radio_button_group (button_widget)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_RADIO_BUTTON

end -- class EV_RADIO_BUTTON_IMP

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
--| Revision 1.25  2001/07/14 12:46:23  manus
--| Replace --! by --|
--|
--| Revision 1.24  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.23  2001/06/07 23:08:07  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.12.4.12  2000/10/27 16:54:44  manus
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
--| Revision 1.12.4.11  2000/10/07 00:08:58  andrew
--| Undefining visual_widget
--|
--| Revision 1.12.4.10  2000/08/08 00:03:15  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.12.4.9  2000/06/16 00:02:41  king
--| Introduced event box to handle events
--|
--| Revision 1.12.4.8  2000/06/15 21:19:33  king
--| Redefined button_widget to an attribute to return gtkwidget
--|
--| Revision 1.12.4.7  2000/06/15 20:40:55  king
--| Removed customized event masking routine
--|
--| Revision 1.12.4.6  2000/06/15 19:11:04  king
--| Converted to use an event_box, but not compatible with peers function
--|
--| Revision 1.12.4.5  2000/06/09 20:53:31  manus
--| Cosmetics
--|
--| Revision 1.12.4.4  2000/05/09 20:31:07  king
--| Integrated selectable/deselectable
--|
--| Revision 1.12.4.3  2000/05/05 20:59:02  king
--| Corrected initialize
--|
--| Revision 1.12.4.2  2000/05/04 00:17:41  king
--| Made text left aligned
--|
--| Revision 1.12.4.1  2000/05/03 19:08:50  oconnor
--| mergred from HEAD
--|
--| Revision 1.20  2000/05/02 18:55:30  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.19  2000/04/25 18:51:35  king
--| gslist->radio_group
--|
--| Revision 1.18  2000/02/29 02:21:41  brendel
--| Revised.
--|
--| Revision 1.17  2000/02/25 01:51:38  brendel
--| Added inheritance of EV_RADIO_PEER_IMP, which needs `gslist' effected.
--| Still needs implementing, so old implementation is not removed yet.
--|
--| Revision 1.16  2000/02/24 20:48:54  brendel
--| Changed in compliance with interface.
--|
--| Revision 1.15  2000/02/22 18:39:39  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.14  2000/02/17 02:18:40  oconnor
--| released
--|
--| Revision 1.13  2000/02/14 11:40:32  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.6.4  2000/01/27 19:29:48  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.6.3  2000/01/19 17:23:45  oconnor
--| removed call to old ev_textable_imp_initialize
--|
--| Revision 1.12.6.2  2000/01/07 00:44:09  king
--| Implemented radio button to work with new c_object structure
--|
--| Revision 1.12.6.1  1999/11/24 17:29:57  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.2.3  1999/11/17 01:53:05  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.12.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
