indexing
	description: "[
			Objects that are used to convert SPECIAL [EV_COORDINATE] to ARRAY [EV_COORDINATE]
					(workaround for the EV_FIGURE_DRAWER)
					]"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COORDINATE_ARRAY
	
inherit
	ARRAY [EV_COORDINATE]
	
create
	make_from_area
	
feature {NONE} -- Initialization

	make_from_area (a: SPECIAL [EV_COORDINATE]) is
			-- Make an ARRAY using `a' as `area'.
		require
			area_exists: a /= Void
		do
			area := a
			lower := 1
			upper := a.count
		end

end -- class EV_COORDINATE_ARRAY

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

