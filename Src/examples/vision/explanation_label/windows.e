indexing
	description: "Example windows and once routines";
	date: "$Date$";
	revision: "$Revision$"

class WINDOWS

inherit
	GRAPHICS
		redefine
			init_toolkit
		end

feature

	a_screen: SCREEN is
			-- Screen associated with
			-- program
		once
			!!Result.make ("");
		end;

	init_toolkit: TOOLKIT_IMP is
			-- Toolkit for current platform
		once
			!!Result.make ("");
		end;

	init_windowing is
			-- Initialize the toolkit.
			-- (force call to once routines).
		do
			if (init_toolkit = Void) then end;
			if (toolkit = Void) then end;
		end;

	main_window: MAIN_WINDOW is
			-- Main window of the demo
		once
			!!Result.make ("Focusables demo", a_screen)
		end;

end -- class WINDOWS


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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

