indexing

	description: 
	"FIXED_DEMO_WINDOW, demo window to test fixed widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	FIXED_DEMO_WINDOW

inherit

	DEMO_WINDOW
		redefine
			main_widget,
			set_widgets,
			set_values
		end
	
	EV_COMMAND

creation

	make

feature -- Access

	main_widget: EV_FIXED is
		once
			!!Result.make (Current)
			Result.set_minimum_size(300,300)
		end

feature -- Access

	button1: EV_BUTTON
	button2: EV_BUTTON
			-- Push buttons
feature -- Status setting
	
	set_widgets is
		do
			!!button1.make (main_widget)
			!!button2.make (main_widget)
		end
	
feature -- Status setting
	
	set_values is
		do
			set_title ("Fixed demo")
			button1.set_text ("Press me")
			button1.add_click_command (Current, Void)
			button2.set_text ("Me too!")
			button1.set_x_y (10, 20)
			button2.set_x_y (10, 50)
		end


	set_commands is
		local
		--	c: HELLO_COMMAND
			e: EV_EVENT
			a: EV_ARGUMENT1 [STRING]
		do
		--	!!e.make ("clicked")
		--	!!a.make (button.text)
		--	!!c
		--	button.add_command (e, c, a)
		end

feature -- Execute

	execute (arg: EV_ARGUMENTS; data: EV_EVENT_DATA) is
		do
			button2.set_x_y (button2.x + 10, button2.y + 10)
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
