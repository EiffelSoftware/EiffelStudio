indexing
	description: "ALL_BUTTON_DEMO_WINDOW, demo window to test all kinds %
			%of buttons. Belongs to EiffelVision example test_all_widgets."
	status: "See notice at end of class"
	id: "$$"
	date: "$$"
	revision: "$$"
	
class 
	ALL_BUTTON_DEMO_WINDOW

inherit
	
	DEMO_WINDOW
	
creation
	make


feature -- Access

	main_widget: EV_VERTICAL_BOX is
		once
			!!Result.make (Current)
		end
	
feature -- Access

	but: EV_BUTTON
		
	toggle_b: EV_TOGGLE_BUTTON

	check_b: EV_CHECK_BUTTON

	radio_b: EV_RADIO_BUTTON


feature -- Status setting
        
	set_widgets is
		do
			!! but.make_with_text (main_widget, "Button")
			!! toggle_b.make_with_text (main_widget, "Toggle Button")
			!! check_b.make_with_text (main_widget, "Check Button")
			!! radio_b.make_with_text (main_widget, "Radio Button")
        	end

	
	set_values is
		do
			set_title ("All buttons demo")
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
