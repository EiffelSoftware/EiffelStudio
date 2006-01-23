indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."

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
			create Result.make ("");
		end;

	init_toolkit: TOOLKIT_IMP is
			-- The exmaple uses the
			-- Motif toolkit
		once
			create Result.make ("");
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
			create Result.make ("Message", main_window);
		end;

	main_window: WINDOW1 is
			-- Main window of the example
		once
			create Result
			Result.make ("Main", a_screen)
		end;

	other_window: WINDOW2 is
			-- Secondary window of the example
		once
			create Result.make ("Window", a_screen)
		end;

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


end

