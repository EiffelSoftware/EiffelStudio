--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision2 toolbar, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_IMP

inherit
	EV_TOOL_BAR_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_TOOL_BAR_ITEM]
		undefine
			item_by_data
		redefine
			interface,
			add_to_container
		end

create
	make

feature {NONE} -- Implementation

	make (an_interface: like interface) is
			-- Create the tool-bar.
		do
			base_make (an_interface)
			set_c_object (C.gtk_hbox_new (False, 0))
			list_widget := c_object
		end

feature -- Implementation

	add_to_container (v: like item) is
			-- Add `v' to tool bar, set to non-expandable.
		local
			old_expand, fill, pad, pack_type: INTEGER
			wid_imp: EV_WIDGET_IMP
		do
			Precursor (v)
			wid_imp ?= v.implementation

			C.gtk_box_query_child_packing (
				list_widget,
				wid_imp.c_object,
				$old_expand,
				$fill,
				$pad,
				$pack_type
			)
			C.gtk_box_set_child_packing (
				list_widget,
				wid_imp.c_object,
				False,
				fill.to_boolean,
				pad,
				pack_type
			)
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			check to_be_implemented: False end
		end

	list_widget: POINTER

feature {EV_ANY_I} -- Implementation

	interface: EV_TOOL_BAR

end -- class EV_TOOL_BAR_IMP

--!----------------------------------------------------------------
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
--!----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.11  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.10.6.7  2000/02/04 21:27:20  king
--| Made toolbar horizontal box for homogeneous height resizing, changed add_to_container to pack widgets in to the toolbar so they are non-expandable
--|
--| Revision 1.10.6.6  2000/02/04 04:25:39  oconnor
--| released
--|
--| Revision 1.10.6.5  2000/02/01 20:09:42  king
--| Changed inheritence to use tool bar items
--|
--| Revision 1.10.6.4  2000/01/28 19:03:38  king
--| Altered to inherit from generic ev_item_list_imp
--|
--| Revision 1.10.6.3  2000/01/27 19:29:49  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.10.6.2  2000/01/26 23:44:43  king
--| Removed redundant features, implemented to fit in with new structure
--|
--| Revision 1.10.6.1  1999/11/24 17:29:59  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.10.2.3  1999/11/17 01:53:06  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.10.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
