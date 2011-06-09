note
	description: "EiffelVision screen. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "screen, root, window, visual, top"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SCREEN_I

inherit
	EV_DRAWABLE_I
		redefine
			interface
		end

feature -- Status report

	pointer_position: EV_COORDINATE
			-- Position of the screen pointer.
		deferred
		end

	widget_at_position (x, y: INTEGER): detachable EV_WIDGET
			-- Widget at position (`x', `y') if any.
		deferred
		end

	widget_at_mouse_pointer: detachable EV_WIDGET
			-- Widget at mouse pointer if any.
		local
			l_pointer_position: like pointer_position
		do
			l_pointer_position := pointer_position
			Result := widget_at_position (l_pointer_position.x, l_pointer_position.y)
		end

	vertical_resolution: INTEGER
			-- Number of pixels per inch along screen height.
		deferred
		ensure
			positive: Result > 0
		end

	horizontal_resolution: INTEGER
			-- Number of pixels per inch along screen width.
		deferred
		ensure
			positive: Result > 0
		end

	virtual_width: INTEGER
			-- Virtual width of screen
		do
			Result := width
		end

	virtual_height: INTEGER
			-- Virtual height of screen
		do
			Result := height
		end

	virtual_x: INTEGER
			-- X position of virtual screen in main display coordinates
		do
			Result := 0
		end

	virtual_y: INTEGER
			-- Y position of virtual screen in main display coordinates
		do
			Result := 0
		end

	monitor_count: INTEGER
			-- Number of monitors used for displaying virtual screen.
		do
			Result := 1
		end

	monitor_area_from_position (a_x, a_y: INTEGER): EV_RECTANGLE
			-- Full area of monitor nearest to coordinates (a_x, a_y)
		do
				-- Default implementation always returns the primary monitor area.
				-- Redefined by descendents for multi-monitor support.
			create Result.make (0, 0, width, height)
		end

	monitor_area_from_window (a_window: EV_WINDOW): EV_RECTANGLE
			-- Full area of monitor of which most of `a_window' is located.
			-- Returns nearest monitor area if `a_window' does not overlap any monitors.
		do
				-- Default implementation always returns the primary monitor area.
				-- Redefined by descendents for multi-monitor support.
			create Result.make (0, 0, width, height)
		end

feature -- Basic operation

	set_pointer_position (a_x, a_y: INTEGER)
			-- Set `pointer_position' to (`a_x',`a_y`).		
		deferred
		end

	fake_pointer_button_press (a_button: INTEGER)
			-- Simulate the user pressing a `a_button' on the pointing device.
		deferred
		end

	fake_pointer_button_release (a_button: INTEGER)
			-- Simulate the user releasing a `a_button' on the pointing device.
		deferred
		end

	fake_pointer_wheel_up
			-- Simulate the user rotating the mouse wheel up.
		deferred
		end

	fake_pointer_wheel_down
			-- Simulate the user rotating the mouse wheel down.
		deferred
		end

	fake_key_press (a_key: EV_KEY)
			-- Simulate the user pressing a `key'.
		deferred
		end

	fake_key_release (a_key: EV_KEY)
			-- Simulate the user releasing a `key'.
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	refresh_graphics_context
			-- Refresh the graphics context in case it is no longer valid.
		do
			-- Redefined by descendent.
		end

	interface: detachable EV_SCREEN note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_SCREEN_I











