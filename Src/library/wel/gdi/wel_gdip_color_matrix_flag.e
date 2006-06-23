indexing
	description: "Gdi+ color matrix flags enumeration."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_COLOR_MATRIX_FLAGS

feature -- Enumeration

    ColorMatrixFlagsDefault: INTEGER is 0
    		-- ColorMatrixFlagsDefault

    ColorMatrixFlagsSkipGrays: INTEGER is 1
    		-- ColorMatrixFlagsSkipGrays

    ColorMatrixFlagsAltGray: INTEGER is 2
    		-- ColorMatrixFlagsAltGray

feature -- Query

	is_valid (a_flag: INTEGER): BOOLEAN is
			-- If `a_flag' valid?
		do
			Result := a_flag = ColorMatrixFlagsDefault or
				a_flag = ColorMatrixFlagsSkipGrays or
				a_flag = ColorMatrixFlagsAltGray
		end

end
