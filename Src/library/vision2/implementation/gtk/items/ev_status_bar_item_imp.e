--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Eiffel Vision status bar item."
	status: "See notice at the end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR_ITEM_IMP

inherit
	EV_STATUS_BAR_ITEM_I
		redefine
			interface,
			parent_imp
		end

	EV_ITEM_IMP
		undefine
			parent
		redefine
			interface,
			initialize,
			width
		end

	EV_TEXTABLE_IMP
		redefine
			interface
		end

create
	make

feature -- Initialization

	make (an_interface: like interface) is
			-- Create the status bar item.
		do
			base_make (an_interface)
			set_c_object (C.gtk_frame_new (Default_pointer))
			C.gtk_frame_set_shadow_type (c_object, C.GTK_SHADOW_IN_ENUM)
		end

	initialize is
			-- Initialize the pixmap and text containers
		do
			{EV_ITEM_IMP} Precursor
			is_initialized := False
			textable_imp_initialize
			pixmapable_imp_initialize
			initialize_status_bar_box
			is_initialized := True
		end

	initialize_status_bar_box is
			-- Place the pixmap and label boxes in to the status bar item
		local
			box: POINTER
		do
			box := C.gtk_hbox_new (False, 0)
			C.gtk_container_add (c_object, box)
			C.gtk_widget_show (box)
			C.gtk_box_pack_end (box, text_label, True, True, padding)
			C.gtk_widget_hide (text_label)
			C.gtk_box_pack_start (box, pixmap_box, False, False, 1)
			C.gtk_widget_hide (pixmap_box)
		ensure
			status_bar_item_box /= default_pointer
		end

feature -- Access

	width: INTEGER
			-- Horizontal dimension in pixels.

feature -- Status setting

	set_width (value: INTEGER) is
			-- Make `value' the new width of the item.
			-- If -1, then the item adapt its size to fit the space
			-- when the bar gets bigger.
		do
			width := value
			if parent_imp /= Void then
				internal_set_width (value)
			end
		end

	internal_set_width (value: INTEGER) is
			-- Make `value' the new width of the item.
			-- If -1, then the item adapt its size to fit the space
			-- when the bar gets bigger.
		local
			par: POINTER
			allocation: POINTER
			fill, expand, pad, pack_type: INTEGER
		do
			par := parent_imp.c_object
			C.gtk_widget_set_usize (c_object, value, -1)
				-- set the minimum width but don't update `width'
			C.gtk_box_query_child_packing (
				par, c_object,
				$expand, $fill, $pad, $pack_type
			)
			allocation := C.c_gtk_allocation_struct_allocate
			C.set_gtk_allocation_struct_height (allocation, height)
			if (value = -1) then
				C.gtk_box_set_child_packing (
					par, c_object,
					True, fill.to_boolean, pad, pack_type
				)
				C.set_gtk_allocation_struct_width (allocation, 0)
			else
				C.gtk_box_set_child_packing (
					par, c_object,
					False, fill.to_boolean, pad, pack_type
				)
				C.set_gtk_allocation_struct_width (allocation, value)
			end
			C.gtk_widget_size_allocate (c_object, allocation)
			C.c_gtk_allocation_struct_free (allocation)
		end

feature {NONE} -- Implementation

	padding: INTEGER is 3
			-- Number of pixels of extra space arround text and pixmap.

	status_bar_item_box: POINTER is
			-- GtkHBox in button.
			-- Holds label and pixmap.
		do
			Result := C.gtk_container_children (c_object)
			Result := C.g_list_nth_data (Result, 0)
		end

feature {EV_ANY_I}

	interface: EV_STATUS_BAR_ITEM

end -- class EV_STATUS_BAR_ITEM_IMP

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
--| Revision 1.27  2000/04/28 22:07:45  brendel
--| Unreleased.
--|
--| Revision 1.26  2000/04/26 21:06:28  brendel
--| Improved set_width to also work when there is no parent yet.
--|
--| Revision 1.25  2000/04/18 19:46:13  oconnor
--| Reimplemented without externals.
--|
--| Revision 1.24  2000/04/07 22:35:29  brendel
--| Removed inheritance of EV_SIMPLE_ITEM.
--|
--| Revision 1.23  2000/03/01 18:03:58  king
--| Removed redundant features index and set_index
--|
--| Revision 1.22  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.21  2000/02/15 19:22:19  king
--| Changed padding to 1 for pixmap box
--|
--| Revision 1.20  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.19.4.4  2000/02/05 02:47:46  oconnor
--| released
--|
--| Revision 1.19.4.3  2000/02/04 21:21:21  king
--| Implemented to fit in with new structure
--|
--| Revision 1.19.4.2  2000/01/27 19:29:26  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.19.4.1  1999/11/24 17:29:43  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.18.2.4  1999/11/09 16:53:14  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.18.2.3  1999/11/04 23:10:26  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.18.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
