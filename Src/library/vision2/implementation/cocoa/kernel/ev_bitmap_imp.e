indexing
	description: "Objects that .... Cocoa implementation"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_BITMAP_IMP

inherit
	EV_BITMAP_I
		redefine
			interface
		end

	EV_DRAWABLE_IMP
		redefine
			interface,
			clear_rectangle,
			initialize
		end

create
	make

feature -- Initialization

	make (an_interface: like interface)
			-- Create an empty drawing area.
		do
			base_make (an_interface)
		end

	initialize
			-- Set up action sequence connections and create graphics context.
		do
			set_default_colors
			Precursor {EV_DRAWABLE_IMP}
			set_is_initialized (True)
		end

feature -- Status Setting

	set_size (a_width, a_height: INTEGER)
			-- Set the size of the pixmap to `a_width' by `a_height'.
		do
		end

	clear_rectangle (a_x, a_y, a_width, a_height: INTEGER)
			-- Erase rectangle specified with `background_color'.
		do
		end

feature -- Access

	width: INTEGER
		-- Width in pixels of mask bitmap.
		do
		end

	height: INTEGER
		-- Width in pixels of mask bitmap.
		do
		end

feature {NONE} -- Implementation

	app_implementation: EV_APPLICATION_IMP
			-- Access to application object implementation.
		once
		end

	redraw
			-- Redraw the entire area.
		do
			-- Not needed for masking implementation.
		end

	set_default_colors
			-- Set foreground and background color to their default values.
		do
		end

	destroy
		do
		end

	dispose
			-- Cleanup
		do
		end

	flush
			-- Force all queued draw to be called.
		do
		end

	update_if_needed
			-- Update `Current' if needed.
		do
		end

	interface: EV_BITMAP;

indexing
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_BITMAP_IMP
