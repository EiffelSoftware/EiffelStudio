note
	description:
		"Interface to control mouse"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MOUSE

inherit
	ANY

	BUTTONS
		export
			{NONE} all
			{ANY} is_valid_button
		end

	SHARED_GUI
		export
			{NONE} all
		end

	EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize object.
		do
			create {MOUSE_IMP}implementation
			clicking_delay := 300_000_000
			pressing_delay :=   5_000_000
			releasing_delay :=  5_000_000
			movement_delay :=   5_000_000
			is_movement_infered := True
		end

feature -- Clicking button

	click (a_mouse_button: INTEGER; a_click_count: INTEGER)
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
			sleep (clicking_delay)
		end

	click_on (a_widget: EV_IDENTIFIABLE; a_mouse_button: INTEGER; a_click_count: INTEGER)
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

	left_click
			-- Click with left mouse button.
		do
			click (left, 1)
		end

	left_double_click
			-- Double click with left mouse button.
		do
			click (left, 2)
		end

	left_click_on (a_widget: EV_IDENTIFIABLE)
			-- Click on `a_widget' with left mouse button.
		require
			a_widget_not_void: a_widget /= Void
		do
			click_on (a_widget, left, 1)
		end

feature -- Clicking right button

	right_click
			-- Click with right mouse button.
		do
			click (right, 1)
		end

	right_double_click
			-- Double click with right mouse button.
		do
			click (right, 2)
		end

	right_click_on (a_widget: EV_IDENTIFIABLE)
			-- Click on `a_widget' with right mouse button.
		require
			a_widget_not_void: a_widget /= Void
		do
			click_on (a_widget, right, 1)
		end

feature -- Clicking middle button

	middle_click
			-- Click with middle mouse button.
		do
			click (middle, 1)
		end

	middle_double_click
			-- Double click with middle mouse button.
		do
			click (middle, 2)
		end

	middle_click_on (a_widget: EV_IDENTIFIABLE)
			-- Click on `a_widget' with middle mouse button.
		require
			a_widget_not_void: a_widget /= Void
		do
			click_on (a_widget, middle, 1)
		end

feature -- Pressing button

	press_button (a_mouse_button: INTEGER)
			-- Press `a_mouse_button'.
		require
			a_mouse_button_valid: is_valid_button (a_mouse_button)
		do
			implementation.press_button (a_mouse_button)
			sleep (pressing_delay)
		end

	press_left
			-- Press left button.
		do
			press_button (left)
		end

	press_right
			-- Press right button.
		do
			press_button (right)
		end

	press_middle
			-- Press middle button.
		do
			press_button (middle)
		end

feature -- Releasing button

	release_button (a_mouse_button: INTEGER)
			-- Release `a_mouse_button'.
		require
			a_mouse_button_valid: is_valid_button (a_mouse_button)
		do
			implementation.release_button (a_mouse_button)
			sleep (releasing_delay)
		end

	release_left
			-- Release left button.
		do
			release_button (left)
		end

	release_right
			-- Release right button.
		do
			release_button (right)
		end

	release_middle
			-- Release middle button.
		do
			release_button (middle)
		end

feature -- Moving

	move_to_absolute_position (an_x, a_y: INTEGER)
			-- Move mouse to absolute screen position `an_x' `a_y'.
		local
			l_start: EV_COORDINATE
			l_dx, l_dy: REAL_64
			l_x_steps, l_y_steps, l_steps: INTEGER
			i: INTEGER
		do
			if is_movement_infered then
				l_start := gui.screen.pointer_position
				l_x_steps := ((an_x - l_start.x_precise) / x_movement).rounded.abs
				l_y_steps := ((a_y - l_start.y_precise) / y_movement).rounded.abs
				l_steps := l_x_steps.max (l_y_steps) - 1
				l_dx := (an_x - l_start.x_precise) / l_steps
				l_dy := (a_y - l_start.y_precise) / l_steps
				from
					i := 0
				until
					i >= l_steps
				loop
					implementation.move_to_absolute_position ((l_start.x + i * l_dx).rounded, (l_start.y + i * l_dy).rounded)
					i := i + 1
					sleep (movement_delay)
				end
				implementation.move_to_absolute_position (an_x, a_y)
				sleep (movement_delay)
			else
				implementation.move_to_absolute_position (an_x, a_y)
				sleep (movement_delay)
			end
		end

	move_relative (a_dx, a_dy: INTEGER)
			-- Move mouse `a_dx' pixels in x direction and `a_dy' pixels in y direction.
		local
			l_current: EV_COORDINATE
		do
			l_current := gui.screen.pointer_position
			move_to_absolute_position (l_current.x + a_dx, l_current.y + a_dy)
		end

	move_to_widget (an_identifiable: EV_IDENTIFIABLE)
			-- Move mouse to center of `an_identifiable'.
		local
			a_positioned: EV_POSITIONED
		do
			a_positioned ?= an_identifiable
			if a_positioned = Void then
				-- TODO: raise exception, provide help
				check false end
			else
				move_to_absolute_position (a_positioned.screen_x + (a_positioned.width // 2), a_positioned.screen_y + (a_positioned.height // 2))
			end
		end

	move_relative_to_widget (an_identifiable: EV_IDENTIFIABLE; a_dx, a_dy: INTEGER)
			-- Move mouse `a_dx' `a_dy' pixels relative to top-left corner of `an_identifiable'.
		local
			a_positioned: EV_POSITIONED
		do
			a_positioned ?= an_identifiable
			if a_positioned = Void then
				-- TODO: raise exception, provide help
				check false end
			else
				move_to_absolute_position (a_positioned.screen_x + a_dx, a_positioned.screen_y + a_dy)
			end
		end

feature -- Scrolling

	scroll_up
			-- Scroll mouse wheel up.
		do
			implementation.scroll_up
			sleep (pressing_delay)
			sleep (releasing_delay)
		end

	scroll_down
			-- Scroll mouse wheel down.
		do
			implementation.scroll_down
			sleep (pressing_delay)
			sleep (releasing_delay)
		end

feature -- Advanced window commands

	window_click_title_bar (a_window: EV_WINDOW)
			-- Click title bar of `a_window'.
		local
			l_titled_window: EV_TITLED_WINDOW
			l_x, l_y: INTEGER
		do
			l_titled_window ?= a_window
			if l_titled_window = Void then
				-- TODO: raise exception, provide help
			else
				l_x := l_titled_window.screen_x + (l_titled_window.width // 2)
					-- TODO: the 10 is just a guess (which works on windows).
					-- TODO: check if other value is more suitable
				l_y := l_titled_window.screen_y + 10
				if gui.screen.widget_at_position (l_x, l_y) /= l_titled_window then
						-- TODO: check if another approach would be more 'user-like'
					l_titled_window.raise
				end
				move_to_absolute_position (l_x, l_y)
				left_click
			end
		end

	window_resize_lower_right (a_width, a_height: INTEGER)
			-- Resize `window' by `a_width' `a_height' using mouse on lower right corner.
		local
			lower_right_x, lower_right_y: INTEGER
		do
				-- TODO: the -2 is just a guess (which works on windows).
				-- TODO: check if other value is more suitable
			lower_right_x := gui.active_window.screen_x + gui.active_window.width - 2
			lower_right_y := gui.active_window.screen_y + gui.active_window.height - 2

			move_to_absolute_position (lower_right_x, lower_right_y)
			press_left
			move_relative (a_width, a_height)
			release_left

				-- TODO: make delay a variable which can be set
			sleep (200_000_000)
		end

feature -- Access

	clicking_delay: INTEGER
			-- Delay in milliseconds after a button click

	pressing_delay: INTEGER
			-- Delay in milliseconds after a button press

	releasing_delay: INTEGER
			-- Delay in nanoseconds after a button release

	movement_delay: INTEGER
			-- Delay in nanoseconds after mouse movement step

feature -- Status report

	is_movement_infered: BOOLEAN
			-- Is movement between mouse clicks infered?

feature -- Status setting

	activate_movement_infering
			-- Infer movement events between mouse clicks.
		do
			is_movement_infered := True
		end

	deactivate_movement_infering
			-- Don't infer movement events between mouse clicks.
		do
			is_movement_infered := False
		end

feature -- Element change

	set_clicking_delay (a_value: INTEGER)
			-- Set `clicking_delay' to `a_value'.
		require
			a_value_not_negative: a_value > 0
		do
			clicking_delay := a_value
		ensure
			clicking_delay_set: clicking_delay = a_value
		end

	set_pressing_delay (a_value: INTEGER)
			-- Set `pressing_delay' to `a_value'.
		require
			a_value_not_negative: a_value > 0
		do
			pressing_delay := a_value
		ensure
			pressing_delay_set: pressing_delay = a_value
		end

	set_releasing_delay (a_value: INTEGER)
			-- Set `releasing_delay' to `a_value'.
		require
			a_value_not_negative: a_value > 0
		do
			releasing_delay := a_value
		ensure
			releasing_delay_set: releasing_delay = a_value
		end

	set_movement_delay (a_value: INTEGER)
			-- Set `movement_delay' to `a_value'.
		require
			a_value_not_negative: a_value > 0
		do
			movement_delay := a_value
		ensure
			movement_delay_set: movement_delay = a_value
		end

feature {NONE} -- Implementation

	implementation: MOUSE_I
			-- Implementation of mouse interface

	x_movement: INTEGER = 10
			-- Mouse movement step in pixels in x direction

	y_movement: INTEGER = 10
			-- Mouse movement step in pixels in y direction

invariant

	implementation_not_void: implementation /= Void

note
	copyright:	"Copyright (c) 1984-2011, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"

end
