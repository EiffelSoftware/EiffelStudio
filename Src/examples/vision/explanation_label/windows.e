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

	init_toolkit: MS_WINDOWS is
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

