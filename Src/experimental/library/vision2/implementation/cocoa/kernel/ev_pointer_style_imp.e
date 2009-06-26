note
	description: "Cocoa implementation of EV_POINTER_STYLE_I."
	author: "Daniel Furrer"
	keywords: "mouse, pointer, cursor, arrow"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POINTER_STYLE_IMP

inherit
	EV_POINTER_STYLE_I
		redefine
			destroy
		end

	EV_ANY_HANDLER

	DISPOSABLE

create
	make

feature {NONE} -- Initlization

	old_make (an_interface: EV_POINTER_STYLE)
			-- Creation method
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize
		do
			-- See NSCursor
			set_is_initialized (True)
		end

	init_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_x_hotspot, a_y_hotspot: INTEGER)
			-- Initialize from `a_pixel_buffer'
		do
			-- initWithImage:hotSpot:
		end

	init_predefined (a_constant: INTEGER)
			-- Initialized a predefined cursor.
		do
		end

	init_from_cursor (a_cursor: EV_CURSOR)
			-- Initialize from `a_cursor'
		do
		end

	init_from_pixmap (a_pixmap: EV_PIXMAP; a_hotspot_x, a_hotspot_y: INTEGER_32)
			-- Initalize from `a_pixmap'
		do
		end

feature -- Command

	set_x_hotspot (a_x: INTEGER)
			-- Set `x_hotspot' to `a_x'.
		do
			x_hotspot := a_x
		end

	set_y_hotspot (a_y: INTEGER)
			-- Set `y_hotspot' to `a_y'.
		do
		end

	destroy
			-- Destroy `Current'.
		do
			set_is_in_destroy (True)
			set_is_destroyed (True)
		end

feature -- Query

	width: INTEGER
			-- Width of pointer style.
		do
		end

	height: INTEGER
			-- Height of pointer style.
		do
		end

	x_hotspot: INTEGER
			-- Specifies the x-coordinate of a cursor's hot spot.

	y_hotspot: INTEGER
			-- Specifies the y-coordinate of a cursor's hot spot.

feature -- Duplication

	copy_from_pointer_style (a_pointer_style: like interface)
			-- Copy attributes of `a_pointer_style' to `Current.
		do
		end

feature {EV_ANY_HANDLER, EV_ANY_I} -- Implementation

	predefined_cursor_code: INTEGER;
		-- Predefined cursor code used for selecting platform cursors.

feature {NONE} -- Implementation

	dispose
			-- Clean up `Current'.
		do
		end

end
