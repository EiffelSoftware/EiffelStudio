indexing
	description: "Up-Down control message (UDM) constants."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_UDM_CONSTANTS

feature -- Access

	Udm_getaccel: INTEGER is
			-- Retrieves acceleration information for an up-down
			-- control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDM_GETACCEL"
		end

	Udm_getbase: INTEGER is
			-- Retrieves the current radix base (that is, either
			-- base 10 or 16) for an up-down control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDM_GETBASE"
		end

	Udm_getbuddy: INTEGER is
			-- Retrieves the handle of the current buddy window.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDM_GETBUDDY"
		end

	Udm_getpos: INTEGER is
			-- Retrieves the current position of an up-down control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDM_GETPOS"
		end

	Udm_getrange: INTEGER is
			-- Retrieves the minimum and maximum positions (range)
			-- for an up-down control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDM_GETRANGE"
		end
		
	Udm_getrange32: INTEGER is
			-- Retrieves the minimum and maximum positions (range)
			-- for an up-down control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDM_GETRANGE32"
		end
		
	Udm_setaccel: INTEGER is
			-- Sets the acceleration for an up-down control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDM_SETACCEL"
		end

	Udm_setbase: INTEGER is
			-- Sets the radix base for an up-down control. The
			-- base value determines whether the buddy window
			-- displays numbers in decimal or hexadecimal digits.
			-- Hexadecimal numbers are always unsigned, and decimal
			-- numbers are signed.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDM_SETBASE"
		end

	Udm_setbuddy: INTEGER is
			-- Sets the buddy window for an up-down control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDM_SETBUDDY"
		end

	Udm_setpos: INTEGER is
			-- Sets the current position for an up-down control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDM_SETPOS"
		end
		
	Udm_setrange: INTEGER is
			-- Sets the minimum and maximum positions (range) for
			-- an up-down control.
		external
			"C [macro %"cctrl.h%"]"
		alias
			"UDM_SETRANGE"
		end
		
	Udm_setrange32: INTEGER is 1135
			-- Sets the minimum and maximum positions (range) for
			-- an up-down control.
		
	Udm_getpos32: INTEGER is 1138
			-- Retrieves the current position of an up-down control.
			
	Udm_setpos32: INTEGER is 1137;
			-- Sets the current position of an up-down control.

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




end -- class WEL_UDM_CONSTANTS

