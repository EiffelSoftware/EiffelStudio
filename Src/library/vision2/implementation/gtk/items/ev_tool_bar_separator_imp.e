--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"Eiffel Vision tool bar separator. Implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_SEPARATOR_IMP

inherit
	EV_TOOL_BAR_SEPARATOR_I
		redefine
			interface
		select
			interface
		end

	EV_ITEM_IMP
		rename
			interface as sep_item_interface
		undefine	
			parent
		redefine
			initialize
		select
			widget_parent_imp,
			widget_parent_set,
			widget_parent,
			initialize
		end

	EV_VERTICAL_SEPARATOR_IMP
		rename
			parent_imp as vsep_parent_imp,
			parent_set as vsep_parent_set,
			initialize as vsep_initialize,
			interface as vsep_interface,
			parent as vsep_parent
		undefine
			has_parent
		end		

create
	make

feature {NONE} -- Initialization
	
	initialize is
			-- Initialize some stuff useless to separators.
		do
			pixmapable_imp_initialize
			initialize_pixmap_box
			{EV_ITEM_IMP} Precursor
		--| FIXME sementation violation?
		--| 	set_minimum_width (12)
			is_initialized := True
		end

	initialize_pixmap_box is
			-- Give parent to pixmap item box.
			--| This is just to satisfy pixmapable contracts.
		local
			box: POINTER
		do
			box := C.gtk_hbox_new (False, 0)
			C.gtk_widget_hide (box)
			C.gtk_box_pack_start (box, pixmap_box, True, True, 0)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR_SEPARATOR

end -- class EV_TOOL_BAR_SEPARATOR_I

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
--| Revision 1.14  2000/04/12 21:52:05  brendel
--| Added to initialization: parent for pixmap box (to satisfy pixmapable
--| invariants).
--|
--| Revision 1.13  2000/04/12 17:58:21  brendel
--| Revised.
--| Attempt to fix segmentation violation unsuccesful.
--| Added FIXME for the line concerned.
--|
--| Revision 1.12  2000/02/22 18:39:34  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.11  2000/02/14 11:40:27  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.7  2000/02/04 21:22:35  king
--| Changed min_wid to 12 pixels
--|
--| Revision 1.10.6.6  2000/02/04 04:25:36  oconnor
--| released
--|
--| Revision 1.10.6.5  2000/02/02 00:43:34  king
--| Removed redefinition of parent_imp
--|
--| Revision 1.10.6.4  2000/02/01 20:07:06  king
--| Tweaked inheritence to fit in with change to tool_bar_item:
--|
--| Revision 1.10.6.3  2000/01/28 18:41:03  king
--| Implemented tb separator to fit in with new structure
--|
--| Revision 1.10.6.2  2000/01/27 19:29:26  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.1  1999/11/24 17:29:44  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.2  1999/11/02 17:20:02  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
