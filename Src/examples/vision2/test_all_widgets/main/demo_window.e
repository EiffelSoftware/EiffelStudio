indexing
	description: 
		"DEMO_WINDOW class, base class for all demo windows.%
		% Belongs to EiffelVision example test_all_widgets."
	status: "See notice at end of class"
	note: "A demo window is an empty window, features must be redefine to have a full window."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	DEMO_WINDOW

inherit
	EV_WINDOW
		redefine	
			make
		end

creation
	make

feature -- Initialization
	
	make (par: MAIN_WINDOW) is
		do
			the_parent := par
			{EV_WINDOW} Precursor (the_parent)
			set_widgets
			set_values
		end
	
feature -- Access

	main_widget: EV_WIDGET is
			-- The main widget of the demo
		do
		end
	
	actions_window: ACTIONS_WINDOW
			-- Actions window related to this demo

	effective_button: EV_TOGGLE_BUTTON
			-- Button which was pressed when this demo 
			-- window was opened

	the_parent: MAIN_WINDOW
			-- The parent window of the current one

feature -- Status setting
        
	set_widgets is
			-- Set the widgets in the demo windows.
			-- Need to be redefine.
		do
		end
	
	set_values is
			-- Set the values on the widgets of the window.
			-- Need to be redefine.
 		do
 		end

	set_effective_button (but: EV_TOGGLE_BUTTON) is
			-- Make `but' the new `effective_button'.
		do
			effective_button := but
		end

feature -- Show the window
	
	activate (win: MAIN_WINDOW) is
		local
			arg1: EV_ARGUMENT1[DEMO_WINDOW]
			arg2: EV_ARGUMENT1[EV_WIDGET]
			cmd: DESTROY_COMMAND
		do
			show
			!! actions_window.make_with_main_widget (Current, main_widget)
			actions_window.show
			!! cmd
			!! arg2.make (actions_window)
			actions_window.add_close_command (cmd, arg2)
			win.set_insensitive (True)
			!! arg1.make (Current)
			add_close_command (win, arg1)
		end

end -- class DEMO_WINDOW

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
