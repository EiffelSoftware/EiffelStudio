indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	PROJECTION

feature -- Access

	x, y: INTEGER

	xr, yr, zr: REAL

feature -- Element change

	set_x (a_x: INTEGER) is
			-- Set `x' with `a_x'
		do
			x := a_x
		ensure
			x_set: x = a_x
		end

	set_y (a_y: INTEGER) is
			-- Set `y' with `a_y'
		do
			y := a_y
		ensure
			y_set: y = a_y
		end

	set_xr (a_xr: REAL) is
			-- Set `xr' with `a_xr'
		do
			xr := a_xr
		ensure
			xr_set: xr = a_xr
		end

	set_yr (a_yr: REAL) is
			-- Set `yr' with `a_yr'
		do
			yr := a_yr
		ensure
			yr_set: yr = a_yr
		end

	set_zr (a_zr: REAL) is
			-- Set `zr' with `a_zr'
		do
			zr := a_zr
		ensure
			zr_set: zr = a_zr
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


end -- class PROJECTION

