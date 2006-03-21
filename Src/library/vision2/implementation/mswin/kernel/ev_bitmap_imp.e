indexing
	description: "Objects that ..."
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
			initialize,
			destroy
		end

create
	make

feature -- Initialization

	make (an_interface: like interface) is
			-- Create an empty drawing area.
		do
			base_make (an_interface)
		end

	initialize is
			-- Set up action sequence connections and create graphics context.
		do
			create dc.make
			dc.set_background_opaque

			create drawable.make_compatible (dc, 0, 0)
			drawable.enable_reference_tracking
				-- Set colors used for mask.  White means opaque, black means transparent
				-- As we need to draw what parts of the picture you see, the foreground color
				-- has to be white.
			background_color := create {EV_COLOR}.make_with_rgb (0, 0, 0)
			foreground_color := create {EV_COLOR}.make_with_rgb (1, 1, 1)
			Precursor {EV_DRAWABLE_IMP}

			set_is_initialized (True)
		end

feature -- Status setting

	set_size (a_width, a_height: INTEGER) is
			--
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

	height: INTEGER

feature -- Implementation

	drawable: WEL_BITMAP
		-- Bitmap used for masking.

	dc: WEL_MEMORY_DC
		-- Device Context used for performing drawing operations on `drawable'.

	redraw is
			-- Redraw the entire area.
		do

		end

	set_default_colors is
			-- Set foreground and background color to their default values.
		local
			a_default_colors: EV_STOCK_COLORS
		do
			create a_default_colors
			set_background_color (a_default_colors.default_background_color)
			set_foreground_color (a_default_colors.default_foreground_color)
		end

	destroy is
		do
			set_is_destroyed (True)
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

	interface: EV_BITMAP

end -- class EV_SCREEN_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------
