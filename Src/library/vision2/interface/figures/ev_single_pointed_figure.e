indexing
	description:
		"Figures consisting of one point."
	status: "See notive at end of class"
	keywords: "figure, point"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SINGLE_POINTED_FIGURE

feature {NONE} -- Initialization

	make_with_point (a_point: EV_RELATIVE_POINT) is
			-- Create on `a_point'.
		require
			a_point_not_void: a_point /= Void
		do
			default_create
			set_point (a_point)
		end

feature -- Access

	point_count: INTEGER is
			-- `Current' has one point.
		do
			Result := 1
		end

	point: EV_RELATIVE_POINT is
			-- First point of `Current'.
		do
			Result := points.i_th (1)
		end

feature -- Status setting

	set_point (a_point: EV_RELATIVE_POINT) is
			-- Assign `a_point' to `point'.
		require
			a_point_not_void: a_point /= Void
		do
			points.put_i_th (a_point, 1)
		ensure
			point_assigned: point = a_point
		end

feature {NONE} -- Implementation
	
	points: ARRAYED_LIST [EV_RELATIVE_POINT] is
			-- Relative points `Current' consists of.
		deferred
		end

end -- class EV_SINGLE_POINTED_FIGURE

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
