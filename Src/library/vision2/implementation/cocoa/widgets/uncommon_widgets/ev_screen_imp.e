note
	description:
		"EiffelVision screen. Cococa implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "screen, root, window, visual, top"
	date: "$Date$"
	revision: "$Revision$"


class
	EV_SCREEN_IMP

inherit
	EV_SCREEN_I
		redefine
			interface
		end

	EV_DRAWABLE_IMP
		redefine
			interface,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create an empty drawing area.
		do
			base_make (an_interface)
			create screen.main_screen
		end

	initialize
			-- Set up action sequence connections and create graphics context.
		do
		end

feature -- Status report

	pointer_position: EV_COORDINATE
			-- Position of the screen pointer.
		do
		end

	widget_at_position (x, y: INTEGER): EV_WIDGET
			-- Widget at position ('x', 'y') if any.
		do
		end

	widget_imp_at_pointer_position: EV_WIDGET_IMP
			-- Widget implementation at current mouse pointer position (if any)
		do
		end

feature -- Status setting

	set_default_colors
			-- Set foreground and background color to their default values.
		do
		end

feature -- Basic operation

	redraw
			-- Redraw the entire area.
		do
		end

	x_test_capable: BOOLEAN
			-- Is current display capable of performing x tests.
		do
		end

	set_pointer_position (a_x, a_y: INTEGER)
			-- Set pointer position to (a_x, a_y).
		do
		end

	fake_pointer_button_press (a_button: INTEGER)
			-- Fake button `a_button' press on pointer.
		do
		end

	fake_pointer_button_release (a_button: INTEGER)
			-- Fake button `a_button' release on pointer.
		do
		end

	fake_pointer_wheel_up
			-- Simulate the user rotating the mouse wheel up.
		do
				--| Mouse pointer button number 4 relates to mouse wheel up
			fake_pointer_button_press (4)
		end

	fake_pointer_wheel_down
			-- Simulate the user rotating the mouse wheel down.
		do
				--| Mouse pointer button number 5 relates to mouse wheel up
			fake_pointer_button_press (5)
		end

	fake_key_press (a_key: EV_KEY)
			-- Fake key `a_key' press.
		do
		end

	fake_key_release (a_key: EV_KEY)
			-- Fake key `a_key' release.
		do
		end

feature -- Measurement

	horizontal_resolution: INTEGER
			-- Number of pixels per inch along horizontal axis
		do
			--create {NS_VALUE}.make_shared (screen.device_description.object_for_key ({NS_WINDOW}.device_resolution))
			Result := 72 -- FIXME: implement
		end

	vertical_resolution: INTEGER
			-- Number of pixels per inch along vertical axis
		do
			Result := 72 -- FIXME: implement
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			Result := screen.frame.size.height
		end

	width: INTEGER
			-- Horizontal size in pixels.
		do
			Result := screen.frame.size.width
		end

feature {NONE} -- Implementation

	flush
			-- Force all queued draw to be called.
		do
			-- By default do nothing
		end

	update_if_needed
			-- Update `Current' if needed
		do
			-- By default do nothing
		end

	destroy
		do
		end

	dispose
			-- Cleanup
		do
		end

	screen: NS_SCREEN

	interface: EV_SCREEN;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_SCREEN_IMP

