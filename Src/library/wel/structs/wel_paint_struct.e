indexing
	description: "Contains information about the Wm_paint message."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_PAINT_STRUCT

inherit
	WEL_STRUCTURE

creation
	make

feature -- Access

	erase: BOOLEAN is
			-- Must the background be erased?
		do
			Result := cwel_paintstruct_get_ferase (item)
		end

	rect_paint: WEL_RECT is
			-- Rectangle that specifies which part
			-- must be painted.
		do
			create Result.make_by_pointer (
				cwel_paintstruct_get_rcpaint (item))
		ensure
			result_not_void: Result /= Void
		end

feature -- Measurement

	structure_size: INTEGER is
			-- Size to allocate (in bytes)
		once
			Result := c_size_of_paintstruct
		end

feature {NONE} -- Externals

	c_size_of_paintstruct: INTEGER is
		external
			"C [macro <paint.h>]"
		alias
			"sizeof (PAINTSTRUCT)"
		end

	cwel_paintstruct_get_ferase (ptr: POINTER): BOOLEAN is
		external
			"C [macro <paint.h>]"
		end

	cwel_paintstruct_get_rcpaint (ptr: POINTER): POINTER is
		external
			"C [macro <paint.h>] (PAINTSTRUCT*): EIF_POINTER"
		end

end -- class WEL_PAINT_STRUCT


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

