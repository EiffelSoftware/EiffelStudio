indexing

	description: 
		"Root class of Hello World application."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class EXAMPLE

inherit

	EV_APPLICATION

creation

	make

feature

	main_window: MAIN_WINDOW is
			-- Main window of the example
		local
			a: EV_ARGUMENT1[EV_APPLICATION]
			exit_c: APPLICATION_EXIT_COMMAND
			dummy1: EV_MESSAGE_DIALOG
			--dummy2: EV_COLOR_SELECTION_DIALOG
			--dummy3: EV_ERROR_DIALOG
			--dummy4: EV_FILE_OPEN_DIALOG
			--dummy5: EV_FILE_SAVE_DIALOG
			--dummy6: EV_FILE_SELECTION_DIALOG
			--dummy7: EV_FONT_SELECTION_DIALOG
			dummy8: EV_INFORMATION_DIALOG
			--dummy9: EV_INPUT_DIALOG
			--dummy10: EV_PRINT_DIALOG
			dummy11: EV_QUESTION_DIALOG
			dummy12: EV_WARNING_DIALOG
		once
			!!Result.make_top_level 
			!!exit_c
			!!a.make (Current)
			Result.add_close_command(exit_c, a);
			Result.show
		end
	
end

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



