indexing
	description: "Objects that .... Carbon implementation"
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

	make (an_interface: like interface) is
			-- Create an empty drawing area.
		do
		end

	initialize is
			-- Set up action sequence connections and create graphics context.
		do
		end

feature -- Status Setting

	set_size (a_width, a_height: INTEGER) is
			-- Set the size of the pixmap to `a_width' by `a_height'.
		do
		end

	clear_rectangle (a_x, a_y, a_width, a_height: INTEGER) is
			-- Erase rectangle specified with `background_color'.
		do
		end

feature -- Access

	width: INTEGER is
		-- Width in pixels of mask bitmap.
		do
		end

	height: INTEGER is
		-- Width in pixels of mask bitmap.
		do
		end

feature {EV_PIXMAP_IMP} -- Implementation

	drawable: POINTER
		-- Pointer to the GdkPixmap objects used for `Current'.

feature {NONE} -- Implementation

	app_implementation: EV_APPLICATION_IMP is
			-- Access to application object implementation.
		once
		end

	redraw is
			-- Redraw the entire area.
		do
			-- Not needed for masking implementation.
		end

	set_default_colors is
			-- Set foreground and background color to their default values.
		do
		end

	destroy is
		do
		end

	dispose is
			-- Cleanup
		do
		end

	flush is
			-- Force all queued draw to be called.
		do
		end

	update_if_needed is
			-- Update `Current' if needed.
		do
		end

	mask: POINTER is
		do
			-- Not applicable
		end

	interface: EV_BITMAP;

indexing
	copyright:	"Copyright (c) 2007, The ETH Eiffel.Mac Team"

end -- class EV_BITMAP_IMP
