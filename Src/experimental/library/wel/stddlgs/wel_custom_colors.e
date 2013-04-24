note
	description: "Custom colors chosen in a choose color dialog box."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CUSTOM_COLORS

inherit
	WEL_STRUCTURE

create
	make

feature -- Access

	i_th_color (i: INTEGER): WEL_COLOR_REF
			-- Color at the position `i'
		require
			i_large_enough: i >= 1
			i_small_enough: i <= count
		do
			create Result.make_by_color (
				cwel_color_palette_get_i_th_color (item, i - 1))
		ensure
			result_not_void: Result /= Void
		end

	count: INTEGER = 16
			-- Number of colors

feature -- Element change

	set_color (a_color: WEL_COLOR_REF; i: INTEGER)
			-- Set `a_color' at the position `i'.
		require
			i_large_enough: i >= 1
			i_small_enough: i <= count
			a_color_exists: a_color /= Void
		do
			cwel_color_palette_set_i_th_color (item, i - 1,
				a_color.item)
		ensure
			color_set: i_th_color (i).is_equal (a_color)
		end

feature -- Measurement

	structure_size: INTEGER
			-- Size to allocate (in bytes)
		once
			Result := count * c_size_of_color_ref
		end

feature {NONE} -- Implementation

	c_size_of_color_ref: INTEGER
		external
			"C [macro <chooseco.h>]"
		alias
			"sizeof (COLORREF)"
		end

	cwel_color_palette_get_i_th_color (ptr: POINTER;
			i: INTEGER): INTEGER
		external
			"C [macro <chooseco.h>]"
		end

	cwel_color_palette_set_i_th_color (ptr: POINTER; i: INTEGER;
			value: INTEGER)
		external
			"C [macro <chooseco.h>]"
		end

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




end -- class WEL_CUSTOM_COLORS

