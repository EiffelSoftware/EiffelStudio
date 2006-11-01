indexing
	description: "The demo that goes with the figure demo."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature {NONE} -- Initialization

	make (par: EV_CONTAINER) is
			-- Create the demo in `par'.
		local
			cmd: EV_ROUTINE_COMMAND
			arg: EV_ARGUMENT1 [BOOLEAN]
			color: EV_COLOR
		do
			Precursor {EV_DRAWING_AREA} (par)
			set_minimum_size (300, 300)

			-- Command on the drawing area
			create cmd.make (agent execute_expose)
			add_paint_command (cmd, Void)
			create cmd.make (agent execute_press)
			add_button_press_command (1, cmd, Void)
			create cmd.make (agent execute_motion)
			add_motion_notify_command (cmd, Void)
			create cmd.make (agent execute_release)
			add_button_release_command (1, cmd, Void)
			create cmd.make (agent execute_right_click)
			add_button_press_command (3, cmd, Void)

			-- Colors of the drawing area
			create color.make_rgb (0, 255, 0)
			set_foreground_color (color)
			create color.make_rgb (0, 122, 122)
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
			create pt.set (150, 150)
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
				create point.set (data.x, data.y)
			end
		end

	execute_motion (arg: EV_ARGUMENT; data: EV_MOTION_EVENT_DATA) is
			-- Increase the angle
		local
			pt: EV_POINT
			vector: EV_VECTOR
		do
			if button_click then
				create pt.set (data.x, data.y)
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
			create pt.set (data.x, data.y)
			figure.rotate (ang, pt)
			figure.draw
		end

feature {NONE} -- Implementation

	button_click: BOOLEAN;
			-- Is the button clicked on the figure ?

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


end -- class FIGURE_WINDOW

