
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
			-- The exmaple uses the
			-- Motif toolkit
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

	message_box: MSG_WINDOW is
			-- Popup message window
		once
			!!Result.make ("Message", main_window);
		end;

	main_window: WINDOW1 is
			-- Main window of the example
		once
			!!Result.make ("Main", a_screen)
		end;

	other_window: WINDOW2 is
			-- Secondary window of the example
		once
			!!Result.make ("Window", a_screen)
		end;

end

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

