note
	description:
		"Facilities for direct drawing on the screen."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "screen, root, window, visual, top"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SCREEN

inherit
	EV_DRAWABLE
		redefine
			implementation,
			create_implementation
		end

create
	default_create

feature -- Measurement

	virtual_width: INTEGER
			-- Virtual width of screen
		do
			Result := implementation.virtual_width
		end

	virtual_height: INTEGER
			-- Virtual height of screen
		do
			Result := implementation.virtual_height
		end

	virtual_x: INTEGER
			-- X position of virtual screen in main display coordinates
		do
			Result := implementation.virtual_x
		end

	virtual_y: INTEGER
			-- Y position of virtual screen in main display coordinates
		do
			Result := implementation.virtual_y
		end

	virtual_left: INTEGER
			-- Left position of virtual screen in main display coordinates
		do
			Result := virtual_x
		end

	virtual_top: INTEGER
			-- Top position of virtual screen in main display coordinates
		do
			Result := virtual_y
		end

	virtual_right: INTEGER
			-- Right position of virtual screen in main display coordinates
		do
			Result := virtual_x + virtual_width
		end

	virtual_bottom: INTEGER
			-- Bottom position of virtual screen in main display coordinates
		do
			Result := virtual_y + virtual_height
		end

feature -- Status report

	pointer_position: EV_COORDINATE
			-- Position of the screen pointer.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.pointer_position
		ensure
			result_not_void: Result /= Void
		end

	widget_at_position (x, y: INTEGER): detachable EV_WIDGET
			-- Widget at position (`x', `y') if any.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.widget_at_position (x, y)
		end

	widget_at_mouse_pointer: detachable EV_WIDGET
			-- Widget underneath mouse pointer if any.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.widget_at_mouse_pointer
		end

feature -- Basic operation

	set_pointer_position (x, y: INTEGER)
			-- Set `pointer_position' to (`x',`y`).
		require
			not_destroyed: not is_destroyed
		do
			implementation.set_pointer_position (x, y)
		end

	fake_pointer_button_press (a_button: INTEGER)
			-- Simulate the user pressing a `a_button' on the pointing device.
		require
			not_destroyed: not is_destroyed
		do
			implementation.fake_pointer_button_press (a_button)
		end

	fake_pointer_button_release (a_button: INTEGER)
			-- Simulate the user releasing a `a_button' on the pointing device.
		require
			not_destroyed: not is_destroyed
		do
			implementation.fake_pointer_button_release (a_button)
		end

	fake_pointer_button_click (a_button: INTEGER)
			-- Simulate the user clicking `a_button' on the pointing device.
		require
			not_destroyed: not is_destroyed
		do
			implementation.fake_pointer_button_press (a_button)
			implementation.fake_pointer_button_release (a_button)
		end

	fake_pointer_wheel_up
			-- Simulate the user rotating the mouse wheel up.
		require
			not_destroyed: not is_destroyed
		do
			implementation.fake_pointer_wheel_up
		end

	fake_pointer_wheel_down
			-- Simulate the user rotating the mouse wheel down.
		require
			not_destroyed: not is_destroyed
		do
			implementation.fake_pointer_wheel_down
		end

	fake_key_press (a_key: EV_KEY)
			-- Simulate the user pressing a `key'.
		require
			not_destroyed: not is_destroyed
			key_not_void: a_key /= Void
		do
			implementation.fake_key_press (a_key)
		end

	fake_key_release (a_key: EV_KEY)
			-- Simulate the user releasing a `key'.
		require
			not_destroyed: not is_destroyed
			key_not_void: a_key /= Void
		do
			implementation.fake_key_release (a_key)
		end

	fake_key_click (a_key: EV_KEY)
			-- Simulate the user clicking a `key'.
		require
			not_destroyed: not is_destroyed
			key_not_void: a_key /= Void
		do
			implementation.fake_key_press (a_key)
			implementation.fake_key_release (a_key)
		end

feature -- Measurement

	width: INTEGER
			-- Horizontal size in pixels.
		do
			Result := implementation.width
		ensure then
			bridge_ok: Result = implementation.width
			positive: Result > 0
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			Result := implementation.height
		ensure then
			bridge_ok: Result = implementation.height
			positive: Result > 0
		end

	vertical_resolution: INTEGER
			-- Number of pixels per inch along screen height.
		do
			Result := implementation.vertical_resolution
		ensure
			positive: Result > 0
		end

	horizontal_resolution: INTEGER
			-- Number of pixels per inch along screen width.
		do
			Result := implementation.horizontal_resolution
		ensure
			positive: Result > 0
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_SCREEN_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_SCREEN_IMP} implementation.make
		end

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




end -- class EV_SCREEN











