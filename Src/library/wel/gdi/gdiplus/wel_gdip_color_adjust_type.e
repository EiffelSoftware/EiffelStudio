indexing
	description: "Gdi+ Color adjust type enumeration."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
