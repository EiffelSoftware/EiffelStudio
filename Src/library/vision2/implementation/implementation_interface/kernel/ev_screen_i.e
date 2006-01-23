indexing 
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

	pointer_position: EV_COORDINATE is
			-- Position of the screen pointer.
		deferred
		end

	widget_at_position (x, y: INTEGER): EV_WIDGET is
			-- Widget at position (`x', `y') if any.
		deferred
		end
		
	vertical_resolution: INTEGER is
			-- Number of pixels per inch along screen height.
		deferred
		ensure
			positive: Result > 0
		end
		
	horizontal_resolution: INTEGER is
			-- Number of pixels per inch along screen width.
		deferred
		ensure
			positive: Result > 0
		end

	virtual_width: INTEGER is
			-- Virtual width of screen
		do
			Result := width
		end

	virtual_height: INTEGER is
			-- Virtual height of screen
		do
			Result := height
		end

	virtual_x: INTEGER is
			-- X position of virtual screen in main display coordinates
		do
			Result := 0
		end

	virtual_y: INTEGER is
			-- Y position of virtual screen in main display coordinates
		do
			Result := 0
		end

feature -- Basic operation

	set_pointer_position (a_x, a_y: INTEGER) is
			-- Set `pointer_position' to (`a_x',`a_y`).		
		deferred
		end

	fake_pointer_button_press (a_button: INTEGER) is
			-- Simulate the user pressing a `a_button' on the pointing device.
		deferred
		end

	fake_pointer_button_release (a_button: INTEGER) is
			-- Simulate the user releasing a `a_button' on the pointing device.
		deferred
		end

	fake_key_press (a_key: EV_KEY) is
			-- Simulate the user pressing a `key'.
		deferred
		end

	fake_key_release (a_key: EV_KEY) is
			-- Simulate the user releasing a `key'.
		deferred
		end

feature {NONE} -- Implementation

	interface: EV_SCREEN;

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




end -- class EV_SCREEN_I

