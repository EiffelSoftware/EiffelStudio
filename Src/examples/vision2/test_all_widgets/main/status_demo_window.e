indexing
	description: 
		" STATUS_DEMO_WINDOW, demo window to test a status bar%
		% widget. Belongs to EiffelVision example."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	STATUS_DEMO_WINDOW

inherit
	DEMO_WINDOW
		redefine
			main_widget,
			set_widgets,
			set_values,
			activate
		end

creation
	make

feature -- Access

	main_widget: EV_FIXED is
			-- The main widget of the demo
		once
			!!Result.make (Current)
		end

	status: EV_STATUS_BAR
			-- A text field in the demo

feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		local
			sbi: EV_STATUS_BAR_ITEM
			sb: EV_STATIC_MENU_BAR
			menu: EV_MENU
			s: STRING
			i: INTEGER
		do
			!! status.make (Current)
			!! sbi.make_with_text (status, "Item 1")
			!! sbi.make (status)
			sbi.set_width (100)
			sbi.set_text ("Sad Item 2")
			!! sbi.make_with_text (status, "Item 3")

			!! sb.make (Current)
			!! menu.make_with_text (sb, "&Premiere")
			!! menu.make_with_text (sb, "&Seconde")
		end
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Status bar demo")
		end

feature -- Show the window
	
	activate (win: MAIN_WINDOW) is
		local
			arg1: EV_ARGUMENT1[DEMO_WINDOW]
		do
			show
			win.set_insensitive (True)
			!! arg1.make (Current)
			add_close_command (win, arg1)
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

