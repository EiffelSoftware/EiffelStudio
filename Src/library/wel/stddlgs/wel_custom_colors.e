indexing
	description: "Custom colors chosen in a choose color dialog box."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_CUSTOM_COLORS

inherit
	WEL_STRUCTURE

creation
	make

feature -- Access

	i_th_color (i: INTEGER): WEL_COLOR_REF is
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

	count: INTEGER is 16
			-- Number of colors

feature -- Element change

	set_color (a_color: WEL_COLOR_REF; i: INTEGER) is
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

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := count * c_size_of_color_ref
		end

feature {NONE} -- Implementation

	c_size_of_color_ref: INTEGER is
		external
			"C [macro <chooseco.h>]"
		alias
			"sizeof (COLORREF)"
		end

	cwel_color_palette_get_i_th_color (ptr: POINTER;
			i: INTEGER): INTEGER is
		external
			"C [macro <chooseco.h>]"
		end

	cwel_color_palette_set_i_th_color (ptr: POINTER; i: INTEGER;
			value: INTEGER) is
		external
			"C [macro <chooseco.h>]"
		end

end -- class WEL_CUSTOM_COLORS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

