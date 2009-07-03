note
	description: "EiffelVision Bitmap. Cocoa implementation"
	author: "Daniel Furrer"
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
			make
		end

create
	make

feature -- Initialization

	make
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
			width := a_width
			height := a_height
		end

feature -- Access

	width: INTEGER
		-- Width in pixels of mask bitmap.

	height: INTEGER
		-- Width in pixels of mask bitmap.

feature {NONE} -- Implementation

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

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_BITMAP note option: stable attribute end;

end -- class EV_BITMAP_IMP
