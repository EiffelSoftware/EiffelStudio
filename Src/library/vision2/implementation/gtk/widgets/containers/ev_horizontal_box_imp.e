indexing
	description: 
		"EiffelVision horizontal box. GTK+ implementation."
	status: "See notice at end of class"
	keywords: "container, horizontal. box"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_HORIZONTAL_BOX_IMP
	
inherit
	EV_HORIZONTAL_BOX_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end
		
	EV_BOX_IMP
		redefine
			interface,
			make
		end

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Create a GTK horizontal box.
		do	
			base_make (an_interface)
			set_c_object (C.gtk_event_box_new)
			container_widget := C.gtk_hbox_new (Default_homogeneous, Default_spacing)
			C.gtk_container_add (c_object, container_widget)
			C.gtk_widget_show (container_widget)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_HORIZONTAL_BOX

end -- class EV_HORIZONTAL_BOX_IMP

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
--| Revision 1.18  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.15.4.7  2000/10/27 16:54:42  manus
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
--| Revision 1.15.4.6  2000/10/09 19:28:09  oconnor
--| cosmetics
--|
--| Revision 1.15.4.5  2000/09/18 18:06:43  oconnor
--| reimplemented propogate_[fore|back]ground_color for speeeeed
--|
--| Revision 1.15.4.4  2000/08/28 18:20:58  king
--| Adding box b4 showing
--|
--| Revision 1.15.4.3  2000/08/08 00:03:14  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.15.4.2  2000/06/14 00:01:39  king
--| Added event box to catch events
--|
--| Revision 1.15.4.1  2000/05/03 19:08:48  oconnor
--| mergred from HEAD
--|
--| Revision 1.17  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.16  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.15.6.9  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.15.6.8  2000/01/27 19:29:43  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.15.6.7  1999/12/15 23:50:49  oconnor
--| moved expandable implementation to BOX_IMP, redid comments
--|
--| Revision 1.15.6.6  1999/12/15 20:17:28  oconnor
--| reworking box formatting, contracts and names
--|
--| Revision 1.15.6.5  1999/12/15 18:33:04  oconnor
--| formatting
--|
--| Revision 1.15.6.4  1999/12/04 18:59:18  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.15.6.3  1999/12/01 16:08:02  oconnor
--| added C_GTK_HBOX
--|
--| Revision 1.15.6.2  1999/11/30 23:15:47  oconnor
--| redefine interface to be of more refined type
--|
--| Revision 1.15.6.1  1999/11/24 17:29:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.15.2.3  1999/11/17 01:53:03  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.15.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
