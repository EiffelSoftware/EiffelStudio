indexing

	description: 
		"Root class for eiffelcase using the MOTIF toolkit%
		%and NO license manager.";
	date: "$Date$";
	revision: "$Revision $"

class ECASE_WINDOWS

inherit

	ECASE
		rename
			make as old_make

		redefine
			init_toolkit, refresh_background
		end
creation 

	make

feature -- Properties

	make is 
	do
		old_make
	--	init_toolkit.message_loop2
		after_present
	end

	refresh_background is 
	do
		c_refresh_background ( default_pointer, default_pointer , FALSE )
	end

	c_refresh_background(hwnd, a_rect: POINTER;
			erase_background: BOOLEAN) is
			-- SDK InvalidateRect
		external
			"C [macro <wel.h>] (HWND, RECT *, BOOL)"
		alias
			"InvalidateRect"
		end

	init_toolkit: ECASE_MS_WINDOWS is
			-- Initalize the toolkit using MOTIF
		once
			!! Result.make ("")
		end

end -- class ECASE_WINDOWS
