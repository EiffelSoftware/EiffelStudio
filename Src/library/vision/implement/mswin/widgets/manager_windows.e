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
			windows_color: COLOR_WINDOWS
		do
			if private_background_color = Void then
				!! Result.make_by_sys_color (Color_window + 1)
			else
				windows_color ?= private_background_color.implementation
				Result := windows_color.brush
			end
		end

end -- class MANAGER_WINDOWS

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1997 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
