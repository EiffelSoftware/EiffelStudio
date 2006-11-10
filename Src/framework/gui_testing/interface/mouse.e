indexing
	description:
		"Interface to control mouse"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MOUSE

inherit
	BUTTONS
		export
			{NONE} all
			{ANY} is_valid_button
		end

	SHARED_GUI
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize object.
		do
			create {MOUSE_IMP}implementation
		end

feature -- Clicking button

	click (a_mouse_button: INTEGER; a_click_count: INTEGER) is
			-- Click `a_mouse_button' `a_click_count' times.
		require
			a_mouse_button_valid: is_valid_button (a_mouse_button)
			a_click_count_positive: a_click_count > 0
		local
			clicked_count: INTEGER
		do
			from
				clicked_count := 0
			variant
				a_click_count - clicked_count
			until
				clicked_count = a_click_count
			loop
				press_button (a_mouse_button)
				release_button (a_mouse_button)
				clicked_count := clicked_count + 1
			end
		end

	click_on (a_widget: EV_IDENTIFIABLE; a_mouse_button: INTEGER; a_click_count: INTEGER) is
			-- Click on `a_widget' with `a_mouse_button' `a_click_count' times.
		require
			a_widget_not_void: a_widget /= Void
			a_mouse_button_valid: is_valid_button (a_mouse_button)
			a_click_count_positive: a_click_count > 0
		do
			move_to_widget (a_widget)
			click (a_mouse_button, a_click_count)
		end

feature -- Clicking left button

	left_click is
			-- Click with left mouse button.
		do
			click (left, 1)
		end

	left_double_click is
			-- Click with left mouse button.
		do
			click (left, 2)
		end

	left_click_on (a_widget: EV_IDENTIFIABLE) is
			-- Click on `a_widget' with left mouse button.
		require
			a_widget_not_void: a_widget /= Void
		do
			click_on (a_widget, left, 1)
		end

feature -- Clicking right button

	right_click is
			-- Click with right mouse button.
		do
			click (right, 1)
		end

	right_double_click is
			-- Click with right mouse button.
		do
			click (right, 2)
		end

	right_click_on (a_widget: EV_IDENTIFIABLE) is
			-- Click on `a_widget' with right mouse button.
		require
			a_widget_not_void: a_widget /= Void
		do
			click_on (a_widget, right, 1)
		end

feature -- Clicking middle button

	middle_click is
			-- Click with middle mouse button.
		do
			click (middle, 1)
		end

	middle_double_click is
			-- Click with middle mouse button.
		do
			click (middle, 2)
		end

	middle_click_on (a_widget: EV_IDENTIFIABLE) is
			-- Click on `a_widget' with middle mouse button.
		require
			a_widget_not_void: a_widget /= Void
		do
			click_on (a_widget, middle, 1)
		end

feature -- Pressing button

	press_button (a_mouse_button: INTEGER) is
			-- Press `a_mouse_button'.
		require
			a_mouse_button_valid: is_valid_button (a_mouse_button)
		do
			implementation.press_button (a_mouse_button)
		end

	press_left is
			-- Press left button.
		do
			press_button (left)
		end

	press_right is
			-- Press right button.
		do
			press_button (right)
		end

	press_middle is
			-- Press middle button.
		do
			press_button (middle)
		end

feature -- Releasing button

	release_button (a_mouse_button: INTEGER) is
			-- Release `a_mouse_button'.
		require
			a_mouse_button_valid: is_valid_button (a_mouse_button)
		do
			implementation.release_button (a_mouse_button)
		end

	release_left is
			-- Release left button.
		do
			release_button (left)
		end

	release_right is
			-- Release right button.
		do
			release_button (right)
		end

	release_middle is
			-- Release middle button.
		do
			release_button (middle)
		end

feature -- Moving

	move_to_absolute_position (an_x, a_y: INTEGER) is
			-- Move mouse to absolute screen position `an_x' `a_y'.
		local
			l_thread_control: THREAD_CONTROL
			l_start: EV_COORDINATE
			l_current_x, l_current_y: REAL_64
			l_dx, l_dy: REAL_64
			x_steps, y_steps, steps: INTEGER
			i: INTEGER
		do
			if is_movement_infered then
				create l_thread_control
				l_start := screen.pointer_position
				x_steps := ((an_x - l_start.x_precise) / x_movement).rounded.abs
				y_steps := ((a_y - l_start.y_precise) / y_movement).rounded.abs
				steps := x_steps.max (y_steps) - 1
				l_dx := (an_x - l_start.x_precise) / steps
				l_dy := (a_y - l_start.y_precise) / steps
				from
					i := 0
				until
					i = steps
				loop
					implementation.move_to_absolute_position ((l_start.x + i * l_dx).rounded, (l_start.y + i * l_dy).rounded)
					i := i + 1
					l_thread_control.sleep (movement_delay)
				end
				implementation.move_to_absolute_position (an_x, a_y)
			else
				implementation.move_to_absolute_position (an_x, a_y)
			end
		end

	move_to_widget (a_widget: EV_IDENTIFIABLE) is
			-- Move mouse to center of `a_widget'.
		local
			a_positioned: EV_POSITIONED
		do
			a_positioned ?= a_widget
			if a_positioned /= Void then
				move_to_absolute_position (a_positioned.screen_x + (a_positioned.width // 2), a_positioned.screen_y + (a_positioned.height // 2))
			else
				check false end
			end
		end

feature -- Scrolling

	scroll_up is
			-- Scroll mouse wheel up.
		do
			implementation.scroll_up
		end

	scroll_down is
			-- Scroll mouse wheel down.
		do
			implementation.scroll_down
		end

feature -- Clicking menu items

	click_menu (a_path: STRING) is
			-- Click menu item denoted by `a_path'.
		do
			-- TODO
		end

feature -- Status report

	is_movement_infered: BOOLEAN
			-- Is movement between mouse clicks infered?

feature -- Status setting

	activate_movement_infering is
			-- Infer movement events between mouse clicks.
		do
			is_movement_infered := True
		end

	deactivate_movement_infering is
			-- Don't infer movement events between mouse clicks.
		do
			is_movement_infered := False
		end

feature {NONE} -- Implementation

	movement_delay: INTEGER is 5000000
			-- Delay in nanoseconds between mouse movement steps

	x_movement: INTEGER is 5
			-- Mouse movement step in pixels in x direction

	y_movement: INTEGER is 5
			-- Mouse movement step in pixels in y direction

	implementation: MOUSE_I
			-- Implementation of mouse interface

	screen: EV_SCREEN is
			-- Screen access
		once
			create Result
		end

invariant

	implementation_not_void: implementation /= Void

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

end
