indexing
	description: "GpPoint struct used by Gdi+."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_POINT

create
	make,
	make_with_position

feature {NONE} -- Initlization

	make is
			-- Creation method
		do
			create  internal_item.make (structure_size)
		end

	make_with_position (a_x, a_y: INTEGER) is
			-- Initlialize Current with `a_x', `a_y', `a_width' and `a_height'.
		do
			make
			set_x (a_x)
			set_y (a_y)
		ensure
			x_set: a_x = x
			y_set: a_y = y
		end

feature -- Command

	set_x (a_x: INTEGER) is
			-- Set `x' with `a_x'.
		do
			c_set_x (item, a_x)
		ensure
			set: x = a_x
		end

	set_y (a_y: INTEGER) is
			-- Set `y' with `a_y'.
		do
			c_set_y (item, a_y)
		ensure
			set: y = a_y
		end

feature -- Query

	structure_size: INTEGER is
			-- Size of Current structure.
		do
			Result := c_size_of_gp_point
		end

	x: INTEGER is
			-- X position
		do
			Result := c_x (item)
		end

	y: INTEGER is
			-- Y position
		do
			Result := c_y (item)
		end

	item: POINTER is
			-- Pointer to C struct
		do
			Result := internal_item.item
		ensure
			not_null: Result /= default_pointer
		end

feature {NONE} -- Implementation

	internal_item: MANAGED_POINTER
			-- Managed pointer to the struct.

feature {NONE} -- C externals

	c_size_of_gp_point: INTEGER is
			-- GpPoint struct size.
		external
			"C [macro %"wel_gdi_plus.h%"]"
		alias
			"sizeof (GpPoint)"
		end

	c_set_x (a_item: POINTER; a_x: INTEGER) is
			-- Set `a_item''s x with `a_x'
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				((GpPoint *)$a_item)->X = (EIF_INTEGER)$a_x;
			}
			]"
		end

	c_set_y (a_item: POINTER; a_y: INTEGER) is
			-- Set `a_item''s y with `a_y'
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				((GpPoint *)$a_item)->Y = (EIF_INTEGER)$a_y;
			}
			]"
		end

	c_x (a_item: POINTER): INTEGER is
			-- `a_item''s x
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((GpPoint *)$a_item)->X
			]"
		end

	c_y (a_item: POINTER): INTEGER is
			-- `a_item''s y
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((GpPoint *)$a_item)->Y
			]"
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
