indexing

	description: 
	"MULTI_LINE_ENTRY_DEMO_WINDOW, demo window to test multi line entry widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	MULTI_LINE_ENTRY_DEMO_WINDOW

inherit

	DEMO_WINDOW
	

creation

	make

feature -- Access

	main_widget: EV_MULTI_LINE_ENTRY is
		once
			!!Result.make (Current)
		end
	

feature -- Status setting
	
	set_widgets is
		do
			main_widget.show
		end
	
	set_values is
		do
			set_title ("Multi line entry demo")
--			main_widget.set_text ("edit me")
--			main_widget.set_height (40)
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
