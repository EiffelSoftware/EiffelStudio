--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "Eiffel Vision status bar."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_STATUS_BAR_IMP

inherit
	EV_STATUS_BAR_I
		redefine
			interface
		select
			interface
		end

	EV_PRIMITIVE_IMP
		rename
			interface as primitive_interface
		redefine
			initialize
		end

	EV_ITEM_LIST_IMP [EV_STATUS_BAR_ITEM]
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a horizontal box in which we will put
			-- the different status bar, with `par' as parent.
			-- Create a gtk status bar, with the horizontal box as parent
		do
			base_make (an_interface)
			set_c_object (C.gtk_hbox_new (False, 0))
				-- create the horizontal box no spacing
		end

	initialize is
		do
			C.gtk_widget_show (c_object)
			set_default_colors
			is_initialized := True
		end

feature {NONE} -- Implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			C.gtk_box_reorder_child (a_container, a_child, a_position)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_STATUS_BAR

end -- class EV_STATUS_BAR_IMP

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.17  2000/04/06 23:59:12  brendel
--| Removed assignment to list_widget.
--|
--| Revision 1.16  2000/04/05 21:16:10  brendel
--| Merged changes from LIST_REFACTOR_BRANCH.
--|
--| Revision 1.15.2.1  2000/04/05 00:03:04  brendel
--| removed list_widget.
--|
--| Revision 1.15  2000/03/13 22:11:07  king
--| Corrected indenting on feature clauses
--|
--| Revision 1.14  2000/03/13 19:08:09  king
--| Implemented reorder_child
--|
--| Revision 1.13  2000/02/14 11:40:33  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.6.8  2000/02/05 03:21:27  oconnor
--| renamed interface as primitive_interface
--|
--| Revision 1.12.6.7  2000/02/05 01:03:47  oconnor
--| released
--|
--| Revision 1.12.6.6  2000/02/04 22:53:39  king
--| Made status bar visible in initialize
--|
--| Revision 1.12.6.5  2000/02/04 22:43:24  king
--| Redefined redundant initialize feature, inheritence from primitive needs removing
--|
--| Revision 1.12.6.4  2000/02/04 21:28:18  king
--| Removed dodgy old redundant features
--|
--| Revision 1.12.6.3  2000/01/27 19:29:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.6.2  1999/11/30 23:02:06  oconnor
--| rename EV_ITEM_HOLDER_IMP to EV_ITEM_LIST_IMP
--|
--| Revision 1.12.6.1  1999/11/24 17:30:01  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.12.2.5  1999/11/17 01:53:07  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.12.2.4  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.12.2.3  1999/11/02 17:20:05  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
