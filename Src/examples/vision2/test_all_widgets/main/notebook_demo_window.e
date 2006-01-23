indexing
	description: 
		"NOTEBOOK_DEMO_WINDOW, demo window to test notebook widget.%
		% Belongs to EiffelVision example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class 
	NOTEBOOK_DEMO_WINDOW

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

	main_widget: EV_NOTEBOOK is
			-- The main widget of the demo
		once
			create Result.make (Current)
		end
	
feature -- Access

	button1, button_box: EV_BUTTON
		-- Buttons for the demo

	box: EV_VERTICAL_BOX
		-- Box for the demo
	
feature -- Status setting
	
	set_widgets is
			-- Set the widgets in the demo windows.
		do
			create button1.make (main_widget)
			create box.make (main_widget)
			create button_box.make_with_text (box, "button 1")
			create button_box.make_with_text (box, "button 2")
			create button_box.make_with_text (box, "button 3")
			create button_box.make_with_text (box, "button 4")
		end
	
feature -- Status setting
	
	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("Notebook demo")
			button1.set_text ("Button")			
			main_widget.append_page (button1, "Button")
			main_widget.append_page (box, "Pixmap 2")
			main_widget.set_current_page (2)
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


end -- class NOTEBOOK_DEMO_WINDOW

