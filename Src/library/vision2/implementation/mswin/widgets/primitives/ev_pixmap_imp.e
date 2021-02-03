note
	description:
		"Eiffel Vision pixmap. Mswindows implementation for a%N%
		%simple pixmap (not drawable, not self-displayable)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXMAP_IMP

inherit
	EV_PIXMAP_I
		undefine
			save_to_named_path
		redefine
			interface,
			on_parented,
			set_pebble,
			set_actual_drop_target_agent,
			set_pebble_function,
			draw_straight_line,
			disable_initialized
		end

	EV_PIXMAP_IMP_STATE
		redefine
			interface,
			gdi_compact,
			init_from_pixel_buffer
		end

	EV_PIXMAP_IMP_LOADER
		export
			{NONE} all
		end

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Create `Current' empty.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current' to 1x1.
		do
			private_width := 1
			private_height := 1
			private_bitmap_id := -1
			disable_tabable_from
			disable_tabable_to
			set_is_initialized (True)
		end

	init_from_pointer_style (a_pointer_style: EV_POINTER_STYLE)
			-- Initialize from not void `a_pointer_style'.
		do
			check attached {EV_POINTER_STYLE_IMP} a_pointer_style.implementation as l_imp then
				set_with_resource (l_imp.wel_cursor)
			end
		end

	init_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Redefine
		local
			l_gdip_bitmap: detachable WEL_GDIP_BITMAP
		do
			check attached {EV_PIXEL_BUFFER_IMP} a_pixel_buffer.implementation as l_pixel_buffer then
				l_gdip_bitmap := l_pixel_buffer.gdip_bitmap
			end
			if l_gdip_bitmap /= Void and then color_depth = 32 then
					-- We create a 32bit DIB bitmap if possible, so current can have alpha informations.
					-- Because EV_PIXMAP_IMP_STATE doesn't have `private_bitmap' and `private_mask_bitmap' features,
					-- we have to implement it in this class.				
				if attached private_bitmap as l_private_bitmap then
					l_private_bitmap.delete
				end
				if attached private_mask_bitmap as l_private_mask_bitmap then
					l_private_mask_bitmap.delete
				end
				set_bitmap_and_mask (l_gdip_bitmap.new_bitmap, Void, a_pixel_buffer.width, a_pixel_buffer.height)
			else
				Precursor {EV_PIXMAP_IMP_STATE}	(a_pixel_buffer)
			end
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

feature -- Basic Operation

	refresh_now
			-- Force `Current' to be redrawn immediately.
		do
			-- No implementation needed as `Current' is always offscreen
		end

feature {EV_ANY_I, EV_STOCK_PIXMAPS_IMP} -- Loading/Saving

	set_with_resource (a_resource: WEL_GRAPHICAL_RESOURCE)
			-- Initialize the pixmap with the content of `a_resource'.
			-- Exceptions "Unable to retrieve icon information".
		require
			valid_resource: a_resource /= Void and then a_resource.exists
			reference_tracked_for_resource: a_resource.reference_tracked
		do
			reset_bitmap_content
			reset_resource_content

			private_icon := {WEL_ICON} / a_resource
			if private_icon = Void then
				private_cursor := {WEL_CURSOR} / a_resource
			end
			a_resource.increment_reference

			retrieve_pixmap_size
		end

	set_with_default
			-- Initialize the pixmap with the default pixmap (Vision2 logo).
			-- Exceptions "Unable to retrieve icon information".
		do
			reset_bitmap_content
			reset_resource_content

			create pixmap_filename.make_empty
			update_needed := True
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

	read_from_named_path (file_path: PATH)
			-- Load the pixmap described in `file_path'.
			-- Exceptions "No such file or directory",
			--            "Unable to retrieve icon information",
			--            "Unable to load the file".
		local
			pixmap_file: RAW_FILE
		do
			pixmap_filename := file_path
			create pixmap_file.make_with_path (file_path)
			pixmap_file.open_read
			pixmap_file.close

			reset_bitmap_content
			reset_resource_content

			update_needed := True
		end

	set_mask (a_mask: EV_BITMAP)
			-- Set mask of `Current' to `a_mask'.
		do
			check attached {EV_BITMAP_IMP} a_mask.implementation as l_bitmap_imp then
				private_mask_bitmap := l_bitmap_imp.drawable
				l_bitmap_imp.drawable.increment_reference
			end
		end

feature {NONE} -- Saving

	save_with_format (a_format: EV_GRAPHICAL_FORMAT; a_filename: PATH; a_raw_image_data: like raw_image_data)
			-- Call `save' on `a_format'. Implemented in descendant of EV_PIXMAP_IMP_STATE
			-- since `save' from EV_GRAPHICAL_FORMAT is only exported to EV_PIXMAP_I.
		do
			a_format.save (a_raw_image_data, a_filename)
		end

feature {EV_ANY_I, EV_STOCK_PIXMAPS_IMP} -- Misc.

	gdi_compact
			-- Free GDI resource than can be reloaded.
		do
			if pixmap_filename /= Void then
					-- The bitmap/icon can be retrieved from the file,
					-- so we can erase everything.
				reset_bitmap_content
				reset_resource_content
				update_needed := True
			end
		end

feature -- Access

	update_needed: BOOLEAN
			-- Is an update needed?

	update_content
			-- Update the content of `bitmap', `icon', ...
			-- if needed.
		do
			if update_needed then
				reset_bitmap_content
				reset_resource_content
				if pixmap_filename /= Void then
					effective_load_file
				end
				update_needed := False
			end
		end

	icon: detachable WEL_ICON
			-- Current icon used. Void if none.
		do
			update_content
			Result := private_icon
		end

	cursor: detachable WEL_CURSOR
			-- Current cursor used. Void if none.
		do
			update_content
			Result := private_cursor
		end

	get_bitmap: WEL_BITMAP
			-- Current bitmap used.
			--
			-- The number of references if incremented when calling
			-- this feature, call `WEL_BITMAP.decrement_reference'
		local
			l_private_bitmap: detachable WEL_BITMAP
		do
			update_content
			if (private_icon /= Void or private_cursor /= Void) and private_bitmap = Void and
				private_palette = Void and private_mask_bitmap = Void then
				-- Bitmap stocked as WEL_ICON or WEL_CURSOR, turn that
				-- into WEL_BITMAP/WEL_BITMAP.
					retrieve_icon_information
					reset_resource_content
			else
				if private_bitmap = Void then
						-- No bitmap defined, create a new & empty bitmap.
					l_private_bitmap := new_empty_bitmap
					private_bitmap_id := l_private_bitmap.object_id
					private_bitmap := l_private_bitmap
				end
			end
			l_private_bitmap := private_bitmap
			check l_private_bitmap /= Void then end
			l_private_bitmap.increment_reference
			Result := l_private_bitmap
		ensure then
			Result_not_void: Result /= Void
		end

	get_mask_bitmap: detachable WEL_BITMAP
			-- Monochrome bitmap used as mask. Void if none.
			--
			-- The number of references if incremented when calling
			-- this feature, call `WEL_BITMAP.decrement_reference'
		do
			update_content
			if (private_icon /= Void or private_cursor /= Void) and private_bitmap = Void and
				private_palette = Void and private_mask_bitmap = Void then
				-- Bitmap stocked as WEL_ICON or WEL_CURSOR, turn that
				-- into WEL_BITMAP/WEL_BITMAP.
					retrieve_icon_information
					reset_resource_content
			end
			if attached private_mask_bitmap as l_private_mask_bitmap then
				l_private_mask_bitmap.increment_reference
				Result := l_private_mask_bitmap
			end
		end

	has_mask: BOOLEAN
			-- Has `Current' a mask?
		do
			update_content
			if private_icon /= Void or private_cursor /= Void then
				Result := True
			else
				Result := private_mask_bitmap /= Void
			end
		end

	palette: detachable WEL_PALETTE
			-- Current palette used. Void if none.
		do
			update_content
			Result := private_palette
		end

feature {EV_ANY_I} -- Status setting

	stretch (new_width, new_height: INTEGER)
			-- Stretch the image to fit in size
			-- `new_width' by `new_height'.
		local
			tmp_bitmap: detachable WEL_BITMAP
			l_mask_dc, l_old_mask_dc: WEL_MEMORY_DC
			l_mask, l_old_mask: WEL_BITMAP
			l_old_width, l_old_height: INTEGER
		do
			update_content

			l_old_width := width
			l_old_height := height

			if private_bitmap = Void then
				retrieve_icon_information
				reset_resource_content
			end

				-- Stretch the bitmap
			tmp_bitmap := private_bitmap
			check tmp_bitmap /= Void then end
			private_bitmap := stretch_wel_bitmap (
				tmp_bitmap,
				new_width,
				new_height
				)
			tmp_bitmap.decrement_reference

				-- Stretch the mask if any.
			if attached private_mask_bitmap as l_private_mask_bitmap then
				create l_old_mask_dc.make
				l_old_mask_dc.select_bitmap (l_private_mask_bitmap)
				l_old_mask := l_private_mask_bitmap
				l_old_mask_dc.select_bitmap (l_old_mask)

				create l_mask_dc.make
				l_mask_dc.set_background_opaque
				create l_mask.make_compatible (l_mask_dc, new_width, new_height)
				l_mask.enable_reference_tracking
				private_mask_bitmap := l_mask
				l_mask_dc.select_bitmap (l_mask)

				l_mask_dc.stretch_blt (0, 0, new_width, new_height, l_old_mask_dc, 0, 0, l_old_width, l_old_height, {WEL_RASTER_OPERATIONS_CONSTANTS}.srccopy)

					-- Clean up.
				l_old_mask_dc.unselect_bitmap
				l_old_mask_dc.delete
				l_mask_dc.unselect_bitmap
				l_mask_dc.delete
				l_old_mask.decrement_reference
			end

				-- Update the width & height attributes
			private_width := new_width
			private_height := new_height
		end

feature  -- Measurement

	width: INTEGER
			-- Width of `Current'.
		do
			update_content
			Result := private_width
		end

	height: INTEGER
			-- Height of `Current'.
		do
			update_content
			Result := private_height
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

feature {EV_ANY_I} -- Delegated features

	widget_imp_at_pointer_position: detachable EV_WIDGET_IMP
			-- `Result' is widget implementation at current
			-- cursor position.
		do
			check
				must_be_widget_to_get_called: False
			end
		end

	pnd_screen: detachable EV_SCREEN
			-- `Result' is screen used for pick and drop.
		do
			check
				must_be_widget_to_get_called: False
			end
		end

	set_pebble (a_pebble: ANY)
			-- Assign `a_pebble' to `pebble'.
		do
			pebble := a_pebble
			promote_to_widget
			attached_interface.implementation.set_pebble (a_pebble)
		end

	set_pebble_function (a_function: FUNCTION [detachable ANY])
			-- Set `a_function' to compute `pebble'.
		do
			promote_to_widget
			attached_interface.implementation.set_pebble_function (a_function)
		end

	set_actual_drop_target_agent (an_agent: like actual_drop_target_agent)
			-- Assign `an_agent' to `actual_drop_target_agent'.
		do
			actual_drop_target_agent := an_agent
			promote_to_widget
			attached_interface.implementation.set_actual_drop_target_agent (an_agent)
		end

	enable_transport
			-- Enable Pick/Drag and Drop.
			--| This should never be called, but is necessary
			--| As only EV_PIXMAP_IMP_WIDGET is pick and dropable.
		do
			check
				never_called: False
			end
		end

	set_size (new_width, new_height: INTEGER)
			-- Resize the current bitmap. If the new size
			-- is smaller than the old one, the bitmap is
			-- clipped.
		do
			promote_to_drawable
			attached_interface.implementation.set_size (new_width, new_height)
		end

	reset_for_buffering (a_width, a_height: INTEGER)
			-- Resets the size of the pixmap without keeping original image or clearing background.
		do
			promote_to_drawable
			attached_interface.implementation.reset_for_buffering (a_width, a_height)
		end

	redraw
			-- Force `Current' to redraw itself.
		do
			-- Do nothing as `Current' cannot be on-screen to be redrawn.
		end

	clear
			-- Erase `Current' with `background_color'.
		do
			promote_to_drawable
			attached_interface.implementation.clear
		end

	clear_rectangle (x1, y1, a_width, a_height: INTEGER)
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height' in `background_color'.
		do
			promote_to_drawable
			attached_interface.implementation.clear_rectangle (x1, y1, a_width, a_height)
		end

	draw_point (a_x, a_y: INTEGER)
			-- Draw point at position (`x', 'y') on `Current'.
		do
			promote_to_drawable
			attached_interface.implementation.draw_point (a_x, a_y)
		end

	draw_text (a_x, a_y: INTEGER; a_text: READABLE_STRING_GENERAL)
			-- Draw `a_text' at (`x', 'y') using `font'.
		do
			promote_to_drawable
			attached_interface.implementation.draw_text (a_x, a_y, a_text)
		end

	draw_rotated_text (a_x, a_y: INTEGER; a_angle: REAL; a_text: STRING)
			-- Draw `a_text' at (`x', 'y') using `font'.
		do
			promote_to_drawable
			attached_interface.implementation.draw_rotated_text (a_x, a_y, a_angle, a_text)
		end

	draw_text_top_left (a_x, a_y: INTEGER; a_text: READABLE_STRING_GENERAL)
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		do
			promote_to_drawable
			attached_interface.implementation.draw_text_top_left (a_x, a_y, a_text)
		end

	draw_ellipsed_text (a_x, a_y: INTEGER; a_text: READABLE_STRING_GENERAL; clipping_width: INTEGER)
			-- Draw `a_text' at (`x', 'y') using `font'.
		do
			promote_to_drawable
			attached_interface.implementation.draw_ellipsed_text (a_x, a_y, a_text, clipping_width)
		end

	draw_ellipsed_text_top_left (a_x, a_y: INTEGER; a_text: READABLE_STRING_GENERAL; clipping_width: INTEGER)
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		do
			promote_to_drawable
			attached_interface.implementation.draw_ellipsed_text_top_left (a_x, a_y, a_text, clipping_width)
		end

	draw_segment (x1, y1, x2, y2: INTEGER)
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		do
			promote_to_drawable
			attached_interface.implementation.draw_segment (x1, y1, x2, y2)
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER)
			-- Draw infinite straight line through (`x1', 'y1') and
			-- (`x2', 'y2').
		do
			promote_to_drawable
			attached_interface.implementation.draw_straight_line (x1, y1, x2, y2)
		end

	draw_arc (
		a_x					: INTEGER
		a_y					: INTEGER
		a_vertical_radius	: INTEGER
		a_horizontal_radius	: INTEGER
		a_start_angle		: REAL
		an_aperture			: REAL
		)
			-- Draw a part of an ellipse centered on (`x', 'y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle'
			-- + `an_aperture'.
			-- Angles are measured in radians.
		do
			promote_to_drawable
			attached_interface.implementation.draw_arc (
				a_x,
				a_y,
				a_vertical_radius,
				a_horizontal_radius,
				a_start_angle,
				an_aperture
				)
		end

	draw_pixmap (
		a_x					: INTEGER
		a_y					: INTEGER
		a_pixmap			: EV_PIXMAP
		)
			-- Draw `a_pixmap' with upper-left corner on (`x', 'y').
		do
			promote_to_drawable
			attached_interface.implementation.draw_pixmap (
				a_x,
				a_y,
				a_pixmap
				)
		end

	draw_sub_pixmap (
		a_x					: INTEGER;
		a_y					: INTEGER;
		a_pixmap			: EV_PIXMAP;
		area				: EV_RECTANGLE
		)
			-- Draw `area' of `a_pixmap' with upper-left corner on (`x', `y').
		do
			promote_to_drawable
			attached_interface.implementation.draw_sub_pixmap (
				a_x,
				a_y,
				a_pixmap,
				area
				)
		end

	draw_sub_pixel_buffer (x, y: INTEGER; a_pixel_buffer: EV_PIXEL_BUFFER; area: EV_RECTANGLE)
			-- Draw area of `a_pixel_buffer' with upper-left corner on (`x', `y').
		do
			promote_to_drawable
			attached_interface.implementation.draw_sub_pixel_buffer (
				x, y, a_pixel_buffer, area
			)
		end

	draw_rectangle (
		a_x					: INTEGER
		a_y					: INTEGER
		a_width				: INTEGER
		a_height			: INTEGER
		)
			-- Draw rectangle with upper-left corner on (`x', 'y')
			-- with size `a_width' and `a_height'.
		do
			promote_to_drawable
			attached_interface.implementation.draw_rectangle (
				a_x,
				a_y,
				a_width,
				a_height
				)
		end

	draw_ellipse (
		a_x					: INTEGER
		a_y					: INTEGER
		a_vertical_radius	: INTEGER
		a_horizontal_radius	: INTEGER
		)
			-- Draw an ellipse centered on (`x', 'y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
		do
			promote_to_drawable
			attached_interface.implementation.draw_ellipse (
				a_x,
				a_y,
				a_vertical_radius,
				a_horizontal_radius
				)
		end

	draw_polyline (
		points				: ARRAY [EV_COORDINATE]
		is_closed			: BOOLEAN
		)
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		do
			promote_to_drawable
			attached_interface.implementation.draw_polyline (points, is_closed)
		end

	draw_pie_slice (
		a_x					: INTEGER
		a_y					: INTEGER
		a_vertical_radius	: INTEGER
		a_horizontal_radius	: INTEGER
		a_start_angle		: REAL
		an_aperture			: REAL
		)
			-- Draw a part of an ellipse centered on (`x', 'y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle' +
			-- `an_aperture'.
			-- The arc is then closed by two segments through (`x', 'y').
			-- Angles are measured in radians.
		do
			promote_to_drawable
			attached_interface.implementation.draw_pie_slice (
				a_x,
				a_y,
				a_vertical_radius,
				a_horizontal_radius,
				a_start_angle,
				an_aperture
				)
		end

	fill_rectangle (
		a_x					: INTEGER
		a_y					: INTEGER
		a_width				: INTEGER
		a_height			: INTEGER
		)
			-- Draw rectangle with upper-left corner on (`x', 'y')
			-- with size `a_width' and `a_height'. Fill with
			-- `background_color'.
		do
			promote_to_drawable
			attached_interface.implementation.fill_rectangle (
				a_x,
				a_y,
				a_width,
				a_height
				)
		end

	fill_ellipse (
		a_x					: INTEGER
		a_y					: INTEGER
		a_vertical_radius	: INTEGER
		a_horizontal_radius	: INTEGER
		)
			-- Draw an ellipse centered on (`x', 'y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Fill with `background_color'.
		do
			promote_to_drawable
			attached_interface.implementation.fill_ellipse (
				a_x,
				a_y,
				a_vertical_radius,
				a_horizontal_radius
				)
		end

	fill_polygon (
		points				: ARRAY [EV_COORDINATE]
		)
			-- Draw line segments between subsequent points in `points'.
			-- Fill with `background_color'.
		do
			promote_to_drawable
			attached_interface.implementation.fill_polygon (points)
		end

	fill_pie_slice (
		a_x					: INTEGER
		a_y					: INTEGER
		a_vertical_radius	: INTEGER
		a_horizontal_radius	: INTEGER
		a_start_angle		: REAL
		an_aperture			: REAL
		)
			-- Draw a part of an ellipse centered on (`x', 'y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle'
			-- + `an_aperture'.
			-- The arc is then closed by two segments through (`x', 'y').
			-- Angles are measured in radians. Fill with `background_color'.
		do
			promote_to_drawable
			attached_interface.implementation.fill_pie_slice (
				a_x,
				a_y,
				a_vertical_radius,
				a_horizontal_radius,
				a_start_angle,
				an_aperture
				)
			end

	clip_area: detachable EV_RECTANGLE
		do
				-- Simple pixmap => default drawing state.
			Result := Void
		end

	dashed_line_style: BOOLEAN
			-- Are lines drawn dashed?
		do
				-- Simple pixmap => default drawing state.
			Result := False
		end

	disable_dashed_line_style
			-- Draw lines solid.
		do
			promote_to_drawable
			attached_interface.implementation.disable_dashed_line_style
		end

	drawing_mode: INTEGER
			-- `Result' is logical operation on pixels when drawing.
		do
				-- Simple pixmap => default drawing state.
			Result := drawing_mode_copy
		end

	enable_dashed_line_style
			-- Draw lines dashed.
		do
			promote_to_drawable
			attached_interface.implementation.enable_dashed_line_style
		end

	font: EV_FONT
			-- Character appearance on `Current'.
		do
				-- Simple pixmap => default drawing state.
			create Result
		end

	line_width: INTEGER
			-- `Result' is line width of `Current'.
		do
				-- Simple pixmap => default drawing state.
			Result := 1
		end

	remove_clipping
			-- Do not apply any clipping.
		do
			promote_to_drawable
			attached_interface.implementation.remove_clipping
		end

	remove_tile
			-- Do not apply a tile when filling.
		do
			promote_to_drawable
			attached_interface.implementation.remove_tile
		end

	set_clip_area (an_area: EV_RECTANGLE)
			-- Assign `an_area' to the area which will be refreshed.
		do
			promote_to_drawable
			attached_interface.implementation.set_clip_area (an_area)
		end

	set_clip_region (a_region: EV_REGION)
			-- Assign `a_region' to the area which will be refreshed.
		do
			promote_to_drawable
			attached_interface.implementation.set_clip_region (a_region)
		end

	set_drawing_mode (a_mode: INTEGER)
			-- Set drawing mode to `a_logical_mode'.
		do
			promote_to_drawable
			attached_interface.implementation.set_drawing_mode (a_mode)
		end

	set_font (a_font: EV_FONT)
			-- Assign `a_font' to `font'.
		do
			promote_to_drawable
			attached_interface.implementation.set_font (a_font)
		end

	set_line_width (a_width: INTEGER)
			-- Assign `a_width' to `line_width'.
		do
			promote_to_drawable
			attached_interface.implementation.set_line_width (a_width)
		end

	set_tile (a_pixmap: EV_PIXMAP)
			-- Set tile used to fill figures.
			-- Set to Void to use `background_color' to fill.
		do
			promote_to_drawable
			attached_interface.implementation.set_tile (a_pixmap)
		end

	tile: detachable EV_PIXMAP
			-- Pixmap that is used instead of background_color.
			-- If set to Void, `background_color' is used to fill.
		do
				-- Simple implementation => no tile.
			Result := Void
		end

	internal_enable_dockable
			-- Platform specific implementation of `enable_drag'.
			-- Does nothing in this implementation.
		do
		end

	update_buttons (a_parent: EV_TOOL_BAR; start_index, end_index: INTEGER)
			-- Ensure that buttons from `start_index' to `end_index' in `a_parent' are
			-- refreshed. This is called at the end of  a dockable transport from a tool bar button
			-- as on some platforms, they end up in an invalid state, and need refreshing.
		do
		end

	internal_disable_dockable
			-- Platform specific implementation of `disable_drag'.
			-- Does nothing in this implementation.
		do
		end

	disable_capture
            -- Ungrab the user input.
		do
			promote_to_widget
			attached_interface.implementation.disable_capture
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
		do
			promote_to_widget
			attached_interface.implementation.enable_capture
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

	erase_rubber_band
			-- Erase previously drawn rubber band.
		do
			promote_to_widget
			attached_interface.implementation.erase_rubber_band
		end

	real_pointed_target: detachable EV_PICK_AND_DROPABLE
			-- Target at mouse position.
		do
			promote_to_widget
			Result := attached_interface.implementation.real_pointed_target
		end

	set_pointer_style (c: EV_POINTER_STYLE)
			-- Assign `c' to cursor pixmap.
			-- Can be called through `interface'.
		do
			promote_to_widget
			attached_interface.implementation.set_pointer_style (c)
		end

	internal_set_pointer_style (c: EV_POINTER_STYLE)
			-- Assign `c' to cursor pixmap.
			-- Only called from implementation.
		do
			promote_to_widget
			attached_interface.implementation.internal_set_pointer_style (c)
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

	background_color_internal: EV_COLOR
			-- Color used for erasing of canvas.
			-- Default: white.
		do
				-- Returns default background color.
			create Result.make_with_rgb (1, 1, 1)
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

	foreground_color_internal: EV_COLOR
		do
				-- Returns default foreground color.
			create Result.make_with_rgb (0, 0, 0)
		end

	has_focus: BOOLEAN
			-- Does widget have the keyboard focus?
		do
			Result := False
		end

	hide
			-- Request that `Current' not be displayed.
		do
			promote_to_widget
			attached_interface.implementation.hide
		end

	is_displayed: BOOLEAN
			-- Is `Current' visible on the screen?
			-- False if `Current' is entirely obscured by another window.
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

	is_sensitive: BOOLEAN
			-- Does `Current' respond to user input events?
		do
				-- Simple pixmap => not in a container.
			Result := False
		end

	is_show_requested: BOOLEAN
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			if is_destroyed then
				Result := attached_interface.implementation.is_show_requested
			else
					-- Simple pixmap => not in a container.
					-- This should never be called, as `show' upgrades
					-- the implementation.
				Result := False
			end
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
			Result := height
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
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
			-- Cursor displayed when screen pointer is over current widget.
		do
			promote_to_widget
			Result := attached_interface.implementation.pointer_style
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		do
			promote_to_widget
			Result := attached_interface.implementation.screen_x
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		do
			promote_to_widget
			Result := attached_interface.implementation.screen_y
		end

	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'.
		do
			promote_to_drawable
			attached_interface.implementation.set_background_color(a_color)
		end

	set_focus
			-- Grab keyboard focus.
		do
			promote_to_widget
			attached_interface.implementation.set_focus
		end

	set_foreground_color (a_color: EV_COLOR)
			-- Assign `a_color' to `foreground_color'.
		do
			promote_to_drawable
			attached_interface.implementation.set_foreground_color(a_color)
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
			-- Set `tooltip' to `a_text'.
		do
			promote_to_widget
			attached_interface.implementation.set_tooltip (a_text)
		end

	show
			-- Request that `Current' be displayed.
		do
			promote_to_widget
			attached_interface.implementation.show
		end

	tooltip: STRING_32
			-- Text displayed when user moves mouse over widget.
		do
			check
				not_destroyed: not is_destroyed
			end
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

	on_parented
			-- `Current' has just been added to a container.
		do
			promote_to_widget
			attached_interface.implementation.on_parented
		end

	set_anti_aliasing (value: BOOLEAN)
			-- <Precursor>
		do
			promote_to_drawable
			attached_interface.implementation.set_anti_aliasing (value)
		end

feature {EV_PIXMAP_I} -- Implementation

	destroy
			-- Destroy actual object.
		do
				-- Turn off invariant checking.
			set_is_initialized (False)
			set_is_destroyed (True)

				-- Free GDI resources.
			reset_resource_content
			reset_bitmap_content
		end

feature {EV_PIXMAP_I, EV_PIXMAP_IMP_STATE} -- Duplication

	copy_pixmap (other_interface: EV_PIXMAP)
			-- Update `Current' to have same appearence as `other'.
			-- (So as to satisfy `is_equal'.)
		local
			l_private_bitmap: like private_bitmap
		do
			reset_resource_content
			reset_bitmap_content

			if attached {EV_PIXMAP_IMP} other_interface.implementation as other_simple_imp then
				if attached other_simple_imp.pixmap_filename as l_pixmap_filename then
					pixmap_filename := l_pixmap_filename.twin
				end
				private_width := other_simple_imp.private_width
				private_height := other_simple_imp.private_height
				private_bitmap := other_simple_imp.private_bitmap
				l_private_bitmap := private_bitmap
				if l_private_bitmap /= Void then
					l_private_bitmap.increment_reference
					private_bitmap_id := l_private_bitmap.object_id
				end
				private_mask_bitmap := other_simple_imp.private_mask_bitmap
				if attached private_mask_bitmap as l_private_mask_bitmap then
					l_private_mask_bitmap.increment_reference
				end
				private_icon := other_simple_imp.private_icon
				if attached private_icon as l_private_icon then
					l_private_icon.increment_reference
				end
				private_cursor := other_simple_imp.private_cursor
				if attached private_cursor as l_private_cursor then
					l_private_cursor.increment_reference
				end
				private_palette := other_simple_imp.private_palette
				if attached private_palette as l_private_palette then
					l_private_palette.increment_reference
				end
				copy_events_from_other (other_simple_imp)
				update_needed := other_simple_imp.update_needed
			elseif attached {EV_PIXMAP_IMP_STATE} other_interface.implementation as other_imp then
				l_private_bitmap := other_imp.get_bitmap
				check l_private_bitmap /= Void then end
				private_bitmap := l_private_bitmap
				private_bitmap_id := l_private_bitmap.object_id

				if other_imp.has_mask then
					private_mask_bitmap := other_imp.get_mask_bitmap
				end
				if attached other_imp.palette as l_palette then
					private_palette := l_palette
					l_palette.increment_reference
				end
				private_width := l_private_bitmap.width
				private_height := l_private_bitmap.height
				copy_events_from_other (other_imp)
				update_needed := False
			else
				check is_PIXMAP_IMP_or_PIXMAP_IMP_state: False end
			end
				-- Update navigation attribute
			if other_interface.is_tabable_from then
				enable_tabable_from
			else
				disable_tabable_from
			end
			if other_interface.is_tabable_to then
				enable_tabable_to
			else
				disable_tabable_to
			end
		end

feature {EV_PIXMAP_IMP, EV_IMAGE_LIST_IMP} -- Pixmap Filename

	pixmap_filename: detachable PATH
			-- Filename for the pixmap.
			--  * Void if no file is associated with Current.
			--  * Empty string for the default pixmap.

feature {EV_DRAWABLE_IMP, EV_IMAGE_LIST_IMP, EV_PIXMAP_IMP, EV_POINTER_STYLE_IMP} -- Pixmap State

	private_width: INTEGER
			-- Current width

	private_height: INTEGER
			-- Current height

	private_bitmap: detachable WEL_BITMAP
			-- Current bitmap used. Void if not initialized or if
			-- `update_needed' is set.

	private_bitmap_id: INTEGER
			-- `object_id' of first `private_bitmap' set to `Current'. If you add an item
			-- pixmap to an image list, `private_bitmap' is cleared and then reset upon removal.
			-- As we wish to ensure that placing `Current' back in the image list uses the already
			-- cached version, we have to keep the original private_bitmap id.

	private_mask_bitmap: detachable WEL_BITMAP
			-- Monochrome bitmap used as mask. Void if none.

	private_icon: detachable WEL_ICON
			-- Icon representing `Current'. Void if none.

	private_cursor: detachable WEL_CURSOR
			-- Cursor representing `Current'. Void if none.

	private_palette: detachable WEL_PALETTE
			-- Palette for bitmap. Void if none.

feature {EV_ANY_I} -- Implementation

	set_private_bitmap_id (a_value: INTEGER)
			-- Assign `a_vaule' to `private_bitmap_id'.
		do
			private_bitmap_id := a_value
		ensure
			private_bitmap_id_set: private_bitmap_id = a_value
		end

feature {NONE} -- Implementation

	update_fields(
		error_code		: INTEGER -- Loadpixmap_error_xxxx
		data_type		: INTEGER -- Loadpixmap_hicon, ...
		pixmap_width	: INTEGER -- Height of the loaded pixmap
		pixmap_height	: INTEGER -- Width of the loaded pixmap
		rgb_data		: POINTER -- Pointer on a C memory zone
		alpha_data		: POINTER -- Pointer on a C memory zone
		)
			-- Callback function called from the C code by c_ev_load_pixmap.
			-- See `read_from_named_file'.
			-- Exceptions "Unable to retrieve icon information",
			--            "Unable to load the file".
		local
			dib: detachable WEL_DIB
			memory_dc: WEL_MEMORY_DC
			s_dc: WEL_SCREEN_DC
			l_header: WEL_BITMAP_INFO_HEADER
			l_bitmap_info: WEL_BITMAP_INFO
			l_quad: WEL_RGB_QUAD
			l_private_icon: like private_icon
			l_private_bitmap: like private_bitmap
			l_private_mask_bitmap: like private_mask_bitmap
			l_private_palette: like private_palette
		do
			if error_code = Loadpixmap_error_noerror then
				inspect
					data_type
				when Loadpixmap_hicon then
						-- No error while loading the file
						-- create the icon
					create l_private_icon.make_by_pointer (rgb_data)
					private_icon := l_private_icon
					l_private_icon.set_unshared
					l_private_icon.enable_reference_tracking
					retrieve_pixmap_size

				when Loadpixmap_hbitmap then
					create l_private_bitmap.make_by_pointer (rgb_data)
					private_bitmap := l_private_bitmap
					private_bitmap_id := l_private_bitmap.object_id
					l_private_bitmap.set_unshared
					l_private_bitmap.enable_reference_tracking

					create l_private_mask_bitmap.make_by_pointer (alpha_data)
					private_mask_bitmap := l_private_mask_bitmap
					l_private_mask_bitmap.set_unshared
					l_private_mask_bitmap.enable_reference_tracking
					private_width := l_private_bitmap.width
					private_height := l_private_bitmap.height

				when Loadpixmap_rgb_data then
					create l_header.make
					l_header.set_width (pixmap_width)
					l_header.set_height (pixmap_height)
					l_header.set_planes (1)
					l_header.set_bit_count (32)
					l_header.set_compression ({WEL_BI_COMPRESSION_CONSTANTS}.bi_rgb)
					create l_bitmap_info.make (l_header, 0)
						-- We have 4 here because it is 32 bits per pixel.
					create dib.make_with_info_and_data (l_bitmap_info, rgb_data,
						4 * pixmap_width * pixmap_height)
					create s_dc
					s_dc.get
					create l_private_bitmap.make_by_dib (s_dc, dib, Dib_colors_constants.Dib_rgb_colors)
					private_bitmap := l_private_bitmap
					private_bitmap_id := l_private_bitmap.object_id
					l_private_bitmap.enable_reference_tracking
					s_dc.release

						-- Update the size
					private_width := l_private_bitmap.width
					private_height := l_private_bitmap.height

						-- We reused the palette, we need to temporarily share
						-- the palette object so that it doesn't get destroyed when
						-- we dispose the DIB, then unshare it afterwards.
					l_private_palette := dib.palette
					check l_private_palette /= Void end
					private_palette := l_private_palette
					l_private_palette.set_shared
					l_private_palette.enable_reference_tracking

					dib.dispose
					dib := Void

						-- Reset shared status back to unshared.
					l_private_palette.set_unshared

						-- Let's build the mask.
					if alpha_data /= Default_pointer then
						create l_header.make
						l_header.set_width (pixmap_width)
						l_header.set_height (pixmap_height)
						l_header.set_planes (1)
						l_header.set_bit_count (1)
						l_header.set_compression ({WEL_BI_COMPRESSION_CONSTANTS}.bi_rgb)
						l_header.set_clr_used (2)
						l_header.set_clr_important (2)
						create l_bitmap_info.make (l_header, 2)
						l_quad := l_bitmap_info.rgb_quad (0)
						l_quad.set_red (0)
						l_quad.set_green (0)
						l_quad.set_blue (0)
						l_quad.set_reserved (0)
						l_quad := l_bitmap_info.rgb_quad (1)
						l_quad.set_red (0xFF)
						l_quad.set_green (0xFF)
						l_quad.set_blue (0xFF)
						l_quad.set_reserved (0xFF)
							-- The size of a row is more difficult to compute here because we have 1 bit/color
							-- and it needs to be 32-bit aligned.
						create dib.make_with_info_and_data (l_bitmap_info, alpha_data,
							(4 * ((pixmap_width + 31) // 32)) * pixmap_height)

						create memory_dc.make
						create l_private_mask_bitmap.make_by_dib (
							memory_dc, dib,
							Dib_colors_constants.Dib_rgb_colors
							)
						private_mask_bitmap := l_private_mask_bitmap
						l_private_mask_bitmap.enable_reference_tracking

						memory_dc.unselect_all
						memory_dc.delete

						-- We don't need the DIB, and it consumes a GDI
						-- resource, so we dispose it.
						dib.palette.enable_reference_tracking
						dib.dispose
						dib := Void
					end
				end
			else
				last_pixmap_loading_had_error := True
			end

				-- Enable invariant checking again
			set_is_initialized (True)
		end

	new_empty_bitmap: WEL_BITMAP
			-- Initialize `bitmap' with an empty `width'x`height' bitmap.
			--
			-- Call `WEL_BITMAP.decrement_reference' when Result is no
			-- more needed to free a GDI resource.
		do
			create Result.make_direct (width, height, 1, 1, "%/255/")
			Result.enable_reference_tracking
		end

	reset_resource_content
			-- Reset the resource-content (icon, cursor) and free
			-- any allocated GDI resource.
		do
			if attached private_icon as l_private_icon then
				l_private_icon.decrement_reference
				private_icon := Void
			elseif attached private_cursor as l_private_cursor then
				l_private_cursor.decrement_reference
				private_cursor := Void
			end
		end

	reset_bitmap_content
			-- Reset the bitmap-content (bitmap, mask, palette) and free
			-- any allocated GDI resource.
		do
			if attached private_bitmap as l_private_bitmap then
				l_private_bitmap.decrement_reference
				private_bitmap := Void
			end
			if attached private_mask_bitmap as l_private_mask_bitmap then
				l_private_mask_bitmap.decrement_reference
				private_mask_bitmap := Void
			end
			if attached private_palette as l_private_palette then
				l_private_palette.decrement_reference
				private_palette := Void
			end
		end

	promote_to_drawable
			-- Promote the current implementation to
			-- EV_PIXMAP_IMP_DRAWABLE which allows
			-- drawing operations on the pixmap.
		local
			drawable_pixmap: EV_PIXMAP_IMP_DRAWABLE
		do
				-- Discard current implementation
			if not is_destroyed then
				create drawable_pixmap.make_with_simple (Current)
				attached_interface.replace_implementation (drawable_pixmap)
				safe_destroy
			end
		end

	promote_to_widget
			-- Promote the current implementation to
			-- EV_PIXMAP_IMP_WIDGET which allows
			-- drawing operations on the pixmap and
			-- display on the screen.
		local
			widget_pixmap: EV_PIXMAP_IMP_WIDGET
		do
			if not is_destroyed then
				create widget_pixmap.make_with_simple (Current)
				attached_interface.replace_implementation (widget_pixmap)

					-- Discard current implementation
				safe_destroy
			end
		end

	stretch_wel_bitmap(
			old_bitmap	: WEL_BITMAP
			new_width	: INTEGER
			new_height	: INTEGER
		): WEL_BITMAP
			-- Stretch `old_bitmap' to fit in size `new_width' by
			-- `new_height'. The resulting bitmap is stored in `Result'
			--
			-- Call `WEL_BITMAP.decrement_reference' when Result is no
			-- more needed to free a GDI resource.
		local
			new_bitmap	: WEL_BITMAP
			new_dc		: WEL_MEMORY_DC
			old_dc		: WEL_MEMORY_DC
			old_width	: INTEGER
			old_height	: INTEGER
			s_dc		: WEL_SCREEN_DC
		do
				-- Get a screen dc to create our temporary DCs
			create s_dc
			s_dc.get

				-- Retrieve the current values
			old_width := old_bitmap.width
			old_height := old_bitmap.height
			create old_dc.make_by_dc(s_dc)
			old_dc.select_bitmap(old_bitmap)

				-- create and assign a new bitmap & bitmap_dc
			s_dc.set_background_transparent
			create new_dc.make_by_dc (s_dc)
			create new_bitmap.make_compatible (
				s_dc,
				new_width,
				new_height
				)
			new_bitmap.enable_reference_tracking
			new_dc.select_bitmap (new_bitmap)

			new_dc.set_stretch_blt_mode ({WEL_STRETCH_MODE_CONSTANTS}.color_on_color)

				-- Stretch the content of the old bitmap into the
				-- new one
			new_dc.stretch_blt(
				0, 							-- x dest.
				0, 							-- y dest.
				new_width,					-- width dest
				new_height,					-- height dest
				old_dc, 					-- dc source
				0,							-- x source
				0, 							-- y source
				old_width,					-- width source
				old_height,					-- height source
				Raster_operations_constants.Srccopy	-- copy mode
				)

				-- Clean up the DCs.
			new_dc.unselect_bitmap
			new_dc.delete
			old_dc.unselect_bitmap
			old_dc.delete
			s_dc.release

			Result := new_bitmap
		end

	retrieve_pixmap_size
			-- Retrieve the width and the height of the image
			-- from the icon or cursor handle.
		require
			icon_or_cursor_defined: private_icon /= Void or private_cursor /= Void
		local
			icon_info: detachable WEL_ICON_INFO
			info_mask_bitmap: WEL_BITMAP
		do
				-- Retrieve the information from the icon/cursor
			if attached private_icon as l_private_icon then
				icon_info := l_private_icon.get_icon_info
			elseif attached private_cursor as l_private_cursor then
				icon_info := l_private_cursor.get_icon_info
			else
				check False end
			end

				-- Ensure that we successfully retrieved the information.
			if icon_info = Void then
					-- Impossibility to retrieve the info... just guessing.
				private_width := 16
				private_height := 16
			else
					-- Track the GDI resources to free them as soon as possible.
				icon_info.enable_reference_tracking_on_bitmaps

					-- Retrieve the size from the icon information.
				info_mask_bitmap := icon_info.mask_bitmap
				private_width := info_mask_bitmap.width
				if not icon_info.has_color_bitmap then
						-- We have here a black & white icon.
						-- `mask_bitmap' is formatted so that the upper half is the
						-- icon AND bitmask and the lower half is the icon XOR
						-- bitmask. Under this condition, the height should be
						-- an even multiple of two.
					private_height := info_mask_bitmap.height // 2
				else
						-- Color icon, classic !
					private_height := info_mask_bitmap.height
				end

					-- We don't need the icon_info and its bitmaps, free GDI objects.
				icon_info.dispose
			end
		end

	retrieve_icon_information
			-- Retrieve the bitmap and the mask bitmap from the
			-- icon handle or the cursor handle.
		require
			icon_or_cursor_defined:
				private_icon /= Void or
				private_cursor /= Void
			no_bitmap:
				private_bitmap = Void and
				private_palette = Void and
				private_mask_bitmap = Void
		local
			icon_info: detachable WEL_ICON_INFO
			mem1_dc: WEL_MEMORY_DC
			mem2_dc: WEL_MEMORY_DC
			s_dc: WEL_SCREEN_DC
			new_width : INTEGER
			new_height: INTEGER
			icon_mask_bitmap: WEL_BITMAP
			a_wel_bitmap: detachable WEL_BITMAP
			mask_dest_dc: WEL_MEMORY_DC
			l_private_bitmap: like private_bitmap
			l_private_mask_bitmap: like private_mask_bitmap
		do
				-- Retrieve the information from the icon/cursor
			if attached icon as l_icon then
				icon_info := l_icon.get_icon_info
			elseif attached cursor as l_cursor then

				icon_info := l_cursor.get_icon_info
			end

				-- Ensure that we successfully retrieved the information.
			if icon_info = Void then
				exception_raise ("Unable to retrieve icon information")
			end
			check icon_info /= Void then end
			icon_info.enable_reference_tracking_on_bitmaps

				-- Retrieve the new `bitmap' and `mask_bitmap' from
				-- the icon information.
			if not icon_info.has_color_bitmap then
					-- We have here a black & white icon.
					-- `mask_bitmap' is formatted so that the upper half is the
					-- icon AND bitmask and the lower half is the icon XOR
					-- bitmask. Under this condition, the height should be
					-- an even multiple of two.
				icon_mask_bitmap := icon_info.mask_bitmap
				new_width := icon_mask_bitmap.width
				new_height := icon_mask_bitmap.height // 2

					-- Get a screen dc to create our temporary DCs
				create s_dc
				s_dc.get

					-- Associate `mem1_dc' with `icon_mask_bitmap'.
				create mem1_dc.make_by_dc (s_dc)
				mem1_dc.select_bitmap (icon_mask_bitmap)

					-- Associate `mem2_dc' with `bitmap'.
				create mem2_dc.make_by_dc (s_dc)
				create l_private_bitmap.make_compatible (mem2_dc, new_width, new_height)
				private_bitmap := l_private_bitmap
				private_bitmap_id := l_private_bitmap.object_id
				l_private_bitmap.enable_reference_tracking

				a_wel_bitmap := get_bitmap
				mem2_dc.select_bitmap (a_wel_bitmap)

					-- Copy the second half of `icon_mask_bitmap' into
					-- `bitmap'			
				mem2_dc.bit_blt (0, 0, new_width, new_height,
					mem1_dc, 0, new_height, Raster_operations_constants.Srccopy)

				mem2_dc.unselect_bitmap
				a_wel_bitmap.decrement_reference

					-- Associate `mem2_dc' with `mask_bitmap'.
				create l_private_mask_bitmap.make_compatible (mem2_dc,
					new_width, new_height)
				l_private_mask_bitmap.enable_reference_tracking
				private_mask_bitmap := l_private_mask_bitmap

				a_wel_bitmap := get_mask_bitmap
				check a_wel_bitmap /= Void then end
				mem2_dc.select_bitmap (a_wel_bitmap)

					-- Copy the first half of `icon_mask_bitmap' into
					-- `mask_bitmap'			
				mem2_dc.bit_blt (0, 0, new_width, new_height,
					mem1_dc, 0, 0, Raster_operations_constants.notsrccopy)

					-- Free memory				
				mem2_dc.unselect_bitmap
				mem2_dc.delete
				a_wel_bitmap.decrement_reference
				mem1_dc.unselect_bitmap
				mem1_dc.delete
				s_dc.release
			else
					-- Everything went ok, replace the bitmaps
				l_private_bitmap := icon_info.color_bitmap
				private_bitmap := l_private_bitmap
				private_bitmap_id := l_private_bitmap.object_id
				l_private_bitmap.increment_reference

					-- Flip the mask as 1 means full opacity in Vision2.
				create l_private_mask_bitmap.make_by_bitmap (icon_info.mask_bitmap)
				private_mask_bitmap := l_private_mask_bitmap
				l_private_mask_bitmap.enable_reference_tracking
				create mask_dest_dc.make
				mask_dest_dc.select_bitmap (l_private_mask_bitmap)
				mask_dest_dc.pat_blt (0, 0, l_private_mask_bitmap.width, l_private_mask_bitmap.height, {WEL_RASTER_OPERATIONS_CONSTANTS}.dstinvert)
				mask_dest_dc.unselect_bitmap
				mask_dest_dc.delete
			end

				-- Clean up the structure and free GDI Objects.
			icon_info.delete
		ensure
			private_bitmap_not_void: private_bitmap /= Void
			private_mask_bitmap_not_void: private_mask_bitmap /= Void
			has_mask: has_mask
		end

	disable_initialized
			-- Ensure `is_initialized' = False.
		do
			set_is_initialized (False)
		end

feature {NONE} -- Color depth implementation

	color_depth: INTEGER
			-- Current screen color depth.
		do
			init_color_depth
			Result := color_depth_cell.item
		ensure
			positive: Result > 0
		end

	init_color_depth
			-- Initialize all `color_depth' related stuffs.
		once ("PROCESS")
			refresh_color_depth
			register_color_depth_action
		end

	register_color_depth_action
			-- Add action to system color change actions.
		local
			l_env: EV_ENVIRONMENT
			l_app_i: EV_APPLICATION_I
		do
			create l_env
			l_app_i := l_env.implementation.application_i
			l_app_i.system_color_change_actions.extend (agent refresh_color_depth)
		ensure
			action_added:
		end

	refresh_color_depth
			-- Screen color depth
		local
			l_screen: WEL_SCREEN_DC
		do
			create l_screen
			l_screen.get
			color_depth_cell.put (l_screen.device_caps (({WEL_CAPABILITIES_CONSTANTS}.bits_pixel)))
			l_screen.delete
		end

	color_depth_cell: CELL [INTEGER]
			-- Color depth singleton cell
		once
			create Result.put (0)
		ensure
			not_void: Result /= Void
		end

feature {NONE} -- Constants

	Loadpixmap_error_noerror: INTEGER = 0
		-- No error.

	Loadpixmap_rgb_data: INTEGER = 0
		-- Pointer on a DIB structure.

	Loadpixmap_hicon: INTEGER = 2
		-- Pointer on a HICON handle.

	Loadpixmap_hbitmap: INTEGER = 3
		-- Pointer on a HBITMAP handle.

	Dib_colors_constants: WEL_DIB_COLORS_CONSTANTS
			-- Class containing the DIB_COLORS constants.
		once
			create Result
		end

	Raster_operations_constants: WEL_RASTER_OPERATIONS_CONSTANTS
			-- Class containing the RASTER_OPERATIONS constants.
		once
			create Result
		end

	Idi_constants: WEL_IDI_CONSTANTS
		once
			create Result
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PIXMAP note option: stable attribute end

feature {EV_DRAWABLE_IMP} -- Implementation

	sub_pixmap (area: EV_RECTANGLE): EV_PIXMAP
			-- Pixmap region of `Current' represented by rectangle `area'
		do
			promote_to_drawable
			check attached {EV_PIXMAP_IMP_DRAWABLE} attached_interface.implementation as l_drawable_pixmap then
				Result := l_drawable_pixmap.sub_pixmap (area)
			end
		end

	set_bitmap_and_mask (a_bitmap: WEL_BITMAP; a_mask: detachable WEL_BITMAP; a_bitmap_width, a_bitmap_height: INTEGER)
			-- Set `private_bitmap' and `private_mask_bitmap' of `Current' to `a_bitmap' and `a_mask'
			-- `a_bitmap_width' and `a_bitmap_height' avoid calculating `width' and `height' from logical bitmap
		require
			not_already_initialized: private_bitmap = Void and private_mask_bitmap = Void
			a_bitmap_not_void: a_bitmap /= Void
			a_bitmap_width_valid: a_bitmap_width > 0
			a_bitmap_height_valid: a_bitmap_height > 0
		do
			private_bitmap := a_bitmap
			private_bitmap_id := a_bitmap.object_id
			a_bitmap.enable_reference_tracking
			if a_mask /= Void then
				private_mask_bitmap := a_mask
				a_mask.enable_reference_tracking
			end
			private_width := a_bitmap_width
			private_height := a_bitmap_height
		end

invariant
	not_both_icon_and_cursor:
		not (attached private_icon and attached private_cursor)

	bitmap_reference_tracked:
		attached private_bitmap as l_private_bitmap implies
			l_private_bitmap.reference_tracked

	palette_reference_tracked:
		attached private_palette as l_private_palette implies
			l_private_palette.reference_tracked

	mask_reference_tracked:
		attached private_mask_bitmap as l_private_mask_bitmap implies
			l_private_mask_bitmap.reference_tracked

	icon_reference_tracked:
		attached private_icon as l_private_icon implies
			l_private_icon.reference_tracked

	cursor_reference_tracked:
		attached private_cursor as l_private_cursor implies
			l_private_cursor.reference_tracked

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
