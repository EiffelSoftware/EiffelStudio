indexing

	description: 
	"ACTIONS_WINDOW, base class for all actions windows. Belongs to EiffelVision example test_all_widgets."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	ACTIONS_WINDOW
	
inherit
	
	EV_WINDOW
	
	
creation
	
	make_with_main_widget

feature -- Access
	
	Default_string_length: INTEGER is 5;
	
	
	box: EV_HORIZONTAL_BOX 
	show_button, hide_button: EV_BUTTON
	width_entry, height_entry: EV_ENTRY
	
	widget: EV_WIDGET

feature -- Initialization
	
	make_with_main_widget (main_widget: EV_WIDGET) is
		do
			make
			widget := main_widget
			set_widgets
			set_values
			set_commands
		end
	
feature -- Status setting
        
	set_widgets is
			-- Create the widgets inside the window
                do
			
			!!box.make (Current)
			!!show_button.make (box)
			!!hide_button.make (box)
			!!width_entry.make (box)
			!!height_entry.make (box)
                end
	
	set_values is
		local
			s: STRING
 		do
			set_title ("Control widget behavior")
			show_button.set_text ("Show")
			hide_button.set_text ("Hide")
			!!s.make (Default_string_length)
			s.append_integer (widget.width)
			width_entry.set_text (s)
			s.wipe_out
			s.append_integer (widget.height)
			height_entry.set_text (s)
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
