indexing

	description:
		"EiffelVision dynamic table. Implementation interface";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_DYNAMIC_TABLE_I

inherit
	EV_TABLE_I

feature -- Status report

	is_row_layout: BOOLEAN is
			-- Are children laid out in rows?
		require
			exists: not destroyed
		deferred
		end

feature -- Status setting

	set_finite_dimension (a_number: INTEGER) is
			-- Set number of columns if row
			-- layout, or number of row if column
			-- layout.
		require
			exists: not destroyed
			positive_number: a_number > 0
		deferred
		end

	set_row_layout (flag: BOOLEAN) is
			-- Lay the children out in rows if True,
			-- in colum otherwise.
		require
			exists: not destroyed
		deferred
		ensure
			layout_set: is_row_layout = flag
		end

end -- class EV_DYNAMIC_TABLE_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--|----------------------------------------------------------------
