indexing
	description: "Console fill attributes."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FILL_ATTRIBUTES_CONSTANTS

inherit
	WEL_BIT_OPERATIONS
		export
			{NONE} all
		end
		
feature -- Access

	foreground_blue: INTEGER is
			-- Add blue to foreground
		external
			"c [macro <winbase.h>]"
		alias
			"FOREGROUND_BLUE"
		end
		
	foreground_green: INTEGER is
			-- Add green to foreground
		external
			"c [macro <winbase.h>]"
		alias
			"FOREGROUND_GREEN"
		end
		
	foreground_red: INTEGER is
			-- Add red to foreground
		external
			"c [macro <winbase.h>]"
		alias
			"FOREGROUND_RED"
		end
		
	foreground_intensity: INTEGER is
			-- Increase console foreground intensity
		external
			"c [macro <winbase.h>]"
		alias
			"FOREGROUND_INTENSITY"
		end
		
	background_blue: INTEGER is
			-- Add blue to background
		external
			"c [macro <winbase.h>]"
		alias
			"BACKGROUND_BLUE"
		end
		
	background_green: INTEGER is
			-- Add green to background
		external
			"c [macro <winbase.h>]"
		alias
			"BACKGROUND_GREEN"
		end
		
	background_red: INTEGER is
			-- Add red to background
		external
			"c [macro <winbase.h>]"
		alias
			"BACKGROUND_RED"
		end
		
	background_intensity: INTEGER is
			-- Increase console background intensity
		external
			"c [macro <winbase.h>]"
		alias
			"BACKGROUND_INTENSITY"
		end

	is_valid_fill_attributes (an_integer: INTEGER): BOOLEAN is
			-- Is `an_integer' a valid fill atrtibutes?
		do
			Result := flag_set (foreground_blue + foreground_green + foreground_red + foreground_intensity +
								background_blue + background_green + background_red + background_intensity,
								an_integer)
		end

end -- class WEL_FILL_ATTRIBUTES_CONSTANTS

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

