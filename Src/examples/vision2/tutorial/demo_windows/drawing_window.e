indexing
	description:
		"The demo that goes with the button demo";
	date: "$Date$";
	revision: "$Revision$"

class
	DRAWING_WINDOW

inherit
	EV_DRAWING_AREA
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [BOOLEAN]
			color: EV_COLOR
			menu: EV_MENU_ITEM
			cmenu: EV_RADIO_MENU_ITEM
			cmenu2: EV_RADIO_MENU_ITEM
		do
			{EV_DRAWING_AREA} Precursor (par)
			set_minimum_size (200, 200)

			-- The popup_menu
			!! popup.make (par)
			!! menu.make_with_text (popup, "Clear")
			!! cmd.make (~execute_clear)
			menu.add_activate_command (cmd, Void)
			!! cmenu.make_with_text (popup, "Rectangle")
			cmenu.set_state (True)
			!! cmd.make(~execute_clear)
			cmenu.add_activate_command (cmd, Void)
			!! cmd.make (~execute_type)
			!! arg.make (False)
			cmenu.add_activate_command (cmd, arg)
			!! cmenu2.make_peer_with_text (popup, "Ellipse", cmenu)
			!! cmd.make (~execute_clear)
			cmenu2.add_activate_command (cmd, Void)
			!! cmd.make (~execute_type)
			!! arg.make (True)
			cmenu2.add_activate_command (cmd, arg)

			-- Command on the drawing area
			!! cmd.make (~execute_popup)
			add_button_press_command (3, cmd, Void)
			!! cmd.make (~execute_expose)
			add_paint_command (cmd, Void)
			!! cmd.make (~execute_motion)
			add_motion_notify_command (cmd, Void)


			-- Colors of the drawing area
			!! color.make_rgb (0, 255, 0)
			set_foreground_color (color)
			!! color.make_rgb (0, 122, 122)
			set_background_color (color)
		end

feature -- Access

	popup: EV_POPUP_MENU
			-- A popup menu

	angle: INTEGER
			-- Current angle of the rectangle

	type: BOOLEAN
			-- Type of drawing
			-- True : ellipse
			-- False : rectangle

feature -- Execute command

	execute_popup (arg: EV_ARGUMENT; data: EV_BUTTON_EVENT_DATA) is
		do
			popup.show_at_position (data.absolute_x, data.absolute_y)
		end

	execute_expose (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			pt1, pt2, pt3: EV_COORDINATES
			color: EV_COLOR
		do
			!! pt1.set (100, 100)
			clear
		end

	execute_motion (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Increase the angle
		local
			pt1: EV_COORDINATES
		do
			angle := (angle + 11) \\ 360
			!! pt1.set (100, 100)
			if type then
				draw_ellipse (pt1, 40, 100, angle)
			else
				draw_rectangle (pt1, 40, 100, angle)
			end
		end

	execute_clear (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Erase the Current area.
		do
			clear
		end

	execute_type (arg: EV_ARGUMENT1 [BOOLEAN]; data: EV_EVENT_DATA) is
			-- Called by the radio menu items.
		do
			type := arg.first
		end

end -- class DRAWING_WINDOW

--|----------------------------------------------------------------
--| EiffelVision Tutorial: Example for the ISE EiffelVision library.
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
