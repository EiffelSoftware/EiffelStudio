note
	description: "Point for a GIF structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	GIF_POINT

inherit
	DISPOSABLE

create
	make

feature -- Initialization

	make (x1,y1: INTEGER)
			-- Initialize
		require
			x_positive: x1 >= 0
			y_positive: y1 >= 0
		do
			internal_make
			set_x(x1)
			set_y(y1)
		end

feature -- Internal Structure 

	internal_make
			-- Allocate `item'
		do
			item := c_alloc (1, c_size_of_point)
			if item = default_pointer then
				-- Memory allocation problem
				c_enomem
			end
			--shared := False
		end

	set_x ( i: INTEGER )
			-- Set coord x with 'i'
		require
			possible: i>=0
		do
			c_point_set_x(item, i) 
		end

	set_y (i: INTEGER )
			-- Set coord y with 'i'
		require
			possible: i>=0
		do
			c_point_set_y(item,i)
		end

feature -- Access

	get_x: INTEGER
			-- Get coord x of Current
		do
			Result := c_point_get_x(item)
		end

	get_y: INTEGER
			-- Get coord y of Current
		do
			Result := c_point_get_y(item)
		end

feature {GIF_POINT, GIF_IMAGE} -- Implementation
	
	x,y: INTEGER
		-- Coordinates of Current.

	item: POINTER

	dispose
			-- Free C Structure that Current encapsulates
		do
			free(item)	
		end

feature {NONE} -- Externals

	c_alloc (a_num, a_size: INTEGER): POINTER
		-- C calloc
		external
			"C (size_t, size_t): EIF_POINTER | <malloc.h>"
		alias
			"calloc"
		end

	c_free (p: POINTER)
		-- Free C Structure that Current encapsulates
		external
			"C"
		alias
			"free"
		end

	c_point_get_x (p: POINTER): INTEGER
		-- Get x
		external
			"C [macro <gif_point.h>]"
		end

	c_point_get_y (p: POINTER): INTEGER
		-- Get x
		external
			"C [macro <gif_point.h>]"
		end


	c_point_set_x (p: POINTER; i: INTEGER)
		-- Set x
		external
			"C [macro <gif_point.h>]"
		end

	c_point_set_y (p: POINTER; i: INTEGER)
		-- Set x
		external
			"C [macro <gif_point.h>]"
		end


	c_size_of_point: INTEGER
		external
			"C [macro <gif_point.h>]"
		alias
			"sizeof (gdPoint)"
		end

	c_enomem
			-- Eiffel run-time function to raise an
			-- "Out of memory" exception.
		external
			"C | %"eif_except.h%""
		alias
			"enomem"
		end

invariant
	item_exists: item /= DEFAULT_POINTER

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class GIF_POINT
