note
	description: "Gdi+ unit enumeration."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_UNIT

feature -- Enumerations

    UnitWorld: INTEGER = 0
    		-- World coordinate (non-physical unit)

    UnitDisplay: INTEGER = 1
    		-- Variable -- for PageTransform only

    UnitPixel: INTEGER = 2
    		-- Each unit is one device pixel.

    UnitPoint: INTEGER = 3
    		-- Each unit is a printer's point, or 1/72 inch.

    UnitInch: INTEGER = 4
    		-- Each unit is 1 inch.

    UnitDocument: INTEGER = 5
    		-- Each unit is 1/300 inch.

    UnitMillimeter: INTEGER = 6
    		-- Each unit is 1 millimeter.

feature -- Query

	is_valid (a_unit: INTEGER): BOOLEAN
			-- If `a_unit' valid?
		do
			Result := a_unit = unitworld or
				a_unit = unitdisplay or
				a_unit = unitpixel or
				a_unit = unitpoint or
				a_unit = unitinch or
				a_unit = unitdocument or
				a_unit = unitmillimeter
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

end
