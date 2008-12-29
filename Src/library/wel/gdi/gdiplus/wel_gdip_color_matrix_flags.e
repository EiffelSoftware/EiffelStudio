note
	description: "Gdi+ color matrix flags enumeration."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_COLOR_MATRIX_FLAGS

feature -- Enumeration

    ColorMatrixFlagsDefault: INTEGER = 0
    		-- ColorMatrixFlagsDefault

    ColorMatrixFlagsSkipGrays: INTEGER = 1
    		-- ColorMatrixFlagsSkipGrays

    ColorMatrixFlagsAltGray: INTEGER = 2
    		-- ColorMatrixFlagsAltGray

feature -- Query

	is_valid (a_flag: INTEGER): BOOLEAN
			-- If `a_flag' valid?
		do
			Result := a_flag = ColorMatrixFlagsDefault or
				a_flag = ColorMatrixFlagsSkipGrays or
				a_flag = ColorMatrixFlagsAltGray
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
