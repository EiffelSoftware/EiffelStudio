indexing
	description: 
		"Eiffel Vision cell, GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CELL_IMP
	
inherit
	EV_CELL_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		redefine
			interface,
			replace
		end

create
	make

feature -- initialization

	make (an_interface: like interface) is
			-- Connect interface and initialize `c_object'.
		do
			base_make (an_interface)
			set_c_object (C.gtk_event_box_new)
		end

feature -- Access

	item: EV_WIDGET is
			-- Current item
		local
			p: POINTER
			imp: EV_ANY_IMP
		do
			p := C.gtk_container_children (container_widget)
			if p /= NULL then
				p := C.g_list_nth_data (p, 0)
				if p /= NULL then
					imp := eif_object_from_c (p)
					check
						imp_not_void: imp /= Void
							-- C object should have Eiffel object.
					end
					Result ?= imp.interface
				end
			end
		end

feature -- Element change

	replace (v: like item) is
			-- Replace `item' with `v'.
		local
			i: EV_WIDGET
			imp: EV_WIDGET_IMP
		do
			i := item
			if i /= Void then
				on_removed_item (i)
				imp ?= i.implementation
				C.gtk_container_remove (container_widget, imp.c_object)
			end
			if v /= Void then
				imp ?= v.implementation
				C.gtk_container_add (container_widget, imp.c_object)
				update_child_requisition (imp.c_object)
				on_new_item (v)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CONTAINER
			-- Provides a common user interface to possibly dependent
			-- functionality implemented by `Current'.

end -- class EV_CELL_IMP

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
--| Revision 1.10  2001/07/14 12:46:23  manus
--| Replace --! by --|
--|
--| Revision 1.9  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.8  2001/06/21 22:33:32  king
--| Added call to update_child_requisition on item addition
--|
--| Revision 1.7  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.6.2.6  2000/10/27 16:54:41  manus
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
--| Revision 1.6.2.5  2000/09/18 18:06:42  oconnor
--| reimplemented propogate_[fore|back]ground_color for speeeeed
--|
--| Revision 1.6.2.4  2000/08/08 00:03:13  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.6.2.3  2000/08/04 19:19:28  oconnor
--| Optimised radio button management by using a polymorphic call
--| instaed of using agents.
--|
--| Revision 1.6.2.2  2000/06/14 18:17:44  king
--| Changed container features to use container_widget for descendants like frame
--|
--| Revision 1.6.2.1  2000/05/03 19:08:47  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/05/02 18:55:28  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.5  2000/04/25 21:07:09  brendel
--| Costmetics.
--|
--| Revision 1.4  2000/02/26 01:27:03  brendel
--| Added call to new_item_actions and remove_item_actions.
--|
--| Revision 1.3  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.2  2000/02/14 12:05:09  oconnor
--| added from prerelease_20000214
--|
--| Revision 1.1.2.7  2000/02/08 09:30:38  oconnor
--| replaced put with replace
--|
--| Revision 1.1.2.6  2000/02/04 04:25:37  oconnor
--| released
--|
--| Revision 1.1.2.5  2000/01/27 19:29:42  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.2.4  2000/01/20 18:47:16  oconnor
--| made non deferred
--|
--| Revision 1.1.2.3  2000/01/18 19:35:39  oconnor
--| added feature item
--|
--| Revision 1.1.2.2  2000/01/18 18:02:39  oconnor
--| redefined interface
--|
--| Revision 1.1.2.1  2000/01/18 18:01:48  oconnor
--| initial
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
