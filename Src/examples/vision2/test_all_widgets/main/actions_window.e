indexing

	description: 
	"ACTIONS_WINDOW, base class for all actions windows. Belongs to EiffelVision example test_all_widgets."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	ACTIONS_WINDOW
	
creation
	
	make

feature -- Access
	
	window: EV_WINDOW
	
	box: EV_HORIZONTAL_BOX 
	show_button, hide_button: EV_BUTTON
	
	widget: EV_WIDGET

feature -- Initialization
	
	make (main_widget: EV_WIDGET) is
		do
			widget := main_widget
			set_widgets
			set_values
			set_commands
		end
	
feature -- Status setting
        
	set_widgets is
			-- Create the widgets inside the window
                do
			!!window.make
			!!box.make (window)
			!!show_button.make (box)
			!!hide_button.make (box)
                end
	
	set_values is
 		do
			show_button.set_text ("Show")
			hide_button.set_text ("Hide")
 		end

 	set_commands is
		local
			hide_c: HIDE_COMMAND
			show_c: SHOW_COMMAND
			e: EV_EVENT
			a: EV_ARGUMENT1 [EV_WIDGET]
 		do
			!!hide_c
			!!show_c
			!!e.make ("clicked")
			!!a.make (widget)
			show_button.add_command (e, show_c, a)
			hide_button.add_command (e, hide_c, a)
 		end
	
feature
	
	show is
			-- show the window
		do
			window.show
		end
	
feature -- Command executing
	
	execute (argument: EV_ARGUMENT1[STRING]) is
		do
			show
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
