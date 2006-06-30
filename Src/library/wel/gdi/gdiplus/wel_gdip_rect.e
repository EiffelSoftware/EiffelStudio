indexing
	description: "GpRect struct used by Gdi+."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_RECT

create
	make,
	make_with_size

feature {NONE} -- Initlization

	make is
			-- Creation method
		do
			create  internal_item.make (structure_size)
		end

	make_with_size (a_x, a_y, a_width, a_height: INTEGER) is
			-- Initlialize Current with `a_x', `a_y', `a_width' and `a_height'.
		do
			make
			set_x (a_x)
			set_y (a_y)
			set_width (a_width)
			set_height (a_height)
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

	set_width (a_width: INTEGER) is
			-- Set `width' with `a_width'.
		do
			c_set_width (item, a_width)
		ensure
			set: width = a_width
		end

	set_height (a_height: INTEGER) is
			-- Set `height' with `a_height'.
		do
			c_set_height (item, a_height)
		ensure
			set: height = a_height
		end

feature -- Query

	structure_size: INTEGER is
			-- Size of Current structure.
		do
			Result := c_size_of_gp_rect
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

	width: INTEGER is
			-- Width
		do
			Result := c_width (item)
		end

	height: INTEGER is
			-- Height
		do
			Result := c_height (item)
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

	c_size_of_gp_rect: INTEGER is
			-- GpRect struct size.
		external
			"C [macro %"wel_gdi_plus.h%"]"
		alias
			"sizeof (GpRect)"
		end

	c_set_x (a_item: POINTER; a_x: INTEGER) is
			-- Set `a_item''s x with `a_x'
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				((GpRect *)$a_item)->X = (EIF_INTEGER)$a_x;
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
				((GpRect *)$a_item)->Y = (EIF_INTEGER)$a_y;
			}
			]"
		end

	c_set_width (a_item: POINTER; a_width: INTEGER) is
			-- Set `a_item''s width with `a_width'.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				((GpRect *)$a_item)->Width = (EIF_INTEGER)$a_width;			
			}
			]"
		end

	c_set_height (a_item: POINTER; a_height: INTEGER) is
			-- Set `a_item''s height with `a_height'.
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				((GpRect *)$a_item)->Height = (EIF_INTEGER)$a_height;
			}
			]"
		end

	c_x (a_item: POINTER): INTEGER is
			-- `a_item''s x
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((GpRect *)$a_item)->X
			]"
		end

	c_y (a_item: POINTER): INTEGER is
			-- `a_item''s y
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((GpRect *)$a_item)->Y
			]"
		end

	c_width (a_item: POINTER): INTEGER is
			-- `a_item''s width
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((GpRect *)$a_item)->Width
			]"
		end

	c_height (a_item: POINTER): INTEGER is
			-- `a_item''s height
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				((GpRect *)$a_item)->Height
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
