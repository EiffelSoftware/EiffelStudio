indexing
	description: "BUTTONS_DEMO_WINDOW, demo window to test all kinds %
			%of buttons. Belongs to EiffelVision example test_all_widgets."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature -- Access

	main_widget: EV_VERTICAL_BOX is
			-- The main widget of the demo
		once
			create Result.make (Current)
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
			-- Set the widgets in the demo windows.
		do
			main_widget.set_homogeneous (False)
			create b1.make_with_text (main_widget, "Button")
			
--			!! pixmap.make_from_file (the_parent.pixname("power_small"))
			create b2.make (main_widget)
--			!! pixmap.make_from_file (the_parent.pixname("power_small"))
			create toggle_b.make_with_text (main_widget, "Toggle Button")
			create check_b.make_with_text (main_widget, "Check Button")

			create frame.make_with_text (main_widget, "Frame")
			frame.set_foreground_color (blue)
			create box.make (frame)
			create radio1_b.make_with_text (box, "Radio 1")
			create radio2_b.make_with_text (box, "Radio 2")
			create radio3_b.make_with_text (box, "Radio 3")
       	end

	set_values is
			-- Set the values on the widgets of the window.
		do
			set_title ("All buttons demo")
		end

feature -- Color

	blue: EV_COLOR is
		do
			create Result.make_rgb (0, 0, 255)
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


end -- class BUTTONS_DEMO_WINDOW

