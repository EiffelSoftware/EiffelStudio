indexing
	description: 
		"EiffelVision box, implementation interface."
	status: "See notice at end of class"
	keywords: "container, box"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_BOX_I
	
inherit
	EV_WIDGET_LIST_I
		redefine
			interface
		end
	
feature -- Constants
	
	Default_homogeneous: BOOLEAN is False
	Default_spacing: INTEGER is 0
	Default_border_width: INTEGER is 0

feature -- Access

	is_homogeneous: BOOLEAN is
			-- Are all children restriced to be the same size.
		deferred
		end

	border_width: INTEGER is
			-- Width of border around container in pixels.
		deferred
		ensure
			positive_result: Result >= 0
		end

	padding: INTEGER is
			-- Space between children in pixels.
		deferred
		ensure
			positive: Result >= 0
		end

feature {EV_ANY, EV_ANY_I} -- Status report

	is_item_expanded (child: EV_WIDGET): BOOLEAN is
			-- Is `child' expanded to occupy available spare space.
		require
			has_child: interface.has (child)
		deferred
		end
	
feature {EV_ANY, EV_ANY_I} -- Status settings
	
	set_homogeneous (flag: BOOLEAN) is
			-- Set whether every child is the same size.
		deferred
		ensure
			homogeneous_set: is_homogeneous = flag
		end

	set_border_width (value: INTEGER) is
			-- Assign `value' to `border_width'.
		require
			positive_value: value >= 0
		deferred
		ensure
			border_assigned: border_width = value
		end	
	
	set_padding (value: INTEGER) is
			-- Assign `value' to `padding'.
		require
			positive_value: value >= 0
		deferred
		end	

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Set whether `child' expands to fill avalible spare space.
		require
			has_child: interface.has (child)
		deferred
		ensure
			flag_assigned: is_item_expanded (child) = flag
		end	
		
feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: EV_BOX

end -- class EV_BOX_I

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
--| Revision 1.21  2001/07/14 12:46:24  manus
--| Replace --! by --|
--|
--| Revision 1.20  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.19  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.15.4.2  2000/05/15 22:53:18  king
--| set_child_expand->set_item_expand
--|
--| Revision 1.15.4.1  2000/05/03 19:09:04  oconnor
--| mergred from HEAD
--|
--| Revision 1.17  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.16  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.15.6.9  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.15.6.8  2000/01/27 19:30:00  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.15.6.7  1999/12/16 02:25:55  oconnor
--| spell
--|
--| Revision 1.15.6.6  1999/12/15 23:50:50  oconnor
--| moved expandable implementation to BOX_IMP, redid comments
--|
--| Revision 1.15.6.5  1999/12/15 20:17:29  oconnor
--| reworking box formatting, contracts and names
--|
--| Revision 1.15.6.4  1999/12/15 19:58:35  oconnor
--| fixed has preconditions to use interface.has
--|
--| Revision 1.15.6.3  1999/12/15 18:33:04  oconnor
--| formatting
--|
--| Revision 1.15.6.2  1999/11/30 22:48:42  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.15.6.1  1999/11/24 17:30:09  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.15.2.4  1999/11/09 16:53:16  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.15.2.3  1999/11/04 23:10:41  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.15.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------
