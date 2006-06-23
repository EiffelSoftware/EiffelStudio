indexing
	description: "Gdi+ Color adjust type enumeration."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_COLOR_ADJUST_TYPE

feature -- Enumeration

    ColorAdjustTypeDefault: INTEGER is 0
			-- ColorAdjustTypeDefault

    ColorAdjustTypeBitmap: INTEGER is 1
			-- ColorAdjustTypeBitmap

    ColorAdjustTypeBrush: INTEGER is 2
			-- ColorAdjustTypeBrush

    ColorAdjustTypePen: INTEGER is 3
			-- ColorAdjustTypePen

    ColorAdjustTypeText: INTEGER is 4
			-- ColorAdjustTypeText

    ColorAdjustTypeCount: INTEGER is 5
			-- ColorAdjustTypeCount

    ColorAdjustTypeAny: INTEGER is 6
    		-- ColorAdjustTypeAny, reserved.

feature -- Query

	is_valid (a_type: INTEGER): BOOLEAN is
			-- If `a_type' valid?
		do
			Result := a_type = ColorAdjustTypeDefault or
				a_type = ColorAdjustTypeBitmap or
				a_type = ColorAdjustTypeBrush or
				a_type = ColorAdjustTypePen or
				a_type = ColorAdjustTypeText or
				a_type = ColorAdjustTypeCount or
				a_type = ColorAdjustTypeAny
		end

end
