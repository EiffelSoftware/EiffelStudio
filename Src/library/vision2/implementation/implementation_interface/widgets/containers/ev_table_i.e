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
		
	is_homogeneous: BOOLEAN is
			-- Are all children restriced to be the same size.
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

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

