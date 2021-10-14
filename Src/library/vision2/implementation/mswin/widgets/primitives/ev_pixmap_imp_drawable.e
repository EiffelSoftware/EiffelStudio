note
	description: "EiffelVision pixmap. Mswindows implementation for %
				  %drawable pixmap (drawable, not self-displayable)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXMAP_IMP_DRAWABLE

inherit
	EV_PIXMAP_I
		undefine
			save_to_named_path
		redefine
			interface,
			on_parented,
			set_pebble,
			set_actual_drop_target_agent
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
			make,
			destroy,
			sub_pixmap
		end

create
	make_with_simple,
	make_with_pixel_buffer

feature {NONE} -- Initialization

	make_with_simple (other: EV_PIXMAP_IMP)
			-- Create the current implementation using `other's
			-- attributes.
		do
				-- Create this new implementation using the
				-- same interface as other.
			set_state_flag (base_make_called_flag, True)

			promote_from_simple (other)

				-- Initialize the drawable part.
			make -- from EV_DRAWABLE_IMP

				-- Is_initialized should be set to True
				-- when the bridge pattern is linked.
			set_state_flag (is_initialized_flag, False)

			copy_tab_status (other)

				-- Select the palette if needed.
			if dc.palette_selected then
				dc.unselect_palette
			end
			if attached palette as l_palette then
				dc.select_palette (l_palette)
			end
		end

	make_with_pixel_buffer (a_dc: WEL_MEMORY_DC)
			-- Creation method for EV_PIXEL_BUFFER specially
		do
			dc := a_dc
		end

	promote_from_simple (other: EV_PIXMAP_IMP)
			-- Retrieve all common attributes between `other'
			-- and `Current' & make `Current' have the same
			-- attributes than `other'.
		local
			s_dc: WEL_SCREEN_DC
			other_bitmap: WEL_BITMAP
			other_mask_bitmap: detachable WEL_BITMAP
			l_internal_mask_bitmap: like internal_mask_bitmap
			l_internal_bitmap: like internal_bitmap
			l_mask_dc: like mask_dc
		do
				-- Create the bitmaps
			other_bitmap := other.get_bitmap
			create l_internal_bitmap.make_by_bitmap(other_bitmap)
			internal_bitmap := l_internal_bitmap
			other_bitmap.decrement_reference

			l_internal_bitmap.enable_reference_tracking

			if other.has_mask then
				other_mask_bitmap := other.get_mask_bitmap
				check other_mask_bitmap /= Void then end
				create l_internal_mask_bitmap.make_by_bitmap(
					other_mask_bitmap
					)
				other_mask_bitmap.decrement_reference
				l_internal_mask_bitmap.enable_reference_tracking
				internal_mask_bitmap := l_internal_mask_bitmap
			end

			palette := other.palette
			if attached palette as l_palette then
				l_palette.increment_reference
			end

				-- Create the DCs and map the bitmaps onto the DCs.
			create s_dc
			s_dc.get

			create dc.make_by_dc(s_dc)
			dc.enable_reference_tracking
			dc.select_bitmap (l_internal_bitmap)

			if l_internal_mask_bitmap /= Void then
				create l_mask_dc.make_by_dc(s_dc)
				l_mask_dc.enable_reference_tracking
				l_mask_dc.select_bitmap (l_internal_mask_bitmap)
				mask_dc := l_mask_dc
			end
			s_dc.release

				-- update events from `other'.
			copy_events_from_other (other)

				-- Update the dimension attributes
			width := l_internal_bitmap.width
			height := l_internal_bitmap.height

				-- Destroy `other' implementation
			other.safe_destroy
		end

	copy_tab_status (other: EV_PIXMAP_IMP)
			-- Retrieve all common attributes between `other'
			-- and `Current' & make `Current' have the same
			-- attributes than `other'.
		require
			other_not_void: other /= Void
		do
				-- Update navigation attribute
			if other.is_tabable_from then
				enable_tabable_from
			else
				disable_tabable_from
			end
			if other.is_tabable_to then
				enable_tabable_to
			else
				disable_tabable_to
			end
		end

	adapt_from_simple (other: EV_PIXMAP_IMP)
			-- Adapt the current implementation to `other'.
		do
			promote_from_simple (other)
			copy_tab_status (other)

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
			if attached palette as l_palette then
				dc.select_palette (l_palette)
			end
		end

	read_from_named_path (file_path: PATH)
			-- Load the pixmap described in `file_path'.
			--
			-- Exceptions "Unable to retrieve icon information",
			--            "Unable to load the file"
		local
			simple_pixmap: EV_PIXMAP_IMP
		do
				-- Create a simple pixmap
			simple_pixmap := create_simple_pixmap
			simple_pixmap.read_from_named_path (file_path)

				-- Adapt the current object to the simple
				-- pixmap just created
			adapt_from_simple (simple_pixmap)
		end

	refresh_now
			-- Force `Current' to be redrawn immediately.
		do
			-- No implementation needed as `Current' is always offscreen
		end

	set_with_default
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

	set_default_colors
			-- Set foreground and background color to their default values.
		local
			a_default_colors: EV_STOCK_COLORS
		do
			create a_default_colors
			set_background_color (a_default_colors.default_background_color)
			set_foreground_color (a_default_colors.default_foreground_color)
		end

	init_from_pointer_style (a_pointer_style: EV_POINTER_STYLE)
			-- Initialize from `a_pointer_style'
		do
			check should_not_be_called: False end
		end

	make
		do
			disable_tabable_from
			disable_tabable_to
			Precursor {EV_DRAWABLE_IMP}
		end

feature {NONE} -- Saving

	save_with_format (a_format: EV_GRAPHICAL_FORMAT; a_filename: PATH; a_raw_image_data: like raw_image_data)
			-- Call `save' on `a_format'. Implemented in descendant of EV_PIXMAP_IMP_STATE
			-- since `save' from EV_GRAPHICAL_FORMAT is only exported to EV_PIXMAP_I.
		do
			a_format.save (a_raw_image_data, a_filename)
		end

feature -- Access

	sub_pixmap (area: EV_RECTANGLE): EV_PIXMAP
			-- Return the subpixmap of `Current' described by rectangle `area'.
		local
			a_pixmap_imp: detachable EV_PIXMAP_IMP
			a_private_bitmap: WEL_BITMAP
			a_private_mask_bitmap: detachable WEL_BITMAP
			reusable_dc: WEL_MEMORY_DC
		do
			create Result
			a_pixmap_imp ?= Result.implementation
			check a_pixmap_imp /= Void then end
			create reusable_dc.make_by_dc (dc)
			create a_private_bitmap.make_compatible (dc, area.width, area.height)
			reusable_dc.select_bitmap (a_private_bitmap)

			reusable_dc.bit_blt (0, 0, area.width, area.height, dc, area.x, area.y, srccopy)

			if has_mask and then attached mask_dc as l_mask_dc then
				-- Add mask to result
				reusable_dc.unselect_bitmap
				create a_private_mask_bitmap.make_compatible (l_mask_dc, area.width, area.height)
				reusable_dc.select_bitmap (a_private_mask_bitmap)
				reusable_dc.bit_blt (0, 0, area.width, area.height, l_mask_dc, area.x, area.y, srccopy)
			end

			a_pixmap_imp.set_bitmap_and_mask (a_private_bitmap, a_private_mask_bitmap, area.width, area.height)

				-- Clean up
			reusable_dc.unselect_bitmap
			reusable_dc.delete
		end

	dc: WEL_MEMORY_DC
			-- The device context corresponding to the image

	mask_dc: detachable WEL_MEMORY_DC
			-- The device context corresponding to the mask

	icon: detachable WEL_ICON
			-- Current icon used.
		do
		end

	cursor: detachable WEL_CURSOR
			-- Current cursor used.
		do
		end

	get_bitmap: WEL_BITMAP
			-- Current bitmap used. Void if not initialized, not
			-- Void otherwise (see Invariant at the end of class).
			--
			-- Call `WEL_BITMAP.decrement_reference' when you don't
			-- need it anymore.
		local
			l_internal_bitmap: like internal_bitmap
		do
			dc.unselect_bitmap
			l_internal_bitmap := internal_bitmap
			check l_internal_bitmap /= Void then end
			create Result.make_by_bitmap (l_internal_bitmap)
			Result.enable_reference_tracking
			dc.select_bitmap (l_internal_bitmap)
		end

	get_mask_bitmap: detachable WEL_BITMAP
			-- Monochrome bitmap used as mask. Void if none.
			--
			-- Call `WEL_BITMAP.decrement_reference' when you don't
			-- need it anymore.
		do
			if attached mask_dc as l_mask_dc and then attached internal_mask_bitmap as l_internal_mask_bitmap then
				l_mask_dc.unselect_bitmap
				create Result.make_by_bitmap (l_internal_mask_bitmap)
				Result.enable_reference_tracking
				l_mask_dc.select_bitmap (l_internal_mask_bitmap)
			end
		end

	has_mask: BOOLEAN
			-- Has the current pixmap a mask?
		do
			Result := internal_mask_bitmap /= Void
		end

	palette: detachable WEL_PALETTE
			-- Current palette used. Void if none.

	transparent_color: detachable EV_COLOR
			-- Color used as transparent (Void by default).

feature -- Status setting

	stretch (new_width, new_height: INTEGER)
			-- Stretch the image to fit in size
			-- `new_width' by `new_height'.
		local
			simple_pixmap: EV_PIXMAP_IMP
		do
				-- Downcast it to simple and perform the stretch
			simple_pixmap := create_simple_pixmap
			simple_pixmap.copy_pixmap (attached_interface)
			simple_pixmap.stretch (new_width, new_height)

				-- Adapt the current object to the simple
				-- pixmap just created
			adapt_from_simple (simple_pixmap)
		end

	set_size (new_width, new_height: INTEGER)
			-- Resize the current bitmap. If the new size
			-- is smaller than the old one, the bitmap is
			-- clipped.
		local
			l_resized_bitmap: WEL_BITMAP
			l_resized_bitmap_dc: WEL_MEMORY_DC
			l_internal_bitmap: like internal_bitmap
			l_internal_mask_bitmap: like internal_mask_bitmap
		do
				-- Resize the bitmap
			if dc.bitmap_selected then
				dc.unselect_bitmap
			end
			l_internal_bitmap := internal_bitmap
			check l_internal_bitmap /= Void then end
			l_resized_bitmap := resize_wel_bitmap (
				l_internal_bitmap,
				new_width,
				new_height,
				our_background_brush
				)
				-- Get rid of the old bitmap

			l_internal_bitmap.decrement_reference
			internal_bitmap := Void

				-- Assign the new bitmap
			l_internal_bitmap := l_resized_bitmap
			internal_bitmap := l_internal_bitmap
			dc.select_bitmap (l_internal_bitmap)

				-- Resize the mask (if any)
			if has_mask and then attached mask_dc as l_mask_dc then
				create l_resized_bitmap_dc.make_by_dc (l_mask_dc)
				create l_resized_bitmap.make_compatible (l_resized_bitmap_dc, new_width, new_height)
				l_resized_bitmap.enable_reference_tracking
				l_resized_bitmap_dc.select_bitmap (l_resized_bitmap)

				l_internal_mask_bitmap := internal_mask_bitmap
				check l_internal_mask_bitmap /= Void then end

					-- Create a new opaque mask of size `new_width', `new_height'.
				l_resized_bitmap_dc.pat_blt (0, 0, new_width, new_height, {WEL_RASTER_OPERATIONS_CONSTANTS}.whiteness)
					-- Copy existing mask data over new mask.
				l_resized_bitmap_dc.bit_blt (0, 0, l_internal_mask_bitmap.width, l_internal_mask_bitmap.height, l_mask_dc, 0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.srccopy)
				l_resized_bitmap_dc.unselect_bitmap
				l_resized_bitmap_dc.delete

				l_mask_dc.unselect_bitmap

					-- Get rid of the old bitmap
				l_internal_mask_bitmap.decrement_reference

					-- Assign the new bitmap
				internal_mask_bitmap := l_resized_bitmap
				l_mask_dc.select_bitmap (l_resized_bitmap)
			end

				-- Update width & height attributes
			width := l_internal_bitmap.width
			height := l_internal_bitmap.height
		end

	reset_for_buffering (a_width, a_height: INTEGER)
			-- Resets the size of the pixmap without keeping original image or clearing background.
		local
			new_bitmap: WEL_BITMAP
			s_dc: WEL_SCREEN_DC
			l_internal_bitmap: like internal_bitmap
			l_internal_mask_bitmap: like internal_mask_bitmap
		do
				-- Get a screen dc to create our temporary DCs
			create s_dc
			s_dc.get

			create new_bitmap.make_compatible (
				s_dc,
				a_width,
				a_height
				)
			new_bitmap.enable_reference_tracking


				-- Get rid of the old bitmap
			l_internal_bitmap := internal_bitmap
			check l_internal_bitmap /= Void then end
			l_internal_bitmap.decrement_reference
			internal_bitmap := Void

				-- Assign the new bitmap
			l_internal_bitmap := new_bitmap
			internal_bitmap := l_internal_bitmap
			dc.select_bitmap (new_bitmap)


				-- Remove the mask (if any)
			if has_mask and then attached mask_dc as l_mask_dc then

					-- Get rid of the old bitmap
				l_internal_mask_bitmap := internal_mask_bitmap
				check l_internal_mask_bitmap /= Void then end
				l_internal_mask_bitmap.decrement_reference
				internal_mask_bitmap := Void
				l_mask_dc.unselect_bitmap
			end

				-- Update width & height attributes
			width := new_bitmap.width
			height := new_bitmap.height
		end

feature -- Measurement

	width: INTEGER
			-- Width of `Current'.

	height: INTEGER
			-- Height of `Current'.

feature -- Element change

	set_transparent_color (value: EV_COLOR)
			-- Make `value' the new transparent color.
		do
			transparent_color := value
			check
				not_yet_implemented: False
			end
		end

	set_mask (a_mask: EV_BITMAP)
			-- Set bitmap mask of `Current' to `a_mask'.
		local
			l_bitmap_imp: detachable EV_BITMAP_IMP
			s_dc: WEL_SCREEN_DC
			other_mask_bitmap: WEL_BITMAP
			l_internal_mask_bitmap: like internal_mask_bitmap
			l_mask_dc: like mask_dc
		do
			l_internal_mask_bitmap := internal_mask_bitmap
			if l_internal_mask_bitmap /= Void then
				l_mask_dc := mask_dc
				check l_mask_dc /= Void then end
				l_mask_dc.unselect_all
				l_mask_dc.delete
				l_internal_mask_bitmap.decrement_reference
			end
			l_bitmap_imp ?= a_mask.implementation
			check l_bitmap_imp /= Void then end
			other_mask_bitmap := l_bitmap_imp.drawable
			create l_internal_mask_bitmap.make_by_bitmap (other_mask_bitmap)
			internal_mask_bitmap := l_internal_mask_bitmap
			l_internal_mask_bitmap.enable_reference_tracking


			create s_dc
			s_dc.get
			create l_mask_dc.make_by_dc (s_dc)
			l_mask_dc.enable_reference_tracking
			l_mask_dc.select_bitmap (l_internal_mask_bitmap)
			mask_dc := l_mask_dc

			s_dc.release
		end

feature -- Event handling

	init_file_drop_actions (a_file_drop_actions: like file_drop_actions)
		do
		end

	init_resize_actions (a_resize_actions: like resize_actions)
		do
		end

	init_dpi_changed_actions (a_dpi_changed_actions: like dpi_changed_actions)
		do
		end

feature -- Navigation

	internal_tabable_info: NATURAL_8
			-- Storage for `is_tabable_from' and `is_tabable_to'.

	is_tabable_to: BOOLEAN
		do
			Result := internal_tabable_info.bit_test (1)
		end

	is_tabable_from: BOOLEAN
		do
			Result := internal_tabable_info.bit_test (2)
		end

	enable_tabable_from
		do
			internal_tabable_info := internal_tabable_info.set_bit (True, 2)
		end

	disable_tabable_from
		do
			internal_tabable_info := internal_tabable_info.set_bit (False, 2)
		end

	enable_tabable_to
		do
			internal_tabable_info := internal_tabable_info.set_bit (True, 1)
		end

	disable_tabable_to
		do
			internal_tabable_info := internal_tabable_info.set_bit (False, 1)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

 	interface: detachable EV_PIXMAP note option: stable attribute end
			-- Interface for the bridge pattern.

feature {
		EV_PIXMAP_IMP,
		EV_PIXMAP_IMP_DRAWABLE,
		EV_PIXMAP_IMP_WIDGET
		} -- Implementation

	internal_bitmap: detachable WEL_BITMAP
			-- Bitmap mapped onto the current DC and
			-- representing the current drawing.

	internal_mask_bitmap: detachable WEL_BITMAP
			-- Bitmap mapped onto the current mask DC and
			-- representing the current mask.

	destroy
			-- Destroy actual object.
		do
				-- Turn off invariant checking.
			set_is_initialized (False)
			dc.decrement_reference
			if attached internal_bitmap as l_internal_bitmap then
				l_internal_bitmap.decrement_reference
				internal_bitmap := Void
			end

			if has_mask and then attached mask_dc as l_mask_dc then
				l_mask_dc.decrement_reference
				if attached internal_mask_bitmap as l_internal_mask_bitmap then
					l_internal_mask_bitmap.decrement_reference
				end
				internal_mask_bitmap := Void
			end

			if attached palette as l_palette then
				l_palette.decrement_reference
				palette := Void
			end

			Precursor {EV_DRAWABLE_IMP}
		end

feature {EV_PIXMAP} -- Duplication

	copy_pixmap (other_interface: EV_PIXMAP)
			-- Update `Current' to have same appearence as `other_interface'.
			-- (So as to satisfy `is_equal'.)
		local
			simple_pixmap: EV_PIXMAP_IMP
		do
				-- Reset `internal_mask_bitmap'.
				-- Julian 06/26/03 This is necessary to fix the following problem:
				-- Display a pixmap in a container, using something such as an icon which has a mask.
				-- Perform `copy' on the bixmap with a bitmap.
				-- If fails, due to `internal_mask_bitmap' being non Void, which I believe is left
				-- from the old implementation, and needs re-setting. If the new implementation
				-- requires a mask bitmap, it will be set during `copy_pixmap'.
			internal_mask_bitmap := Void

				-- Create a simple pixmap
			simple_pixmap := create_simple_pixmap
			simple_pixmap.copy_pixmap (other_interface)

				-- Adapt the current object to the simple
				-- pixmap just created
			adapt_from_simple (simple_pixmap)
		end

feature {NONE} -- Private Implementation

	old_make (an_interface: attached like interface)
			-- Initialize the bridge pattern.
		do
		end

	create_simple_pixmap: EV_PIXMAP_IMP
			-- Create an empty pixmap implementation.
			--| Used to delegate some feature already
			--| implemented in the simple pixmap version.
		local
			dummy_interface: EV_PIXMAP
			l_result: detachable EV_PIXMAP_IMP
		do
				-- Create a simple pixmap
			create dummy_interface
			l_result ?= dummy_interface.implementation
			check l_result /= Void then end
			Result := l_result
		end

	promote_to_widget
			-- Promote the current implementation to
			-- EV_PIXMAP_IMP_WIDGET which allows
			-- drawing operations on the pixmap and
			-- display on the screen.
		local
			widget_pixmap: EV_PIXMAP_IMP_WIDGET
		do
			create widget_pixmap.make_with_drawable(Current)
			attached_interface.replace_implementation(widget_pixmap)
		end

	resize_wel_bitmap(
			old_bitmap	: WEL_BITMAP
			new_width	: INTEGER
			new_height	: INTEGER
			a_brush		: WEL_BRUSH
		): WEL_BITMAP
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
			new_dc		: detachable WEL_MEMORY_DC
			old_dc		: detachable WEL_MEMORY_DC
			old_width	: INTEGER
			old_height	: INTEGER
			s_dc		: detachable WEL_SCREEN_DC
		do
				-- Get a screen dc to create our temporary DCs
			create s_dc
			s_dc.get

				-- create and assign a new bitmap & dc

			create new_bitmap.make_compatible (
				s_dc,
				new_width,
				new_height
				)
			new_bitmap.enable_reference_tracking

				-- Retrieve the current values
			old_width := old_bitmap.width
			old_height := old_bitmap.height
			create old_dc.make_by_dc(s_dc)
			old_dc.select_bitmap(old_bitmap)

			create new_dc.make_by_dc (s_dc)
			new_dc.select_bitmap (new_bitmap)

			if new_width > old_width or new_height > old_height then
				-- Set the "new" pixels to the background color
				wel_rect.set_rect (0, 0, new_width, new_height)
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

	widget_imp_at_pointer_position: detachable EV_WIDGET_IMP
			-- `Result' is widget implementation at current
			-- cursor position.
		do
			check
				must_be_widget_to_get_called: False
			end
		end

	on_parented
			-- `Current' has just been added to a container
		do
			promote_to_widget
			attached_interface.implementation.on_parented
		end

	disable_capture
            -- Ungrab the user input.
		local
			new_imp: detachable EV_PIXMAP_IMP_WIDGET
		do
			promote_to_widget
			new_imp ?= attached_interface.implementation
			check new_imp /= Void then end
			new_imp.disable_capture
		end

	set_pebble (a_pebble: ANY)
			-- Assign `a_pebble' to `pebble'.
		do
			promote_to_widget
			attached_interface.implementation.set_pebble (a_pebble)
		end

	set_actual_drop_target_agent (an_agent: like actual_drop_target_agent)
			-- Assign `an_agent' to `actual_drop_target_agent'.
		do
			promote_to_widget
			attached_interface.implementation.set_actual_drop_target_agent (an_agent)
		end

	disable_transport
			-- Deactivate pick/drag and drop mechanism.
		do
			promote_to_widget
			attached_interface.implementation.disable_transport
		end

	draw_rubber_band
			-- Erase previously drawn rubber band.
			-- Draw a rubber band between initial pick point and cursor.
		do
			promote_to_widget
			attached_interface.implementation.draw_rubber_band
		end

	enable_capture
            -- Grab the user input.
		local
			new_imp: detachable EV_PIXMAP_IMP_WIDGET
		do
			promote_to_widget
			new_imp ?= attached_interface.implementation
			check new_imp /= Void then end
			new_imp.enable_capture
		end

	enable_transport
            -- Activate pick/drag and drop mechanism.
		do
			promote_to_widget
			attached_interface.implementation.enable_transport
		end

	end_transport (
			a_x: INTEGER
			a_y: INTEGER
			a_button: INTEGER;
			a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
			a_screen_x, a_screen_y: INTEGER
		)
			-- Terminate the pick and drop mechanism.
		do
			promote_to_widget
			attached_interface.implementation.end_transport(
				a_x,
				a_y,
				a_button,
				a_x_tilt, a_y_tilt, a_pressure,
				a_screen_x, a_screen_y
			)
		end

	internal_enable_dockable
			-- Platform specific implementation of `enable_drag'.
			-- Does nothing in this implementation.
		do
		end

	internal_disable_dockable
			-- Platform specific implementation of `disable_drag'.
			-- Does nothing in this implementation.
		do
		end

	update_buttons (a_parent: EV_TOOL_BAR; start_index, end_index: INTEGER)
			-- Ensure that buttons from `start_index' to `end_index' in `a_parent' are
			-- refreshed. This is called at the end of  a dockable transport from a tool bar button
			-- as on some platforms, they end up in an invalid state, and need refreshing.
		do
		end

	erase_rubber_band
			-- Erase previously drawn rubber band.
		do
			promote_to_widget
			attached_interface.implementation.erase_rubber_band
		end

	real_pointed_target: detachable EV_PICK_AND_DROPABLE
			-- Target at mouse position
		do
			promote_to_widget
			Result := attached_interface.implementation.real_pointed_target
		end

	set_pointer_style (c: EV_POINTER_STYLE)
			-- Set `c' as new cursor pixmap.
			-- Can be called through `interface'.
		local
			new_imp: detachable EV_PIXMAP_IMP_WIDGET
		do
			promote_to_widget
			new_imp ?= attached_interface.implementation
			check new_imp /= Void then end
			new_imp.set_pointer_style(c)
		end

	internal_set_pointer_style (c: EV_POINTER_STYLE)
			-- Assign `c' to cursor pixmap.
			-- Only called from implementation.
		local
			new_imp: detachable EV_PIXMAP_IMP
		do
			promote_to_widget
			new_imp ?= attached_interface.implementation
			check new_imp /= Void then end
			new_imp.internal_set_pointer_style (c)
		end

	start_transport (
			a_x: INTEGER
			a_y: INTEGER
			a_button: INTEGER
			a_press: BOOLEAN
			a_x_tilt: DOUBLE
			a_y_tilt: DOUBLE
			a_pressure: DOUBLE
			a_screen_x: INTEGER
			a_screen_y: INTEGER
			a_menu_only: BOOLEAN
		)
			-- Start a pick and drop transport.
		do
			promote_to_widget
			attached_interface.implementation.start_transport (
				a_x,
				a_y,
				a_button,
				a_press,
				a_x_tilt,
				a_y_tilt,
				a_pressure,
				a_screen_x,
				a_screen_y,
				a_menu_only
				)
		end

	disable_sensitive
			-- Disable sensitivity to user input events.
		do
			promote_to_widget
			attached_interface.implementation.disable_sensitive
		end

	enable_sensitive
			-- Enable sensitivity to user input events.
		do
			promote_to_widget
			attached_interface.implementation.enable_sensitive
		end

	has_focus: BOOLEAN
			-- Does widget have the keyboard focus?
		do
			promote_to_widget
			Result := attached_interface.implementation.has_focus
		end

	hide
			-- Request that `Current' not be displayed when its parent is.
		do
			promote_to_widget
			attached_interface.implementation.hide
		end

	is_displayed: BOOLEAN
			-- Is `Current' visible on the screen?
			-- False if `Current' is entirely obscured by another window.
		do
			Result := False
		end

	is_sensitive: BOOLEAN
			-- Does `Current' respond to user input events.
		do
			Result := False
		end

	is_show_requested: BOOLEAN
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			Result := False
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels of `Current'.
		do
			Result := height
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels `Current'.
		do
			Result := width
		end

	parent: detachable EV_CONTAINER
			-- Container widget that contains `Current'.
			-- (Void if `Current' is not in a container)
		do
				-- Simple pixmap => not in a container.
			Result := Void
		end

	has_parent: BOOLEAN
		do
			-- Simple pixmap => not in a container.
			Result := False
		end

	has_capture: BOOLEAN
			-- Does widget have capture?
		do
			-- Simple pixmap => not in a container.
			Result := False
		end

	parent_is_sensitive: BOOLEAN
		do
			-- Simple pixmap => not in a container.
			Result := False
		end

	pointer_position: EV_COORDINATE
            -- Position of the screen pointer relative to `Current'.
		do
				-- The pixmap is not on the screen, we
				-- return (0,0)
			create Result
			Result.set (0, 0)
		end

	pointer_style: detachable EV_POINTER_STYLE
			-- Cursor displayed when screen pointer is over `Current'.
		do
			promote_to_widget
			Result := attached_interface.implementation.pointer_style
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen in pixels.
		do
			promote_to_widget
			Result := attached_interface.implementation.screen_x
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen in pixels.
		do
			promote_to_widget
			Result := attached_interface.implementation.screen_y
		end

	set_focus
			-- Grab keyboard focus.
		do
			promote_to_widget
			attached_interface.implementation.set_focus
		end

	reset_minimum_width
			-- Reset the minimum width.
		do
			promote_to_widget
			attached_interface.implementation.reset_minimum_width
		end

	reset_minimum_height
			-- Reset the minimum height.
		do
			promote_to_widget
			attached_interface.implementation.reset_minimum_height
		end

	reset_minimum_size
			-- Reset the minimum size (width and height).
		do
			promote_to_widget
			attached_interface.implementation.reset_minimum_size
		end

	set_minimum_height (a_minimum_height: INTEGER)
			-- Set the minimum vertical size to `a_minimum_height' in pixels.
		do
			promote_to_widget
			attached_interface.implementation.set_minimum_height(a_minimum_height)
		end

	set_minimum_size (
			a_minimum_width: INTEGER
			a_minimum_height: INTEGER
		)
			-- Set the minimum horizontal size to `a_minimum_width' in pixels.
			-- Set the minimum vertical size to `a_minimum_height' in pixels.
		do
			promote_to_widget
			attached_interface.implementation.set_minimum_size (
				a_minimum_width,
				a_minimum_height
				)
		end

	set_minimum_width (a_minimum_width: INTEGER)
			-- Set the minimum horizontal size to `a_minimum_width' in pixels.
		do
			promote_to_widget
			attached_interface.implementation.set_minimum_width(a_minimum_width)
		end

	set_tooltip (a_text: READABLE_STRING_GENERAL)
			-- Set the minimum horizontal size to `a_minimum_width' in pixels.
		do
			promote_to_widget
			attached_interface.implementation.set_tooltip(a_text)
		end

	show
			-- Request that `Current' be displayed when its parent is.
		do
			promote_to_widget
			attached_interface.implementation.show
		end

	tooltip: STRING_32
			-- Text displayed when user moves mouse over widget.
		do
			promote_to_widget
			Result := attached_interface.implementation.tooltip
		end

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
			promote_to_widget
			Result := attached_interface.implementation.x_position
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		do
			promote_to_widget
			Result := attached_interface.implementation.y_position
		end

	redraw
			-- Force `Current' to redraw itself.
		do
			-- Do nothing as `Current' is not displayed on-screen.
		end

invariant
	bitmap_not_void:
		is_initialized implies internal_bitmap /= Void

	bitmap_reference_tracked:
		attached internal_bitmap as l_internal_bitmap implies
			l_internal_bitmap.reference_tracked

	palette_reference_tracked:
		attached palette as l_palette implies l_palette.reference_tracked

	mask_bitmap_reference_tracked:
		attached internal_mask_bitmap as l_internal_mask_bitmap implies
			l_internal_mask_bitmap.reference_tracked

	dc_reference_tracked:
		attached dc as l_dc implies l_dc.reference_tracked

	mask_dc_reference_tracked:
		attached mask_dc as l_mask_dc implies l_mask_dc.reference_tracked;

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
