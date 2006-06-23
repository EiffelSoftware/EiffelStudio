indexing
	description: "Gdi+ unit enumeration."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_UNIT

feature -- Enumerations

    UnitWorld: INTEGER is 0
    		-- World coordinate (non-physical unit)

    UnitDisplay: INTEGER is 1
    		-- Variable -- for PageTransform only

    UnitPixel: INTEGER is 2
    		-- Each unit is one device pixel.

    UnitPoint: INTEGER is 3
    		-- Each unit is a printer's point, or 1/72 inch.

    UnitInch: INTEGER is 4
    		-- Each unit is 1 inch.

    UnitDocument: INTEGER is 5
    		-- Each unit is 1/300 inch.

    UnitMillimeter: INTEGER is 6
    		-- Each unit is 1 millimeter.

feature -- Query

	is_valid (a_unit: INTEGER): BOOLEAN is
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

end
