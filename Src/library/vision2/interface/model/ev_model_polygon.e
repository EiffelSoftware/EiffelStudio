indexing
	description:
		"Filled area's defined by any number of `points'."
	status: "See notice at end of class"
	keywords: "figure, polygon"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MODEL_POLYGON

inherit
	EV_MODEL_CLOSED
		redefine
			default_create
		end

	EV_MODEL_MULTI_POINTED
		undefine
			default_create,
			bounding_box
		end

create
	default_create,
	make_with_coordinates

feature {NONE} -- Initialization

	default_create is
			-- Polygon with no points.
		do
			create point_array.make (0)
			Precursor {EV_MODEL_CLOSED}
		end
		
	make_with_coordinates (coords: ARRAY [EV_COORDINATE]) is
			-- Initialize with points in `coords'.
		require
			coords_exist: coords /= Void
		local
			i: INTEGER
		do
			default_create
			from
				i := coords.lower
			until
				i > coords.upper
			loop
				extend_point (coords.item (i))
				i := i + 1
			end
			set_center
		end

feature -- Status report

	side_count: INTEGER is
			-- Returns number of sides this polyline has.
		do
			Result := point_count - 1
			if Result < 0 then
				Result := 0
			end
		ensure
			Result_not_bigger_than_point_count: Result <= point_count
		end

	is_rotatable: BOOLEAN is True
			-- Is rotatable? Yes.
			
	is_scalable: BOOLEAN is True
			-- Is scalable? Yes.
			
	is_transformable: BOOLEAN is True
			-- Is transformable? Yes.

feature -- Access

	angle: DOUBLE is
			-- Angle to rotate for upright position
		do
			Result := 0
		end

feature -- Events

	position_on_figure (a_x, a_y: INTEGER): BOOLEAN is
			-- Is (`a_x', `a_y') contained in this figure?
		do
			Result := point_on_polygon (a_x, a_y, point_array)
		end

end -- class EV_MODEL_POLYGON

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

