indexing
	description: 
		"TEXT_FIELD_DEMO_WINDOW, demo window to test%
		% text_field widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	TEXT_FIELD_DEMO_WINDOW

inherit
	DEMO_WINDOW
		redefine
			main_widget,
			set_widgets,
			set_values
		end

create
	make

feature -- Access

	main_widget: EV_VERTICAL_BOX is
			-- The main widget of the demo
		once
			create Result.make (Current)
		end

	TextField: EV_TEXT_FIELD
			-- A text field in the demo

	PasswordField: EV_PASSWORD_FIELD
			-- A password field

feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		local
			frame: EV_FRAME
		do
			create frame.make_with_text (main_widget, "A Text Field")
			create textfield.make_with_text (frame, "Edit me")
			create frame.make_with_text (main_widget, "A Password Field")
			create passwordfield.make_with_text (frame, "Me too")
		end
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Text field demo")
		end
	
end -- class TEXT_FIELD_DEMO_WINDOW

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

