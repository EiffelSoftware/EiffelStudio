indexing
	description: "Brush style (BS) constants."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_BRUSH_STYLE_CONSTANTS

feature -- Access

	Bs_solid: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BS_SOLID"
		end

	Bs_null: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BS_NULL"
		end

	Bs_hollow: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BS_HOLLOW"
		end

	Bs_hatched: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BS_HATCHED"
		end

	Bs_pattern: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BS_PATTERN"
		end

	Bs_indexed: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BS_INDEXED"
		end

	Bs_dibpattern: INTEGER is
		external
			"C [macro %"wel.h%"]"
		alias
			"BS_DIBPATTERN"
		end

end -- class WEL_BRUSH_STYLE_CONSTANTS

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

