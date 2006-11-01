indexing
	description: 
		"FIXED_DEMO_WINDOW, demo window to test fixed widget.%
		% Belongs to EiffelVision example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature -- Access

	main_widget: EV_FIXED is
			-- The main widget of the demo
		once
			create Result.make (Current)
			Result.set_minimum_size(300,300)
		end

	button1, button2: EV_BUTTON
			-- Two buttons for the demo

feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		do
			create button1.make (main_widget)
			create button2.make (main_widget)
		end
	
feature -- Status setting
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Fixed demo")
			button1.set_text ("Press me")
			button1.add_click_command (Current, Void)
			button2.set_text ("Me too!")
			button1.set_x_y (10, 20)
			button2.set_x_y (10, 50)
		end

feature -- Command execution

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Executed when we press the first button
		do
			button2.set_x_y (button2.x + 10, button2.y + 10)
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


end -- class FIXED_DEMO_WINDOW

