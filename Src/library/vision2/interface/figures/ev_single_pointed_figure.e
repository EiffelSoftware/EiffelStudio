indexing
	description:
		"Figures consisting of one point."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_SINGLE_POINTED_FIGURE

