indexing

	description: 
	"NOTEBOOK_DEMO_WINDOW, demo window to test notebook widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	NOTEBOOK_DEMO_WINDOW

inherit

	DEMO_WINDOW
	

creation

	make

feature -- Access

	main_widget: EV_NOTEBOOK is
		once
			!!Result.make (Current)
		end
	
feature -- Access

	button1,
	button2,
	button3,
	button4: EV_BUTTON
			-- Push buttons
feature -- Status setting
	
	set_widgets is
		do
			!!button1.make (main_widget)
			!!button2.make (main_widget)
			!!button3.make (main_widget)
			!!button4.make (main_widget)
		end
	
feature -- Status setting
	
	set_values is
		do
			set_title ("Notebook demo")
			button1.set_text ("1")
			button2.set_text ("2")
			button3.set_text ("3")
			button3.set_height (40)
			button4.set_text ("4")
			main_widget.append_page (button1, "Page 1")
			main_widget.append_page (button2, "Page 2")
			main_widget.append_page (button3, "Page 3")
			main_widget.append_page (button4, "Page 4")
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
