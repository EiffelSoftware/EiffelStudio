indexing
	description: "ColorMatrix used in Windows GDI+."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_COLOR_MATRIX

create
	make

feature {NONE} -- Initlization

	make is
			-- Creation method
		do
			create item.make (structure_size)
		end

feature -- Attributes

	structure_size: INTEGER is
			-- Structure size.
		do
			Result := c_size_of_color_matrix
		end

	set_m (a_value: REAL; a_x, a_y: INTEGER) is
			-- Set `m'
		require
			valid: 0 <= a_x and a_x <= 4
			valid: 0 <= a_y and a_y <= 4
		do
			c_set_m (item.item, a_x, a_y, a_value)
		end

	m alias "[]" (a_x, a_y: INTEGER): REAL assign set_m is
			-- 5Ã-5 array of real numbers.
		require
			valid: 0 <= a_x and a_x <= 4
			valid: 0 <= a_y and a_y <= 4
		do
			Result := c_m (item.item, a_x, a_y)
		end

	m_row (a_x: INTEGER): ARRAY [REAL] assign set_m_row is
			-- Row at `a_x'
		require
			valid: 0 <= a_x and a_x <= 4
		do
			create Result.make (0, 4)
			Result [0] := m (a_x, 0)
			Result [1] := m (a_x, 1)
			Result [2] := m (a_x, 2)
			Result [3] := m (a_x, 3)
			Result [4] := m (a_x, 4)
		end

	set_m_row (a_value: ARRAY [REAL]; a_x: INTEGER) is
			-- Set `m_row' at `a_x'
		require
			valid: 0 <= a_x and a_x <= 4
			valid: a_value.count = 5
		do
			set_m (a_value [a_value.lower + 0], a_x, 0)
			set_m (a_value [a_value.lower + 1], a_x, 1)
			set_m (a_value [a_value.lower + 2], a_x, 2)
			set_m (a_value [a_value.lower + 3], a_x, 3)
			set_m (a_value [a_value.lower + 4], a_x, 4)
		end

	item: MANAGED_POINTER;
			-- Implementation item		

feature {NONE} -- Externals

	c_set_m (a_item: POINTER; a_x, a_y: INTEGER; a_value: REAL) is
			-- Set cell at `a_x', `a_y' to `a_value'.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				((ColorMatrix*)$a_item)->m[$a_x][$a_y] = $a_value;
			}
			]"
		end

	c_m (a_item: POINTER; a_x, a_y: INTEGER): REAL is
			-- Value of cell at `a_x', `a_y'.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((ColorMatrix*)$a_item)->m[$a_x][$a_y]
			]"
		end

	c_size_of_color_matrix: INTEGER is
			-- Size of ColorMatrix structure.
		external
			"C [macro %"wel_gdi_plus.h%"]"
		alias
			"sizeof (ColorMatrix)"
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

end


