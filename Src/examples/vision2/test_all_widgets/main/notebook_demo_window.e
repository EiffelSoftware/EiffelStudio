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

	button1: EV_BUTTON
	p1, p2: EV_PIXMAP
			-- Push buttons
feature -- Status setting
	
	set_widgets is
		do
			!!button1.make (main_widget)
			!! p1.make_from_file (main_widget, "../pixmaps/vision.xpm")
			!! p2.make_from_file (main_widget, "../pixmaps/vision_tower.xpm")
		end
	
feature -- Status setting
	
	set_values is
		do
			set_title ("Notebook demo")
			button1.set_text ("Button")
			main_widget.append_page (button1, "Button")
			main_widget.append_page (p1, "Pixmap 1")
			main_widget.append_page (p2, "Pixmap 2")
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
