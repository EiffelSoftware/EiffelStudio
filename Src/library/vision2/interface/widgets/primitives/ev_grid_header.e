indexing
	description: "Objects that represent a header control for an EV_GRID"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_HEADER

inherit
	EV_HEADER

create {EV_GRID_I}
	make_with_grid

feature {NONE} -- Initialization

	make_with_grid (a_grid: EV_GRID_I) is
			-- Create and associate `Current' with `a_grid'.
		require
			a_grid_not_void: a_grid /= Void
		do
			default_create
			grid := a_grid
		end

feature {NONE} -- Implementation

	grid: EV_GRID_I
		-- Grid to which `Current' is associated with.

invariant
	grid_not_void: grid /= Void

end

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
