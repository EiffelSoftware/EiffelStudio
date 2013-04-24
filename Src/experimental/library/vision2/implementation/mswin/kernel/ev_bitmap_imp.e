note
	description: "Windows implementation for EB_BITMAP_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "pixmap, mask, bitmap"
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
			make,
			destroy
		end

create
	make

feature -- Initialization

	old_make (an_interface: like interface)
			-- Create an empty drawing area.
		do
			assign_interface (an_interface)
		end

	make
			-- Set up action sequence connections and create graphics context.
		do
			create dc.make
			dc.set_background_opaque
			create drawable.make_compatible (dc, 0, 0)

			drawable.enable_reference_tracking
				-- Set colors used for mask.  White means opaque, black means transparent
				-- As we need to draw what parts of the picture you see, the foreground color
				-- has to be white.
			background_color_internal := create {EV_COLOR}.make_with_rgb (0, 0, 0)
			foreground_color_internal := create {EV_COLOR}.make_with_rgb (1, 1, 1)
			Precursor {EV_DRAWABLE_IMP}

			set_is_initialized (True)
		end

feature -- Status setting

	set_size (a_width, a_height: INTEGER)
			-- Set size with `a_width' and `a_height'.
		local
			old_drawable: like drawable
		do
			old_drawable := drawable

			create drawable.make_compatible (dc, a_width, a_height)

			drawable.enable_reference_tracking
			dc.select_bitmap (drawable)

			width := a_width
			height := a_height
			old_drawable.decrement_reference
		end

feature -- Access

	width: INTEGER
			-- Width

	height: INTEGER
			-- Height

feature -- Implementation

	drawable: WEL_BITMAP
			-- Bitmap used for masking.

	dc: WEL_MEMORY_DC
			-- Device Context used for performing drawing operations on `drawable'.

	redraw
			-- Redraw the entire area.
		do
		end

	set_default_colors
			-- Set foreground and background color to their default values.
		local
			a_default_colors: EV_STOCK_COLORS
		do
			create a_default_colors
			set_background_color (a_default_colors.default_background_color)
			set_foreground_color (a_default_colors.default_foreground_color)
		end

	destroy
			-- Destroy
		do
			set_is_destroyed (True)
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

	interface: detachable EV_BITMAP note option: stable attribute end;
			-- Interface

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



end -- class EV_BITMAP_IMP









