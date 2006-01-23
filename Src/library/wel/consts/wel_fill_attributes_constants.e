indexing
	description: "Console fill attributes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_FILL_ATTRIBUTES_CONSTANTS

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
			Result := an_integer = (an_integer & (foreground_blue | foreground_green | foreground_red |
				foreground_intensity | background_blue | background_green |
				background_red | background_intensity))
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




end -- class WEL_FILL_ATTRIBUTES_CONSTANTS

