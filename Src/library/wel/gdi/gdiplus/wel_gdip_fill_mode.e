indexing
	description: "[
					Enumeration specifies how the interior of a closed path is filled.
					Please see MSDN:
					http://msdn.microsoft.com/en-us/library/system.drawing.drawing2d.fillmode.aspx				
																									]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_FILL_MODE

feature -- Enumeration

	Alternate: INTEGER is 0
			-- Specifies the alternate fill mode.

	Winding: INTEGER is 1
			-- Specifies the winding fill mode.

feature -- Query

	is_valid (a_int: INTEGER): BOOLEAN is
			-- If `a_int' valid?
		do
			Result := a_int = Alternate
				or a_int = Winding
		end

;indexing
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
