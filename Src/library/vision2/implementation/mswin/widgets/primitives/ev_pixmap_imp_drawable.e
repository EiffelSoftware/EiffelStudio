indexing
	description	: "EiffelVision pixmap. Mswindows implementation for %
				  %drawable pixmap (drawable, not self-displayable)"
	status		: "See notice at end of class"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EV_PIXMAP_IMP_DRAWABLE

inherit
	EV_PIXMAP_I
		redefine
			interface,
			on_parented,
			set_with_default,
			set_pebble,
			set_actual_drop_target_agent,
			save_to_named_file
		end

	EV_PIXMAP_IMP_STATE
		redefine
			interface
		end

	EV_DRAWABLE_IMP
		export
			{EV_PIXMAP_IMP_WIDGET} wel_drawing_mode
		redefine
			interface,
			destroy
		end

creation
	make_with_simple

feature {NONE} -- Initialization

	make_with_simple (other: EV_PIXMAP_IMP) is
			-- Create the current implementation using `other's
			-- attributes.
		do
				-- Create this new implementation using the
				-- same interface as other.
			base_make_called := True

			promote_from_simple (other)

				-- Initialize the drawable part.
			initialize -- from EV_DRAWABLE_IMP

				-- Select the palette if needed.
			if dc.palette_selected then
				dc.unselect_palette
			end
			if palette /= Void then
				dc.select_palette (palette)
			end

				-- Is_initialized should be set to True
				-- when the bridge pattern is linked.
			is_initialized := False
		end

	promote_from_simple (other: EV_PIXMAP_IMP) is
			-- Retrieve all common attributes between `other'
			-- and `Current' & make `Current' have the same
			-- attributes than `other'.
		local
			s_dc: WEL_SCREEN_DC
			other_bitmap: WEL_BITMAP
			other_mask_bitmap: WEL_BITMAP
		do
				-- Create the bitmaps
			other_bitmap := other.get_bitmap
			create internal_bitmap.make_by_bitmap(other_bitmap)
			other_bitmap.decrement_reference
			
			internal_bitmap.enable_reference_tracking

			if other.has_mask then
				other_mask_bitmap := other.get_mask_bitmap
				create internal_mask_bitmap.make_by_bitmap(
					other_mask_bitmap
					)
				other_mask_bitmap.decrement_reference
				internal_mask_bitmap.enable_reference_tracking
			end

			palette := other.palette
			if palette /= Void then
				palette.increment_reference
			end

				-- Create the DCs and map the bitmaps onto the DCs.
			create s_dc
			s_dc.get

			create dc.make_by_dc(s_dc)
			dc.enable_reference_tracking
			dc.select_bitmap (internal_bitmap)

			if internal_mask_bitmap /= Void then
				create mask_dc.make_by_dc(s_dc)
				mask_dc.enable_reference_tracking
				mask_dc.select_bitmap (internal_mask_bitmap)
			end
			s_dc.release

				-- Update the dimension attributes
			width := internal_bitmap.width
			height := internal_bitmap.height

				-- Destroy `other' implementation
			other.destroy
		end

	adapt_from_simple (other: EV_PIXMAP_IMP) is
			-- Adapt the current implementation to `other'.
		do
			promote_from_simple (other)

				-- Reset the drawable part.
			internal_initialized_pen := False
			internal_initialized_background_brush := False
			internal_initialized_brush := False
			reset_pen
			reset_brush
			dc.set_background_transparent

				-- Select the palette if needed.
			if dc.palette_selected then
				dc.unselect_palette
			end
			if palette /= Void then
				dc.select_palette (palette)
			end
		end

	read_from_named_file (file_name: STRING) is
			-- Load the pixmap described in 'file_name'. 
			--
			-- Exceptions "Unable to retrieve icon information", 
			--            "Unable to load the file"
		local
			simple_pixmap: EV_PIXMAP_IMP
		do
				-- Create a simple pixmap
			simple_pixmap := create_simple_pixmap
			simple_pixmap.read_from_named_file (file_name)
			
				-- Adapt the current object to the simple
				-- pixmap just created
			adapt_from_simple (simple_pixmap)
		end

	set_with_default is
			-- Initialize the pixmap with the default
			-- pixmap (Vision2 logo)
			--
			-- Exceptions "Unable to retrieve icon information"
		local
			simple_pixmap: EV_PIXMAP_IMP
		do
				-- Create a simple pixmap
			simple_pixmap := create_simple_pixmap
			simple_pixmap.set_with_default
			
				-- Adapt the current object to the simple
				-- pixmap just created
			adapt_from_simple (simple_pixmap)
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

	save_to_named_file (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME) is
			-- Save `Current' to `a_filename' in `a_format' format.
		local
			bmp_format: EV_BMP_FORMAT
			mem_dc: WEL_MEMORY_DC
			a_wel_bitmap: WEL_BITMAP
		do
			bmp_format ?= a_format
			if bmp_format /= Void then
				create mem_dc.make
				--| FIXME. Add code for dealing with cursors & icons.
				a_wel_bitmap := get_bitmap
				mem_dc.select_bitmap (a_wel_bitmap)
				mem_dc.save_bitmap (a_wel_bitmap, a_filename)
				mem_dc.unselect_bitmap
				a_wel_bitmap.decrement_reference
				mem_dc.delete
			end				
			a_format.save (raw_image_data, a_filename)
		end

feature -- Access

	dc: WEL_MEMORY_DC
			-- The device context corresponding to the image

	mask_dc: WEL_MEMORY_DC 
			-- The device context corresponding to the mask

	icon: WEL_ICON is
			-- Current icon used.
		do
		end

	cursor: WEL_CURSOR is
			-- Current cursor used.
		do
		end

	get_bitmap: WEL_BITMAP is
			-- Current bitmap used. Void if not initialized, not
			-- Void otherwise (see Invariant at the end of class).
			--
			-- Call `WEL_BITMAP.decrement_reference' when you don't
			-- need it anymore.
		do
			dc.unselect_bitmap
			create Result.make_by_bitmap (internal_bitmap)
			Result.enable_reference_tracking
			dc.select_bitmap (internal_bitmap)
		end

	get_mask_bitmap: WEL_BITMAP is
			-- Monochrome bitmap used as mask. Void if none.
			--
			-- Call `WEL_BITMAP.decrement_reference' when you don't
			-- need it anymore.
		do
			if mask_dc /= Void and internal_mask_bitmap /= Void then
				mask_dc.unselect_bitmap
				create Result.make_by_bitmap (internal_mask_bitmap)
				Result.enable_reference_tracking
				mask_dc.select_bitmap (internal_mask_bitmap)
			end
		end

	has_mask: BOOLEAN is
			-- Has the current pixmap a mask?
		do
			Result := internal_mask_bitmap /= Void
		end

	palette: WEL_PALETTE
			-- Current palette used. Void if none.

	transparent_color: EV_COLOR
			-- Color used as transparent (Void by default).

feature -- Status setting

	stretch (new_width, new_height: INTEGER) is
			-- Stretch the image to fit in size 
			-- `new_width' by `new_height'.
		local
			simple_pixmap: EV_PIXMAP_IMP
		do
				-- Downcast it to simple and perform the stretch
			simple_pixmap := create_simple_pixmap
			simple_pixmap.copy_pixmap (interface)
			simple_pixmap.stretch (new_width, new_height)

				-- Adapt the current object to the simple
				-- pixmap just created
			adapt_from_simple (simple_pixmap)
		end

	set_size (new_width, new_height: INTEGER) is
			-- Resize the current bitmap. If the new size
			-- is smaller than the old one, the bitmap is
			-- clipped.
		local
			black_color: WEL_COLOR_REF
			black_brush: WEL_BRUSH
			resized_bitmap: WEL_BITMAP
		do
				-- Resize the bitmap
			dc.unselect_bitmap
			resized_bitmap := resize_wel_bitmap (
				internal_bitmap,
				new_width,
				new_height,
				our_background_brush
				)
				-- Get rid of the old bitmap
			internal_bitmap.decrement_reference
			internal_bitmap := Void

				-- Assign the new bitmap
			internal_bitmap := resized_bitmap
			dc.select_bitmap (internal_bitmap)


				-- Resize the mask (if any)
			if has_mask then

				create black_color.make_rgb (0, 0, 0)
				create black_brush.make_solid (black_color)

				mask_dc.unselect_bitmap
				resized_bitmap := resize_wel_bitmap (
					internal_mask_bitmap,
					new_width,
					new_height,
					black_brush
					)
				black_brush.delete
	
					-- Get rid of the old bitmap
				internal_mask_bitmap.decrement_reference
				internal_mask_bitmap := Void

					-- Assign the new bitmap
				internal_mask_bitmap := resized_bitmap
				mask_dc.select_bitmap (internal_mask_bitmap)
			end

				-- Update width & height attributes
			width := internal_bitmap.width
			height := internal_bitmap.height
		end

feature -- Measurement

	width: INTEGER
			-- Width of `Current'.

	height: INTEGER
			-- Height of `Current'.

feature -- Element change

	set_transparent_color (value: EV_COLOR) is
			-- Make `value' the new transparent color.
		do
			transparent_color := value
			check
				not_yet_implemented: False
			end
		end

feature {
		EV_PIXMAP_IMP,
		EV_PIXMAP_IMP_DRAWABLE,
		EV_PIXMAP_IMP_WIDGET
		} -- Implementation

 	interface: EV_PIXMAP
			-- Interface for the bridge pattern.

	internal_bitmap: WEL_BITMAP
			-- Bitmap mapped onto the current DC and
			-- representing the current drawing.

	internal_mask_bitmap: WEL_BITMAP
			-- Bitmap mapped onto the current mask DC and
			-- representing the current mask.

	destroy is
			-- Destroy actual object.
		do
				-- Turn off invariant checking.
			is_initialized := False
			dc.decrement_reference
			dc := Void
			internal_bitmap.decrement_reference
			internal_bitmap := Void

			if has_mask then
				mask_dc.decrement_reference
				mask_dc := Void
				internal_mask_bitmap.decrement_reference
				internal_mask_bitmap := Void
			end
	
			if palette /= Void then
				palette.decrement_reference
				palette := Void
			end

			{EV_DRAWABLE_IMP} Precursor
		end

feature {EV_PIXMAP} -- Duplication

	copy_pixmap (other_interface: EV_PIXMAP) is
			-- Update `Current' to have same appearence as `other_interface'.
			-- (So as to satisfy `is_equal'.)
		local
			simple_pixmap: EV_PIXMAP_IMP
		do
				-- Create a simple pixmap
			simple_pixmap := create_simple_pixmap
			simple_pixmap.copy_pixmap (other_interface)
			
				-- Adapt the current object to the simple
				-- pixmap just created
			adapt_from_simple (simple_pixmap)
		end

feature {NONE} -- Private Implementation

	make (an_interface: like interface) is
			-- Initialize the bridge pattern.
		do
		end

	create_simple_pixmap: EV_PIXMAP_IMP is
			-- Create an empty pixmap implementation.
			--| Used to delegate some feature already
			--| implemented in the simple pixmap version.
		local
			dummy_interface: EV_PIXMAP
		do
				-- Create a simple pixmap
			create dummy_interface
			Result ?= dummy_interface.implementation
		end

	promote_to_widget is
			-- Promote the current implementation to
			-- EV_PIXMAP_IMP_WIDGET which allows
			-- drawing operations on the pixmap and
			-- display on the screen.
		local
			widget_pixmap: EV_PIXMAP_IMP_WIDGET
		do
			create widget_pixmap.make_with_drawable(Current)
			interface.replace_implementation(widget_pixmap)
		end

	resize_wel_bitmap(
			old_bitmap	: WEL_BITMAP
			new_width	: INTEGER
			new_height	: INTEGER
			a_brush		: WEL_BRUSH
		): WEL_BITMAP is
			-- Resize `old_bitmap'. If the new size
			-- is smaller than the old one, the bitmap is
			-- clipped. If the new size is bigger than the
			-- the new one, the area is filled with
			-- `a_brush'.
			--
			-- The resulting bitmap is available in
			-- `Result'.
		local
			new_bitmap	: WEL_BITMAP
			new_dc		: WEL_MEMORY_DC
			old_dc		: WEL_MEMORY_DC
			old_width	: INTEGER
			old_height	: INTEGER
			s_dc		: WEL_SCREEN_DC
			wel_rect	: WEL_RECT
		do
				-- Get a screen dc to create our temporary DCs
			create s_dc
			s_dc.get

				-- Retrieve the current values
			old_width := old_bitmap.width
			old_height := old_bitmap.height
			create old_dc.make_by_dc(s_dc)
			old_dc.select_bitmap(old_bitmap)

				-- create and assign a new bitmap & dc
			create new_dc.make_by_dc (s_dc)
			create new_bitmap.make_compatible (
				s_dc, 
				new_width, 
				new_height
				)
			new_bitmap.enable_reference_tracking
			new_dc.select_bitmap (new_bitmap)

			if new_width > old_width or new_height > old_height then
				-- Set the "new" pixels to the background color
				create wel_rect.make(0, 0, new_width, new_height)
				new_dc.fill_rect(wel_rect, a_brush)
			end

				-- Stretch the content of the old bitmap into the
				-- new one
			new_dc.bit_blt(
				0, 							-- x dest.
				0, 							-- y dest.
				old_width,					-- width
				old_height,					-- height
				old_dc, 					-- dc source
				0,							-- x source
				0, 							-- y source
				Srccopy						-- copy mode
				)

				-- Clean up the DCs.
			new_dc.unselect_bitmap
			new_dc.delete
			new_dc := Void	-- The GC can collect it.
			old_dc.unselect_bitmap
			old_dc.delete
			old_dc := Void	-- The GC can collect it.
			s_dc.release
			s_dc := Void	-- The GC can collect it.

			Result := new_bitmap
		end

feature -- Delegated features

	on_parented is
			-- `Current' has just been added to a container
		do
			promote_to_widget
			interface.implementation.on_parented
		end

	disable_capture is
            -- Ungrab the user input.
		local
			new_imp: EV_PIXMAP_IMP_WIDGET
		do
			promote_to_widget
			new_imp ?= interface.implementation
			new_imp.disable_capture
		end
	
	set_pebble (a_pebble: like pebble) is
			-- Assign `a_pebble' to `pebble'.
		do
			promote_to_widget
			interface.implementation.set_pebble (a_pebble)
		end

	set_actual_drop_target_agent (an_agent: like actual_drop_target_agent) is
			-- Assign `an_agent' to `actual_drop_target_agent'.
		do
			promote_to_widget
			interface.implementation.set_actual_drop_target_agent (an_agent)
		end

	disable_transport is
			-- Deactivate pick/drag and drop mechanism.
		do
			promote_to_widget
			interface.implementation.disable_transport
		end

	draw_rubber_band is
			-- Erase previously drawn rubber band.
			-- Draw a rubber band between initial pick point and cursor.
		do
			promote_to_widget
			interface.implementation.draw_rubber_band
		end

	enable_capture is
            -- Grab the user input.
		local
			new_imp: EV_PIXMAP_IMP_WIDGET
		do
			promote_to_widget
			new_imp ?= interface.implementation
			new_imp.enable_capture
		end

	enable_transport is
            -- Activate pick/drag and drop mechanism.
		do
			promote_to_widget
			interface.implementation.enable_transport
		end

	end_transport (
			a_x: INTEGER
			a_y: INTEGER
			a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER			
		) is
			-- Terminate the pick and drop mechanism.
		do
			promote_to_widget
			interface.implementation.end_transport(
				a_x,
				a_y,
				a_button,
				a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y
			)
		end

	erase_rubber_band is
			-- Erase previously drawn rubber band.
		do
			promote_to_widget
			interface.implementation.erase_rubber_band
		end

	real_pointed_target: EV_PICK_AND_DROPABLE is
			-- Target at mouse position
		do
			promote_to_widget
			Result := interface.implementation.real_pointed_target
		end

	set_pointer_style (c: EV_CURSOR) is
			-- Set `c' as new cursor pixmap.
			-- Can be called through `interface'.
		local
			new_imp: EV_PIXMAP_IMP_WIDGET
		do
			promote_to_widget
			new_imp ?= interface.implementation
			new_imp.set_pointer_style(c)
		end

	internal_set_pointer_style (c: EV_CURSOR) is
			-- Assign `c' to cursor pixmap.
			-- Only called from implementation.
		local
			new_imp: EV_PIXMAP_IMP
		do
			promote_to_widget
			new_imp ?= interface.implementation
			new_imp.internal_set_pointer_style (c)
		end

	start_transport (
			a_x: INTEGER
			a_y: INTEGER
			a_button: INTEGER
			a_x_tilt: DOUBLE
			a_y_tilt: DOUBLE
			a_pressure: DOUBLE
			a_screen_x: INTEGER
			a_screen_y: INTEGER
		) is
			-- Start a pick and drop transport.
		do
			promote_to_widget
			interface.implementation.start_transport (
				a_x,
				a_y,
				a_button,
				a_x_tilt,
				a_y_tilt,
				a_pressure,
				a_screen_x,
				a_screen_y
				)
		end

	disable_sensitive is
			-- Disable sensitivity to user input events.
		do
			promote_to_widget
			interface.implementation.disable_sensitive
		end

	enable_sensitive is
			-- Enable sensitivity to user input events.
		do
			promote_to_widget
			interface.implementation.enable_sensitive
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		do
			promote_to_widget
			Result := interface.implementation.has_focus
		end

	hide is
			-- Request that `Current' not be displayed when its parent is.
		do
			promote_to_widget
			interface.implementation.hide
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
			-- False if `Current' is entirely obscured by another window.
		do
			Result := False
		end

	is_sensitive: BOOLEAN is
			-- Does `Current' respond to user input events.
		do
			Result := False
		end

	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			Result := False
		end

	minimum_height: INTEGER is
			-- Minimum vertical size in pixels of `Current'.
		do
			Result := height
		end

	minimum_width: INTEGER is
			-- Minimum horizontal size in pixels `Current'.
		do
			Result := width
		end

	parent: EV_CONTAINER is
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
		do
				-- Simple pixmap => not in a container.
			Result := Void
		end

	has_parent: BOOLEAN is
		do
			-- Simple pixmap => not in a container.
			Result := False
		end

	has_capture: BOOLEAN is
			-- Does widget have capture?
		do
			-- Simple pixmap => not in a container.
			Result := False
		end

	parent_is_sensitive: BOOLEAN is
		do
			-- Simple pixmap => not in a container.
			Result := False
		end

	pointer_position: EV_COORDINATE is
            -- Position of the screen pointer relative to `Current'.
		do
				-- The pixmap is not on the screen, we
				-- return (0,0)
			create Result
			Result.set (0, 0)
		end

	pointer_style: EV_CURSOR is
			-- Cursor displayed when screen pointer is over `Current'.
		do
			promote_to_widget
			Result := interface.implementation.pointer_style
		end

	screen_x: INTEGER is
			-- Horizontal offset relative to screen in pixels.
		do
			promote_to_widget
			Result := interface.implementation.screen_x
		end

	screen_y: INTEGER is
			-- Vertical offset relative to screen in pixels.
		do
			promote_to_widget
			Result := interface.implementation.screen_y
		end

	set_focus is
			-- Grab keyboard focus.
		do
			promote_to_widget
			interface.implementation.set_focus
		end

	set_minimum_height (a_minimum_height: INTEGER) is
			-- Set the minimum vertical size to `a_minimum_height' in pixels.
		do
			promote_to_widget
			interface.implementation.set_minimum_height(a_minimum_height)
		end

	set_minimum_size (
			a_minimum_width: INTEGER
			a_minimum_height: INTEGER
		) is
			-- Set the minimum horizontal size to `a_minimum_width' in pixels.
			-- Set the minimum vertical size to `a_minimum_height' in pixels.
		do
			promote_to_widget
			interface.implementation.set_minimum_size (
				a_minimum_width,
				a_minimum_height
				)
		end

	set_minimum_width (a_minimum_width: INTEGER) is
			-- Set the minimum horizontal size to `a_minimum_width' in pixels.
		do
			promote_to_widget
			interface.implementation.set_minimum_width(a_minimum_width)
		end

	set_tooltip (a_text: STRING) is
			-- Set the minimum horizontal size to `a_minimum_width' in pixels.
		do
			promote_to_widget
			interface.implementation.set_tooltip(a_text)
		end

	show is
			-- Request that `Current' be displayed when its parent is.
		do
			promote_to_widget
			interface.implementation.show
		end

	tooltip: STRING is
			-- Text displayed when user moves mouse over widget.
		do
			promote_to_widget
			Result := interface.implementation.tooltip
		end

	x_position: INTEGER is
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
			promote_to_widget
			Result := interface.implementation.x_position
		end

	y_position: INTEGER is
			-- Vertical offset relative to parent `y_position' in pixels.
		do
			promote_to_widget
			Result := interface.implementation.y_position
		end
	
invariant
	bitmap_not_void: 
		is_initialized implies internal_bitmap /= Void

	bitmap_reference_tracked:
		internal_bitmap /= Void implies 
			internal_bitmap.reference_tracked

	palette_reference_tracked:
		palette /= Void implies palette.reference_tracked

	mask_bitmap_reference_tracked:
		internal_mask_bitmap /= Void implies 
			internal_mask_bitmap.reference_tracked

	dc_reference_tracked:
		dc /= Void implies dc.reference_tracked

	mask_dc_reference_tracked: 
		mask_dc /= Void implies mask_dc.reference_tracked;

end -- class EV_PIXMAP_IMP_DRAWABLE

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

