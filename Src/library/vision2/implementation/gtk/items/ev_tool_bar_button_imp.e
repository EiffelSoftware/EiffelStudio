--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"EiffelVision2 Toolbar button,%
		%a specific button that goes in a tool-bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_BUTTON_IMP

inherit
	EV_TOOL_BAR_BUTTON_I
		redefine
			interface
		select
			interface
		end

	EV_ITEM_IMP
		rename
			interface as simple_item_interface
		undefine
			set_pixmap,
			remove_pixmap,
			parent,
			pointer_over_widget
		redefine
			initialize
		end

	EV_BUTTON_IMP
		rename
			interface as button_interface,
			parent_set as button_parent_set,
			parent as button_parent
		undefine
			has_parent, button_press_switch
		redefine
			make,
			initialize,
			initialize_button_box
		select
			button_parent_set,
			button_parent
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create the tool bar button.
		do
			base_make (an_interface)
			set_c_object (C.gtk_button_new)
			C.gtk_button_set_relief (c_object, C.gtk_relief_none_enum)
		end

	connect_signals is
			-- Redefined in radio as press_actions is not connected directly
		do
			connect_signal_to_actions (
				"clicked",
				interface.select_actions,
				Void
			)
		end

	initialize is
			-- Initialization of button box and events.
		do
			{EV_ITEM_IMP} Precursor
			pixmapable_imp_initialize
			textable_imp_initialize
			initialize_button_box
			connect_signals
			is_initialized := True
		end

	initialize_button_box is
			-- Create the box for pixmap and label and connect action sequence.
		local
			box: POINTER
		do
			box := C.gtk_vbox_new (False, 0)
			C.gtk_container_add (c_object, box)
			C.gtk_widget_show (box)
			C.gtk_box_pack_end (box, text_label, True, True, 0)
			C.gtk_widget_hide (text_label)
			C.gtk_box_pack_start (box, pixmap_box, True, True, 0)
			C.gtk_widget_hide (pixmap_box)
		end

feature -- Access

	gray_pixmap: EV_PIXMAP
			-- Image displayed on `Current'.

	gray_pixmap_imp: EV_PIXMAP_IMP is
			-- Implementation of the gray pixmap contained 
		do
			if gray_pixmap /= Void then
				Result ?= gray_pixmap.implementation
			end
		end

feature -- Element change

	set_gray_pixmap (a_gray_pixmap: EV_PIXMAP) is
			-- Assign `a_gray_pixmap' to `gray_pixmap'.
		do
		end

	remove_gray_pixmap is
			-- Make `pixmap' `Void'.
		do
		end

feature -- Status report

	index: INTEGER is
		do
			if parent_imp /= Void then
				Result := C.gtk_list_child_position (
					parent_imp.list_widget,
					Current.c_object
				) + 1
			end 
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_BUTTON

end -- class EV_TOOL_BAR_BUTTON_IMP

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
--!---------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.25  2000/06/07 17:27:29  oconnor
--| merged from DEVEL tag MERGED_TO_TRUNK_20000607
--|
--| Revision 1.15.2.5  2000/06/06 00:40:41  king
--| Undefined button_press_switch
--|
--| Revision 1.15.2.4  2000/06/01 22:03:38  king
--| Using pointer over widget from EV_BUTTON_IMP
--|
--| Revision 1.15.2.3  2000/05/16 16:23:48  king
--| Removed refererence to now defunct parent_imp
--|
--| Revision 1.15.2.2  2000/05/10 23:02:54  king
--| Integrated inital tooltipable changes
--|
--| Revision 1.15.2.1  2000/05/03 19:08:36  oconnor
--| mergred from HEAD
--|
--| Revision 1.24  2000/05/02 18:55:19  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.23  2000/04/18 16:50:04  king
--| Replaced press-actions -> select_actions
--|
--| Revision 1.22  2000/04/13 21:59:47  king
--| Correct pointer equivalance from Void to NULL
--|
--| Revision 1.21  2000/04/07 22:35:53  brendel
--| Removed EV_SIMPLE_ITEM_IMP from inheritance.
--|
--| Revision 1.20  2000/04/04 20:50:18  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.19  2000/03/20 23:42:06  pichery
--| Fixed bug (contract in deferred class, not in implementation)
--|
--| Revision 1.18  2000/03/20 23:40:04  pichery
--| Added gray pixmap notion (not currently implemented on GTK)
--|
--| Revision 1.17  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.16  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.15.4.7  2000/02/04 21:22:08  king
--| Changed packing options for pix and text box
--|
--| Revision 1.15.4.6  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.15.4.5  2000/02/01 20:05:57  king
--| extracted a connect signals to be redefined in tb_rad_but
--|
--| Revision 1.15.4.4  2000/01/28 18:43:00  king
--| Updated initialize to use pixmapable and textable initialize nam changes
--|
--| Revision 1.15.4.3  2000/01/27 19:29:26  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.15.4.2  2000/01/26 23:20:44  king
--| Implemented to fit in with new structure, index and ordering need
--| implementing, removed redundant features
--|
--| Revision 1.15.4.1  1999/11/24 17:29:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.13.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
