indexing
	description: "BUTTONS_DEMO_WINDOW, demo window to test all kinds %
			%of buttons. Belongs to EiffelVision example test_all_widgets."
	status: "See notice at end of class"
	id: "$$"
	date: "$$"
	revision: "$$"
	
class 
	BUTTONS_DEMO_WINDOW

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

	main_widget: EV_VERTICAL_BOX is
		once
			!!Result.make (Current)
		end
	
feature -- Access

	b1, b2, b3, b4: EV_BUTTON
	pixmap: EV_PIXMAP
	
	toggle_b: EV_TOGGLE_BUTTON

	check_b: EV_CHECK_BUTTON

	radio1_b: EV_RADIO_BUTTON
	radio2_b: EV_RADIO_BUTTON
	radio3_b: EV_RADIO_BUTTON

	frame: EV_FRAME
	box: EV_VERTICAL_BOX

feature -- Status setting
        
	set_widgets is
		local
			a: EV_ARGUMENT1[BUTTONS_DEMO_WINDOW]
		do
			main_widget.set_homogeneous (False)
			!! b1.make_with_text (main_widget, "Button")
			
			!! pixmap.make_from_file (b1, the_parent.pixname("power_small"))
			!! b2.make (main_widget)
			!! pixmap.make_from_file (b2, the_parent.pixname("power_small"))
			!! toggle_b.make_with_text (main_widget, "Toggle Button")
			!! check_b.make_with_text (main_widget, "Check Button")
			--!! pixmap.make_from_file (check_b, "pixmaps/power_small")

			!! frame.make_with_text (main_widget, "Frame")
			frame.set_foreground_color (blue)
			!! box.make (frame)
			!! radio1_b.make_with_text (box, "Radio 1")
			!! radio2_b.make_with_text (box, "Radio 2")
			!! radio3_b.make_with_text (box, "Radio 3")
			!! a.make (Current)
			toggle_b.add_destroy_command (Current, a)
        	end

	
	set_values is
		do
			set_title ("All buttons demo")
		end

	execute (arg: EV_ARGUMENT1[BUTTONS_DEMO_WINDOW]; data: EV_EVENT_DATA) is
			-- test command
		local
			b: EV_VERTICAL_BOX
		do
			b := box
 		end

feature -- Color

	blue: EV_COLOR is
		do
			!! Result.make_rgb (0, 0, 255)
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
