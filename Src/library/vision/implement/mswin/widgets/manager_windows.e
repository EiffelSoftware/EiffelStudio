indexing
	description: "This class represents a MS_WINDOWS manager";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class MANAGER_WINDOWS

inherit
	COMPOSITE_WINDOWS

	MANAGER_I

	COLORED_FOREGROUND_WINDOWS

feature {NONE} -- Implementation

	class_background: WEL_BRUSH is
			-- Default background.
		local
			windows_color: WEL_COLOR_REF
		do
			if private_background_color = Void then
				!! Result.make_by_sys_color (Color_window + 1)
			else
				windows_color ?= private_background_color.implementation
				!! Result.make_solid (windows_color)
			end
		end

end -- class MANAGER_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------
