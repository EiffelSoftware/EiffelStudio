indexing
	description: 
		"Eiffel Vision table. Implementation interface";
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_TABLE_I

inherit
	EV_CONTAINER_I
		redefine
			interface
		end

feature -- Access

	item: EV_WIDGET is
			-- There is no `item' for `Current'.
		do
			check Inapplicable: False end
		end

feature -- Status report

	widget_count: INTEGER is
			-- Number of widgets in `Current'.
		deferred
		end

	row_spacing: INTEGER is
			-- Spacing between two consecutive rows.
		deferred
		end
	
	column_spacing: INTEGER is
			-- Spacing between two consecutive columns.
		deferred
		end

	border_width: INTEGER is
			-- Spacing between edge of `Current' and items.
		deferred
		end

feature -- Status settings

	enable_homogeneous is
			-- Set all item's sizes to that of the largest in `Current'.
		deferred
		end

	disable_homogeneous is
			-- Allow items to be of varying sizes.
		deferred
		end
	
	set_row_spacing (a_value: INTEGER) is
			-- Spacing between two consecutive rows of `Current'.
		require
			positive_value: a_value >= 0
		deferred
		end

	set_column_spacing (a_value: INTEGER) is
			-- Spacing between two consecutive columns of `Current'.
		require
			positive_value: a_value >= 0
		deferred
		end

	set_border_width (a_value: INTEGER) is
			-- Assign `a_value' to `border_width'.
		require
			positive_value: a_value >= 0
		deferred
		end

	resize (a_column, a_row: INTEGER) is
			-- Resize `Current' to `a_column' columns by `a_row' rows.
		require
			a_column_positive: a_column >= 1
			a_row_positive: a_row >= 1
		deferred
		end

feature -- Element change

	put (v: EV_WIDGET; a_column, a_row, column_span, row_span: INTEGER) is
			-- Set `a_widgets' position in the
			-- table to be (x1, y1) (x2, y2)
		require
			v_not_void: v /= Void
			a_column_positive: a_column >= 1
			a_row_positive: a_row >= 1
			column_span_positive: column_span >= 1
			row_span_positive: row_span >= 1
		deferred
		end

	remove (v: EV_WIDGET) is
			-- Remove `v' from `Current' if present.
		require
			v_not_void: v /= Void
		deferred
		end

	extend (v: like item) is
			-- Not used by `Current'.
		do
			check
				Inapplicable: False
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TABLE

	Default_homogeneous: BOOLEAN is True
		-- `Current' is homgeneous by default.

	Default_row_spacing: INTEGER is 0
		-- Default row spacing of `Current'.

	Default_column_spacing: INTEGER is 0
		-- Default column spacing of `Current'.


end -- class EV_TABLE_I

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
--| Revision 1.8  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.3.4.11  2000/08/17 22:53:42  rogers
--| Removed fixme not_reviewed. Comments, formatting.
--|
--| Revision 1.3.4.10  2000/06/09 20:52:55  rogers
--| Removed FIXME Not for release.
--|
--| Revision 1.3.4.9  2000/06/06 23:37:41  rogers
--| Added border_Width and set_border_wdith. Removed some redundent
--| requires.
--|
--| Revision 1.3.4.8  2000/06/06 00:42:17  king
--| Added resize
--|
--| Revision 1.3.4.7  2000/06/05 21:11:13  king
--| Added widget_count, prune->remove
--|
--| Revision 1.3.4.6  2000/06/02 23:31:21  king
--| Now inheriting from EV_CONTAINER
--|
--| Revision 1.3.4.5  2000/06/02 22:07:51  king
--| New table implementation
--|
--| Revision 1.3.4.4  2000/05/31 22:30:18  king
--| Corrected argument ordering in set_position_by_widget
--|
--| Revision 1.3.4.3  2000/05/31 00:32:11  king
--| Corrected preconditions for set_position_by_widget
--|
--| Revision 1.3.4.2  2000/05/30 22:25:09  king
--| Implemented to new structure
--|
--| Revision 1.3.4.1  2000/05/03 19:09:05  oconnor
--| mergred from HEAD
--|
--| Revision 1.6  2000/03/21 16:52:53  oconnor
--| removed invisible container
--|
--| Revision 1.5  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.4  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.3.6.2  2000/01/27 19:30:02  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.3.6.1  1999/11/24 17:30:10  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.3.2.3  1999/11/04 23:10:42  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.3.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
