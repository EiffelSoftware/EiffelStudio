indexing
	description: "The demo that goes with the figure demo."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FIGURE_WINDOW

inherit
	DEMO_WINDOW

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
		do
			{EV_DRAWING_AREA} Precursor (par)
			set_minimum_size (300, 300)

			-- Command on the drawing area
			!! cmd.make (~execute_expose)
			add_paint_command (cmd, Void)
			!! cmd.make (~execute_press)
			add_button_press_command (1, cmd, Void)
			!! cmd.make (~execute_motion)
			add_motion_notify_command (cmd, Void)
			!! cmd.make (~execute_release)
			add_button_release_command (1, cmd, Void)
			!! cmd.make (~execute_right_click)
			add_button_press_command (3, cmd, Void)

			-- Colors of the drawing area
			!! color.make_rgb (0, 255, 0)
			set_foreground_color (color)
			!! color.make_rgb (0, 122, 122)
			set_background_color (color)
		end

	set_tabs is
			-- Set the tabs for the action window.
		do
		end


feature -- Status setting

	set_figure (f: EV_FIGURE) is
			-- Set current figure.
		require
			valid_figure: f /= Void
		local
			pt: EV_POINT
		do
			figure := f
			figure.attach_drawing (Current)
			!! pt.set (150, 150)
			figure.set_origin (pt)
		end

feature -- Access

	angle: INTEGER
			-- Current angle

	point: EV_POINT
			-- Current point

	figure: EV_FIGURE
			-- Current figure

feature -- Execute command

	execute_expose (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			pt1, pt2, pt3: EV_COORDINATES
			color: EV_COLOR
		do
			clear
			figure.draw
		end

	execute_press (arg: EV_ARGUMENT; data: EV_BUTTON_EVENT_DATA) is
		local
			pt: EV_POINT
		do
			create pt.set (data.x, data.y)
			if figure.contains (pt) then
				button_click := True
				!! point.set (data.x, data.y)
			end
		end

	execute_motion (arg: EV_ARGUMENT; data: EV_MOTION_EVENT_DATA) is
			-- Increase the angle
		local
			pt: EV_POINT
			vector: EV_VECTOR
		do
			if button_click then
				!! pt.set (data.x, data.y)
				vector := pt - point
				point := pt
				figure.translate (vector)
				figure.draw
			end
		end

	execute_release (arg: EV_ARGUMENT; data: EV_BUTTON_EVENT_DATA) is
		do
			button_click := False
			figure.draw
		end

	execute_right_click (arg: EV_ARGUMENT; data: EV_BUTTON_EVENT_DATA) is
		local
			pt: EV_POINT
			ang: EV_ANGLE
		do
			angle := (angle + 11) \\ 360
			create ang.make_in_degrees (angle)
			!! pt.set (data.x, data.y)
			figure.rotate (ang, pt)
			figure.draw
		end

feature {NONE} -- Implementation

	button_click: BOOLEAN
			-- Is the button clicked on the figure ?

end -- class FIGURE_WINDOW

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

