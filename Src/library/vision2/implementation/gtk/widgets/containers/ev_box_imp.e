indexing
	description: 
		"EiffelVision box. GTK+ implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_BOX_IMP
	
inherit
	EV_BOX_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_WIDGET_LIST_IMP
		redefine
			interface,
			container_widget
		end

feature -- Access

	is_homogeneous: BOOLEAN is
			-- Are all children restriced to be the same size.
		do
			Result := C.gtk_box_struct_homogeneous (container_widget) /= 0
		end

	border_width: INTEGER is
			-- Width of border around container in pixels.
		do
			Result := C.gtk_container_struct_border_width (
					C.gtk_box_struct_container (container_widget)
				)
		end

	padding: INTEGER is
			-- Space between children in pixels.		
		do
			Result := C.gtk_box_struct_spacing (container_widget)
		end
	
feature -- Status report

	is_item_expanded (child: EV_WIDGET): BOOLEAN is
			-- Is `child' expanded to occupy avalible spare space.
		local
			fill: INTEGER
			expand, pad, pack_type: INTEGER
			wid_imp: EV_WIDGET_IMP
		do
			wid_imp ?= child.implementation
			C.gtk_box_query_child_packing (
				container_widget,
				wid_imp.c_object,
				$expand,
				$fill,
				$pad,
				$pack_type
			)
			Result := expand.to_boolean
		end
	
feature -- Status settings
	
	set_homogeneous (flag: BOOLEAN) is
			-- Set whether every child is the same size.
		do
			C.gtk_box_set_homogeneous (container_widget, flag)
		end

	set_border_width (value: INTEGER) is
			 -- Assign `value' to `border_width'.
		do
			C.gtk_container_set_border_width (container_widget, value)
		end	
	
	set_padding (value: INTEGER) is
			-- Assign `value' to `padding'.
		do
			C.gtk_box_set_spacing (container_widget, value)
		end	

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Set whether `child' expands to fill available spare space.
		local
			old_expand, fill, pad, pack_type: INTEGER
			wid_imp: EV_WIDGET_IMP
		do
			wid_imp ?= child.implementation
			C.gtk_box_query_child_packing (
				container_widget,
				wid_imp.c_object,
				$old_expand,
				$fill,
				$pad,
				$pack_type
			)
			C.gtk_box_set_child_packing (
				container_widget,
				wid_imp.c_object,
				flag,
				fill.to_boolean,
				pad,
				pack_type
			)
		end

feature {NONE} -- Implementation

	container_widget: POINTER

feature {EV_ANY_I} -- Implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			C.gtk_box_reorder_child (a_container, a_child, a_position)
		end

	interface: EV_BOX
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_BOX_IMP

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
--| Revision 1.28  2001/07/14 12:46:23  manus
--| Replace --! by --|
--|
--| Revision 1.27  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.26  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.21.4.8  2000/10/27 16:54:41  manus
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
--| Revision 1.21.4.7  2000/09/18 18:06:42  oconnor
--| reimplemented propogate_[fore|back]ground_color for speeeeed
--|
--| Revision 1.21.4.6  2000/08/08 00:03:13  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.21.4.5  2000/06/14 00:00:03  king
--| Converted to new container_widget structure
--|
--| Revision 1.21.4.4  2000/06/07 17:15:29  king
--| Removed redundant external
--|
--| Revision 1.21.4.3  2000/05/25 00:35:25  king
--| Implemented external calls in Eiffel
--|
--| Revision 1.21.4.2  2000/05/15 22:53:17  king
--| set_child_expand->set_item_expand
--|
--| Revision 1.21.4.1  2000/05/03 19:08:47  oconnor
--| mergred from HEAD
--|
--| Revision 1.24  2000/04/12 17:39:48  oconnor
--| Changed BOOLEAN whos address was passed to GTK to INTEGER.
--| gboolean is int whereas EIF_BOOLEAN is char, this caused the stack to
--| be munged.
--|
--| Revision 1.23  2000/02/22 18:39:37  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.22  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.21.6.12  2000/02/04 21:24:03  king
--| Corrected spelling in comment
--|
--| Revision 1.21.6.11  2000/02/04 04:25:37  oconnor
--| released
--|
--| Revision 1.21.6.10  2000/01/27 19:29:42  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.21.6.9  2000/01/19 18:09:46  oconnor
--| commentd out obsolete code
--|
--| Revision 1.21.6.8  2000/01/18 17:53:36  oconnor
--| Added EV_WIDGET_LIST.gtk_reorder_child deferred.
--| Defined in ev_notebook_imp.e and ev_box_imp.e.
--| GTK is missing a GtkMultiContainer class so there is no way
--| to polymorphicaly call gtk_box_reorder_child and gtk_notebook_reorder_child.
--|
--| Revision 1.21.6.7  1999/12/17 23:19:00  oconnor
--| use INTEGER not BOOLEAN when passing to C
--|
--| Revision 1.21.6.6  1999/12/16 02:38:09  oconnor
--| added comments
--|
--| Revision 1.21.6.5  1999/12/15 23:50:49  oconnor
--| moved expandable implementation to BOX_IMP, redid comments
--|
--| Revision 1.21.6.4  1999/12/15 20:17:28  oconnor
--| reworking box formatting, contracts and names
--|
--| Revision 1.21.6.3  1999/12/04 18:59:18  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.21.6.2  1999/11/30 23:15:47  oconnor
--| redefine interface to be of more refined type
--|
--| Revision 1.21.6.1  1999/11/24 17:29:53  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.21.2.3  1999/11/17 01:53:03  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.21.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
