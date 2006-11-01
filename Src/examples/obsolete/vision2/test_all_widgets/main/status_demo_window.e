indexing
	description: 
		" STATUS_DEMO_WINDOW, demo window to test a status bar%
		% widget. Belongs to EiffelVision example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature -- Access

	main_widget: EV_FIXED is
			-- The main widget of the demo
		once
			create Result.make (Current)
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
			create status.make (Current)
			create sbi.make_with_text (status, "Item 1")
			create sbi.make (status)
			sbi.set_width (100)
			sbi.set_text ("Sad Item 2")
			create sbi.make_with_text (status, "Item 3")

			create sb.make (Current)
			create menu.make_with_text (sb, "&Premiere")
			create menu.make_with_text (sb, "&Seconde")
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
			create arg1.make (Current)
			add_close_command (win, arg1)
	end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class TEXT_FIELD_DEMO_WINDOW

