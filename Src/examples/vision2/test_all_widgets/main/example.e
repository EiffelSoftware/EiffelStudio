indexing
	description: 
		"Root class of Test all widgets application."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EXAMPLE

inherit
	EV_APPLICATION

creation
	make

feature -- Access

	main_window: MAIN_WINDOW is
			-- Main window of the example
		local
			arg: EV_ARGUMENT1[EV_APPLICATION]
			cmd: APPLICATION_EXIT_COMMAND
		once
			!! Result.make_top_level 
			!! cmd
			!! arg.make (Current)
			Result.add_close_command (cmd, arg);
			Result.show
		end
	
end -- class MAIN_WINDOW

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
