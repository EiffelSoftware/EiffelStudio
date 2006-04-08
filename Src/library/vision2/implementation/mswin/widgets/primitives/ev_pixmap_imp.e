indexing
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
			save_to_named_file
		redefine
			interface,
			on_parented,
			set_with_default,
			set_pebble,
			set_actual_drop_target_agent,
			set_pebble_function,
			draw_straight_line,
			disable_initialized
		end

	EV_PIXMAP_IMP_STATE
		redefine
			interface,
			gdi_compact
		end

	EV_PIXMAP_IMP_LOADER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' empty.
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize `Current' to 1x1.
		do
			private_width := 1
			private_height := 1
			private_bitmap_id := -1
			set_is_initialized (True)
		end

feature -- Basic Operation

	refresh_now is
			-- Force `Current' to be redrawn immediately.
		do
			-- No implementation needed as `Current' is always offscreen
		end

feature {EV_ANY_I, EV_STOCK_PIXMAPS_IMP} -- Loading/Saving

	set_with_resource (a_resource: WEL_GRAPHICAL_RESOURCE) is
			-- Initialize the pixmap with the content of `a_resource'.
			-- Exceptions "Unable to retrieve icon information".
		require
			valid_resource: a_resource /= Void and then a_resource.exists
			reference_tracked_for_resource: a_resource.reference_tracked
		do
			reset_bitmap_content
			reset_resource_content

			private_icon ?= a_resource
			if private_icon = Void then
				private_cursor ?= a_resource
			end
			a_resource.increment_reference

			retrieve_pixmap_size
		end

	set_with_default is
			-- Initialize the pixmap with the default pixmap (Vision2 logo).
			-- Exceptions "Unable to retrieve icon information".
		do
			reset_bitmap_content
			reset_resource_content

			pixmap_filename := ""
			update_needed := True
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

	read_from_named_file (file_name: STRING) is
			-- Load the pixmap described in 'file_name'. 
			-- Exceptions "No such file or directory",
			--            "Unable to retrieve icon information",
			--            "Unable to load the file".
		local
			pixmap_file: RAW_FILE
		do
			create pixmap_file.make_open_read (file_name)
			pixmap_file.close

			reset_bitmap_content
			reset_resource_content

			pixmap_filename := file_name.twin
			update_needed := True
		end

	set_mask (a_mask: EV_BITMAP) is
			-- Set mask of `Current' to `a_mask'.
		local
			l_bitmap_imp: EV_BITMAP_IMP
		do
			l_bitmap_imp ?= a_mask.implementation
			private_mask_bitmap := l_bitmap_imp.drawable
			private_mask_bitmap.increment_reference
		end

feature {NONE} -- Saving

	save_with_format (a_format: EV_GRAPHICAL_FORMAT; a_filename: FILE_NAME; a_raw_image_data: like raw_image_data) is
			-- Call `save' on `a_format'. Implemented in descendant of EV_PIXMAP_IMP_STATE
			-- since `save' from EV_GRAPHICAL_FORMAT is only exported to EV_PIXMAP_I.
		do
			a_format.save (a_raw_image_data, a_filename)
		end

feature {EV_ANY_I, EV_STOCK_PIXMAPS_IMP} -- Misc.

	gdi_compact is
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

	update_content is
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

	icon: WEL_ICON is
			-- Current icon used. Void if none.
		do
			update_content
			Result := private_icon
		end

	cursor: WEL_CURSOR is
			-- Current cursor used. Void if none.
		do
			update_content
			Result := private_cursor
		end

	get_bitmap: WEL_BITMAP is
			-- Current bitmap used.
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
			else
				if private_bitmap = Void then
						-- No bitmap defined, create a new & empty bitmap.
					private_bitmap := new_empty_bitmap
					private_bitmap_id := private_bitmap.object_id
				end
			end
			check
				private_bitmap_not_void: private_bitmap /= Void
			end
			private_bitmap.increment_reference
			Result := private_bitmap
		ensure then
			Result_not_void: Result /= Void
		end

	get_mask_bitmap: WEL_BITMAP is
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
			if private_mask_bitmap /= Void then
				private_mask_bitmap.increment_reference
			end
			Result := private_mask_bitmap
		end

	has_mask: BOOLEAN is
			-- Has `Current' a mask?
		do
			update_content
			if private_icon /= Void or private_cursor /= Void then
				Result := True
			else
				Result := private_mask_bitmap /= Void
			end
		end

	palette: WEL_PALETTE is
			-- Current palette used. Void if none.
		do
			update_content
			Result := private_palette
		end

feature {EV_ANY_I} -- Status setting

	stretch (new_width, new_height: INTEGER) is
			-- Stretch the image to fit in size
			-- `new_width' by `new_height'.
		local
			tmp_bitmap: WEL_BITMAP
		do
			update_content

			if private_bitmap = Void then
				retrieve_icon_information
				reset_resource_content
			end

				-- Stretch the bitmap
			tmp_bitmap := private_bitmap
			private_bitmap := stretch_wel_bitmap (
				tmp_bitmap,
				new_width,
				new_height
				)
			tmp_bitmap.decrement_reference

				-- Stretch the mask if any.
			if private_mask_bitmap /= Void then
				tmp_bitmap := private_mask_bitmap
				private_mask_bitmap := stretch_wel_bitmap (
					tmp_bitmap,
					new_width,
					new_height
					)
				tmp_bitmap.decrement_reference
			end

				-- Update the width & height attributes
			private_width := new_width
			private_height := new_height
		end

feature  -- Measurement

	width: INTEGER is
			-- Width of `Current'.
		do
			update_content
			Result := private_width
		end

	height: INTEGER is
			-- Height of `Current'.
		do
			update_content
			Result := private_height
		end

feature {EV_ANY_I} -- Delegated features

	widget_imp_at_pointer_position: EV_WIDGET_IMP is
			-- `Result' is widget implementation at current
			-- cursor position.
		do
			check
				must_be_widget_to_get_called: False
			end
		end

	pnd_screen: EV_SCREEN is
			-- `Result' is screen used for pick and drop.
		do
			check
				must_be_widget_to_get_called: False
			end
		end

	set_pebble (a_pebble: like pebble) is
			-- Assign `a_pebble' to `pebble'.
		do
			pebble := a_pebble
			promote_to_widget
			interface.implementation.set_pebble (a_pebble)
		end

	set_pebble_function (a_function: FUNCTION [ANY, TUPLE, ANY]) is
			-- Set `a_function' to compute `pebble'.
		do
			promote_to_widget
			interface.implementation.set_pebble_function (a_function)
		end

	set_actual_drop_target_agent (an_agent: like actual_drop_target_agent) is
			-- Assign `an_agent' to `actual_drop_target_agent'.
		do
			actual_drop_target_agent := an_agent
			promote_to_widget
			interface.implementation.set_actual_drop_target_agent (an_agent)
		end

	enable_transport is
			-- Enable Pick/Drag and Drop.
			--| This should never be called, but is necessary
			--| As only EV_PIXMAP_IMP_WIDGET is pick and dropable.
		do
			check
				never_called: False
			end
		end

	set_size (new_width, new_height: INTEGER) is
			-- Resize the current bitmap. If the new size
			-- is smaller than the old one, the bitmap is
			-- clipped.
		do
			promote_to_drawable
			interface.implementation.set_size (new_width, new_height)
		end

	reset_for_buffering (a_width, a_height: INTEGER) is
			-- Resets the size of the pixmap without keeping original image or clearing background.
		do
			promote_to_drawable
			interface.implementation.reset_for_buffering (a_width, a_height)
		end

	redraw is
			-- Force `Current' to redraw itself.
		do
			-- Do nothing as `Current' cannot be on-screen to be redrawn.
		end

	clear is
			-- Erase `Current' with `background_color'.
		do
			promote_to_drawable
			interface.implementation.clear
		end

	clear_rectangle (x1, y1, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height' in `background_color'.
		do
			promote_to_drawable
			interface.implementation.clear_rectangle (x1, y1, a_width, a_height)
		end

	draw_point (a_x, a_y: INTEGER) is
			-- Draw point at position (`x', 'y') on `Current'.
		do
			promote_to_drawable
			interface.implementation.draw_point (a_x, a_y)
		end

	draw_text (a_x, a_y: INTEGER; a_text: STRING_GENERAL) is
			-- Draw `a_text' at (`x', 'y') using `font'.
		do
			promote_to_drawable
			interface.implementation.draw_text (a_x, a_y, a_text)
		end

	draw_rotated_text (a_x, a_y: INTEGER; a_angle: REAL; a_text: STRING) is
			-- Draw `a_text' at (`x', 'y') using `font'.
		do
			promote_to_drawable
			interface.implementation.draw_rotated_text (a_x, a_y, a_angle, a_text)
		end

	draw_text_top_left (a_x, a_y: INTEGER; a_text: STRING_GENERAL) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		do
			promote_to_drawable
			interface.implementation.draw_text_top_left (a_x, a_y, a_text)
		end

	draw_ellipsed_text (a_x, a_y: INTEGER; a_text: STRING_GENERAL; clipping_width: INTEGER) is
			-- Draw `a_text' at (`x', 'y') using `font'.
		do
			promote_to_drawable
			interface.implementation.draw_ellipsed_text (a_x, a_y, a_text, clipping_width)
		end

	draw_ellipsed_text_top_left (a_x, a_y: INTEGER; a_text: STRING_GENERAL; clipping_width: INTEGER) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		do
			promote_to_drawable
			interface.implementation.draw_ellipsed_text_top_left (a_x, a_y, a_text, clipping_width)
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		do
			promote_to_drawable
			interface.implementation.draw_segment (x1, y1, x2, y2)
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER) is
			-- Draw infinite straight line through (`x1', 'y1') and
			-- (`x2', 'y2').
		do
			promote_to_drawable
			interface.implementation.draw_straight_line (x1, y1, x2, y2)
		end

	draw_arc (
		a_x					: INTEGER
		a_y					: INTEGER
		a_vertical_radius	: INTEGER
		a_horizontal_radius	: INTEGER
		a_start_angle		: REAL
		an_aperture			: REAL
		) is
			-- Draw a part of an ellipse centered on (`x', 'y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle'
			-- + `an_aperture'.
			-- Angles are measured in radians.
		do
			promote_to_drawable
			interface.implementation.draw_arc (
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
		) is
			-- Draw `a_pixmap' with upper-left corner on (`x', 'y').
		do
			promote_to_drawable
			interface.implementation.draw_pixmap (
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
		) is
			-- Draw `area' of `a_pixmap' with upper-left corner on (`x', `y').
		do
			promote_to_drawable
			interface.implementation.draw_sub_pixmap (
				a_x,
				a_y,
				a_pixmap,
				area
				)
		end

	draw_rectangle (
		a_x					: INTEGER
		a_y					: INTEGER
		a_width				: INTEGER
		a_height			: INTEGER
		) is
			-- Draw rectangle with upper-left corner on (`x', 'y')
			-- with size `a_width' and `a_height'.
		do
			promote_to_drawable
			interface.implementation.draw_rectangle (
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
		) is
			-- Draw an ellipse centered on (`x', 'y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
		do
			promote_to_drawable
			interface.implementation.draw_ellipse (
				a_x,
				a_y,
				a_vertical_radius,
				a_horizontal_radius
				)
		end

	draw_polyline (
		points				: ARRAY [EV_COORDINATE]
		is_closed			: BOOLEAN
		) is
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		do
			promote_to_drawable
			interface.implementation.draw_polyline (points, is_closed)
		end

	draw_pie_slice (
		a_x					: INTEGER
		a_y					: INTEGER
		a_vertical_radius	: INTEGER
		a_horizontal_radius	: INTEGER
		a_start_angle		: REAL
		an_aperture			: REAL
		) is
			-- Draw a part of an ellipse centered on (`x', 'y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle' +
			-- `an_aperture'.
			-- The arc is then closed by two segments through (`x', 'y').
			-- Angles are measured in radians.
		do
			promote_to_drawable
			interface.implementation.draw_pie_slice (
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
		) is
			-- Draw rectangle with upper-left corner on (`x', 'y')
			-- with size `a_width' and `a_height'. Fill with
			-- `background_color'.
		do
			promote_to_drawable
			interface.implementation.fill_rectangle (
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
		) is
			-- Draw an ellipse centered on (`x', 'y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Fill with `background_color'.
		do
			promote_to_drawable
			interface.implementation.fill_ellipse (
				a_x,
				a_y,
				a_vertical_radius,
				a_horizontal_radius
				)
		end

	fill_polygon (
		points				: ARRAY [EV_COORDINATE]
		) is
			-- Draw line segments between subsequent points in `points'.
			-- Fill with `background_color'.
		do
			promote_to_drawable
			interface.implementation.fill_polygon (points)
		end

	fill_pie_slice (
		a_x					: INTEGER
		a_y					: INTEGER
		a_vertical_radius	: INTEGER
		a_horizontal_radius	: INTEGER
		a_start_angle		: REAL
		an_aperture			: REAL
		) is
			-- Draw a part of an ellipse centered on (`x', 'y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle'
			-- + `an_aperture'.
			-- The arc is then closed by two segments through (`x', 'y').
			-- Angles are measured in radians. Fill with `background_color'.
		do
			promote_to_drawable
			interface.implementation.fill_pie_slice (
				a_x,
				a_y,
				a_vertical_radius,
				a_horizontal_radius,
				a_start_angle,
				an_aperture
				)
			end

	clip_area: EV_RECTANGLE is
		do
				-- Simple pixmap => default drawing state.
			Result := Void
		end

	dashed_line_style: BOOLEAN is
			-- Are lines drawn dashed?
		do
				-- Simple pixmap => default drawing state.
			Result := False
		end

	disable_dashed_line_style is
			-- Draw lines solid.
		do
			promote_to_drawable
			interface.implementation.disable_dashed_line_style
		end

	drawing_mode: INTEGER is
			-- `Result' is logical operation on pixels when drawing.
		do
				-- Simple pixmap => default drawing state.
			Result := drawing_mode_copy
		end

	enable_dashed_line_style is
			-- Draw lines dashed.
		do
			promote_to_drawable
			interface.implementation.enable_dashed_line_style
		end

	font: EV_FONT is
			-- Character appearance on `Current'.
		do
				-- Simple pixmap => default drawing state.
			create Result
		end

	line_width: INTEGER is
			-- `Result' is line width of `Current'.
		do
				-- Simple pixmap => default drawing state.
			Result := 1
		end

	remove_clip_area is
			-- Do not apply any clipping.
		do
			promote_to_drawable
			interface.implementation.remove_clip_area
		end

	remove_tile is
			-- Do not apply a tile when filling.
		do
			promote_to_drawable
			interface.implementation.remove_tile
		end

	set_clip_area (an_area: EV_RECTANGLE) is
			-- Assign `an_area' to the area which will be refreshed.
		do
			promote_to_drawable
			interface.implementation.set_clip_area (an_area)
		end

	set_drawing_mode (a_mode: INTEGER) is
			-- Set drawing mode to `a_logical_mode'.
		do
			promote_to_drawable
			interface.implementation.set_drawing_mode (a_mode)
		end

	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		do
			promote_to_drawable
			interface.implementation.set_font (a_font)
		end

	set_line_width (a_width: INTEGER) is
			-- Assign `a_width' to `line_width'.
		do
			promote_to_drawable
			interface.implementation.set_line_width (a_width)
		end

	set_tile (a_pixmap: EV_PIXMAP) is
			-- Set tile used to fill figures.
			-- Set to Void to use `background_color' to fill.
		do
			promote_to_drawable
			interface.implementation.set_tile (a_pixmap)
		end

	tile: EV_PIXMAP is
			-- Pixmap that is used instead of background_color.
			-- If set to Void, `background_color' is used to fill.
		do
				-- Simple implementation => no tile.
			Result := Void
		end

	internal_enable_dockable is
			-- Platform specific implementation of `enable_drag'.
			-- Does nothing in this implementation.
		do
		end

	update_buttons (a_parent: EV_TOOL_BAR; start_index, end_index: INTEGER) is
			-- Ensure that buttons from `start_index' to `end_index' in `a_parent' are
			-- refreshed. This is called at the end of  a dockable transport from a tool bar button
			-- as on some platforms, they end up in an invalid state, and need refreshing.
		do
		end

	internal_disable_dockable is
			-- Platform specific implementation of `disable_drag'.
			-- Does nothing in this implementation.
		do
		end

	disable_capture is
            -- Ungrab the user input.
		do
			promote_to_widget
			interface.implementation.disable_capture
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
		do
			promote_to_widget
			interface.implementation.enable_capture
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
			-- Target at mouse position.
		do
			promote_to_widget
			Result := interface.implementation.real_pointed_target
		end

	set_pointer_style (c: EV_CURSOR) is
			-- Assign `c' to cursor pixmap.
			-- Can be called through `interface'.
		do
			promote_to_widget
			interface.implementation.set_pointer_style (c)
		end

	internal_set_pointer_style (c: EV_CURSOR) is
			-- Assign `c' to cursor pixmap.
			-- Only called from implementation.
		do
			promote_to_widget
			interface.implementation.internal_set_pointer_style (c)
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

	background_color: EV_COLOR is
			-- Color used for erasing of canvas.
			-- Default: white.
		do
				-- Returns default background color.
			create Result.make_with_rgb (1, 1, 1)
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

	foreground_color: EV_COLOR is
		do
				-- Returns default foreground color.
			create Result.make_with_rgb (0, 0, 0)
		end

	has_focus: BOOLEAN is
			-- Does widget have the keyboard focus?
		do
			Result := False
		end

	hide is
			-- Request that `Current' not be displayed.
		do
			promote_to_widget
			interface.implementation.hide
		end

	is_displayed: BOOLEAN is
			-- Is `Current' visible on the screen?
			-- False if `Current' is entirely obscured by another window.
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

	is_sensitive: BOOLEAN is
			-- Does `Current' respond to user input events?
		do
				-- Simple pixmap => not in a container.
			Result := False
		end

	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
			if is_destroyed then
				Result := interface.implementation.is_show_requested
			else
					-- Simple pixmap => not in a container.
					-- This should never be called, as `show' upgrades
					-- the implementation.
				Result := False
			end
		end

	minimum_height: INTEGER is
			-- Minimum vertical size in pixels.
		do
			Result := height
		end

	minimum_width: INTEGER is
			-- Minimum horizontal size in pixels.
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
			-- Cursor displayed when screen pointer is over current widget.
		do
			promote_to_widget
			Result := interface.implementation.pointer_style
		end

	screen_x: INTEGER is
			-- Horizontal offset relative to screen.
		do
			promote_to_widget
			Result := interface.implementation.screen_x
		end

	screen_y: INTEGER is
			-- Vertical offset relative to screen.
		do
			promote_to_widget
			Result := interface.implementation.screen_y
		end

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `background_color'.
		do
			promote_to_drawable
			interface.implementation.set_background_color(a_color)
		end

	set_focus is
			-- Grab keyboard focus.
		do
			promote_to_widget
			interface.implementation.set_focus
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'.
		do
			promote_to_drawable
			interface.implementation.set_foreground_color(a_color)
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

	set_tooltip (a_text: STRING_GENERAL) is
			-- Set `tooltip' to `a_text'.
		do
			promote_to_widget
			interface.implementation.set_tooltip (a_text)
		end

	show is
			-- Request that `Current' be displayed.
		do
			promote_to_widget
			interface.implementation.show
		end

	tooltip: STRING_32 is
			-- Text displayed when user moves mouse over widget.
		do
			check
				not_destroyed: not is_destroyed
			end
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

	on_parented is
			-- `Current' has just been added to a container.
		do
			promote_to_widget
			interface.implementation.on_parented
		end

feature {EV_PIXMAP_I} -- Implementation

	destroy is
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

	copy_pixmap (other_interface: EV_PIXMAP) is
			-- Update `Current' to have same appearence as `other'.
			-- (So as to satisfy `is_equal'.)
		local
			other_simple_imp: EV_PIXMAP_IMP
			other_imp: EV_PIXMAP_IMP_STATE
		do
			reset_resource_content
			reset_bitmap_content

			other_simple_imp ?= other_interface.implementation
			if other_simple_imp /= Void then
				if other_simple_imp.pixmap_filename /= Void then
					pixmap_filename := other_simple_imp.pixmap_filename.twin
				end
				private_width := other_simple_imp.private_width
				private_height := other_simple_imp.private_height
				private_bitmap := other_simple_imp.private_bitmap
				if private_bitmap /= Void then
					private_bitmap.increment_reference
					private_bitmap_id := private_bitmap.object_id
				end
				private_mask_bitmap := other_simple_imp.private_mask_bitmap
				if private_mask_bitmap /= Void then
					private_mask_bitmap.increment_reference
				end
				private_icon := other_simple_imp.private_icon
				if private_icon /= Void then
					private_icon.increment_reference
				end
				private_cursor := other_simple_imp.private_cursor
				if private_cursor /= Void then
					private_cursor.increment_reference
				end
				private_palette := other_simple_imp.private_palette
				if private_palette /= Void then
					private_palette.increment_reference
				end
				update_needed := other_simple_imp.update_needed
			else
				other_imp ?= other_interface.implementation
				private_bitmap := other_imp.get_bitmap
				private_bitmap_id := private_bitmap.object_id
				if other_imp.has_mask then
					private_mask_bitmap := other_imp.get_mask_bitmap
				end
				private_palette := other_imp.palette
				if private_palette /= Void then
					private_palette.increment_reference
				end
				private_width := private_bitmap.width
				private_height := private_bitmap.height
				update_needed := False
			end
		end

feature {EV_PIXMAP_IMP, EV_IMAGE_LIST_IMP} -- Pixmap Filename

	pixmap_filename: STRING
			-- Filename for the pixmap.
			--  * Void if no file is associated with Current.
			--  * Empty string for the default pixmap.

feature {EV_DRAWABLE_IMP, EV_IMAGE_LIST_IMP, EV_PIXMAP_IMP} -- Pixmap State

	private_width: INTEGER
			-- Current width

	private_height: INTEGER
			-- Current height

	private_bitmap: WEL_BITMAP
			-- Current bitmap used. Void if not initialized or if
			-- `update_needed' is set.

	private_bitmap_id: INTEGER
			-- `object_id' of first `private_bitmap' set to `Current'. If you add an item
			-- pixmap to an image list, `private_bitmap' is cleared and then reset upon removal.
			-- As we wish to ensure that placing `Current' back in the image list uses the already
			-- cached version, we have to keep the original private_bitmap id.

	private_mask_bitmap: WEL_BITMAP
			-- Monochrome bitmap used as mask. Void if none.

	private_icon: WEL_ICON
			-- Icon representing `Current'. Void if none.

	private_cursor: WEL_CURSOR
			-- Cursor representing `Current'. Void if none.

	private_palette: WEL_PALETTE
			-- Palette for bitmap. Void if none.

feature {EV_ANY_I} -- Implementation

	set_private_bitmap_id (a_value: INTEGER) is
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
		) is
			-- Callback function called from the C code by c_ev_load_pixmap.
			-- See `read_from_named_file'.
			-- Exceptions "Unable to retrieve icon information",
			--            "Unable to load the file".
		local
			dib: WEL_DIB
			size_row: INTEGER
			memory_dc: WEL_MEMORY_DC
--			source_dc: WEL_MEMORY_DC
			s_dc: WEL_SCREEN_DC
		do
			if error_code = Loadpixmap_error_noerror then
				inspect
					data_type
				when Loadpixmap_hicon then
						-- No error while loading the file
						-- create the icon
					create private_icon.make_by_pointer (rgb_data)
					private_icon.set_unshared
					private_icon.enable_reference_tracking
					retrieve_pixmap_size

				when Loadpixmap_hbitmap then
					create private_bitmap.make_by_pointer (rgb_data)
					private_bitmap_id := private_bitmap.object_id
					private_bitmap.set_unshared
					private_bitmap.enable_reference_tracking

					create private_mask_bitmap.make_by_pointer (alpha_data)
					private_mask_bitmap.set_unshared
					private_mask_bitmap.enable_reference_tracking
					private_width := private_bitmap.width
					private_height := private_bitmap.height

				when Loadpixmap_rgb_data then
						-- Compute the size of a row in bytes (here
						-- we have 24 bits/color)
					size_row := 4 * ((pixmap_width * 24 + 31) // 32)
					create dib.make_by_content_pointer (
						rgb_data,
						size_row * pixmap_height + 40
						)
					create s_dc
					s_dc.get
					create private_bitmap.make_by_dib(
						s_dc,
						dib,
						Dib_colors_constants.Dib_rgb_colors
						)
					private_bitmap_id := private_bitmap.object_id
					private_bitmap.enable_reference_tracking
					s_dc.release

						-- Update the size
					private_width := private_bitmap.width
					private_height := private_bitmap.height

						-- We keep the palette
					private_palette := dib.palette
					private_palette.enable_reference_tracking
					private_palette.increment_reference

					dib.dispose
					dib := Void

						-- Let's build the mask.
					if alpha_data /= Default_pointer then
							-- Compute the size of a row in bytes (here
							-- we have 1 bit/color)
						size_row := 4 * ((pixmap_width * 1 + 31) // 32)
						create dib.make_by_content_pointer (
							alpha_data,
							size_row * pixmap_height + 40 + 8
							)
						create memory_dc.make
						create private_mask_bitmap.make_by_dib (
							memory_dc, dib,
							Dib_colors_constants.Dib_rgb_colors
							)
						private_mask_bitmap.enable_reference_tracking

--						memory_dc.select_bitmap (private_bitmap)

							--| FIXME To get the icon masking to work properly we have to always make sure
							--| that the color masked out is always black, this is achieved by blitting
							--| the black part of the mask on to the source pixmap
							--| Studio uses black as the color underneath for all icons
--						create source_dc.make
--						source_dc.select_bitmap (private_mask_bitmap)
--						memory_dc.bit_blt (0, 0, private_width, private_height, source_dc, 0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.maskpaint)
--						source_dc.unselect_bitmap
--						source_dc.delete

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

	new_empty_bitmap: WEL_BITMAP is
			-- Initialize `bitmap' with an empty `width'x`height' bitmap.
			--
			-- Call `WEL_BITMAP.decrement_reference' when Result is no
			-- more needed to free a GDI resource.
		do
			create Result.make_direct (width, height, 1, 1, "%/255/")
			Result.enable_reference_tracking
		end

	reset_resource_content is
			-- Reset the resource-content (icon, cursor) and free
			-- any allocated GDI resource.
		do
			if private_icon /= Void then
				private_icon.decrement_reference
				private_icon := Void
			elseif private_cursor /= Void then
				private_cursor.decrement_reference
				private_cursor := Void
			end
		end

	reset_bitmap_content is
			-- Reset the bitmap-content (bitmap, mask, palette) and free
			-- any allocated GDI resource.
		do
			if private_bitmap /= Void then
				private_bitmap.decrement_reference
				private_bitmap := Void
			end
			if private_mask_bitmap /= Void then
				private_mask_bitmap.decrement_reference
				private_mask_bitmap := Void
			end
			if private_palette /= Void then
				private_palette.decrement_reference
				private_palette := Void
			end
		end

	promote_to_drawable is
			-- Promote the current implementation to
			-- EV_PIXMAP_IMP_DRAWABLE which allows
			-- drawing operations on the pixmap.
		local
			drawable_pixmap: EV_PIXMAP_IMP_DRAWABLE
		do
				-- Discard current implementation
			if not is_destroyed then
				create drawable_pixmap.make_with_simple (Current)
				interface.replace_implementation (drawable_pixmap)
				safe_destroy
			end
		end

	promote_to_widget is
			-- Promote the current implementation to
			-- EV_PIXMAP_IMP_WIDGET which allows
			-- drawing operations on the pixmap and
			-- display on the screen.
		local
			widget_pixmap: EV_PIXMAP_IMP_WIDGET
		do
			if not is_destroyed then
				create widget_pixmap.make_with_simple (Current)
				interface.replace_implementation (widget_pixmap)

					-- Discard current implementation
				safe_destroy
			end
		end

	stretch_wel_bitmap(
			old_bitmap	: WEL_BITMAP
			new_width	: INTEGER
			new_height	: INTEGER
		): WEL_BITMAP is
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
			create new_dc.make_by_dc (s_dc)
			create new_bitmap.make_compatible (
				s_dc,
				new_width,
				new_height
				)
			new_bitmap.enable_reference_tracking
			new_dc.select_bitmap (new_bitmap)

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

	retrieve_pixmap_size is
			-- Retrieve the width and the height of the image
			-- from the icon or cursor handle.
		require
			icon_or_cursor_defined: private_icon /= Void or private_cursor /= Void
		local
			icon_info: WEL_ICON_INFO
			info_mask_bitmap: WEL_BITMAP
		do
				-- Retrieve the information from the icon/cursor
			if private_icon /= Void then
				icon_info := private_icon.get_icon_info
			else
				icon_info := private_cursor.get_icon_info
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

	retrieve_icon_information is
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
			icon_info: WEL_ICON_INFO
			mem1_dc: WEL_MEMORY_DC
			mem2_dc: WEL_MEMORY_DC
			s_dc: WEL_SCREEN_DC
			new_width : INTEGER
			new_height: INTEGER
			icon_mask_bitmap: WEL_BITMAP
			a_wel_bitmap: WEL_BITMAP
			mask_src_dc, mask_dest_dc: WEL_MEMORY_DC
		do
				-- Retrieve the information from the icon/cursor
			if icon /= Void then
				icon_info := icon.get_icon_info
			else
				icon_info := cursor.get_icon_info
			end

				-- Ensure that we successfully retrieved the information.
			if icon_info = Void then
				exception_raise ("Unable to retrieve icon information")
			end
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
				create private_bitmap.make_compatible (mem2_dc, new_width, new_height)
				private_bitmap_id := private_bitmap.object_id
				private_bitmap.enable_reference_tracking

				a_wel_bitmap := get_bitmap
				mem2_dc.select_bitmap (a_wel_bitmap)

					-- Copy the second half of `icon_mask_bitmap' into
					-- `bitmap'			
				mem2_dc.bit_blt (0, 0, new_width, new_height,
					mem1_dc, 0, new_height, Raster_operations_constants.Srccopy)

				mem2_dc.unselect_bitmap
				a_wel_bitmap.decrement_reference

					-- Associate `mem2_dc' with `mask_bitmap'.
				create private_mask_bitmap.make_compatible (mem2_dc,
					new_width, new_height)
				private_mask_bitmap.enable_reference_tracking

				a_wel_bitmap := get_mask_bitmap
				mem2_dc.select_bitmap (a_wel_bitmap)

					-- Copy the first half of `icon_mask_bitmap' into
					-- `mask_bitmap'			
				mem2_dc.bit_blt (0, 0, new_width, new_height,
					mem1_dc, 0, 0, Raster_operations_constants.Srccopy)

					-- Free memory				
				mem2_dc.unselect_bitmap
				mem2_dc.delete
				a_wel_bitmap.decrement_reference
				mem1_dc.unselect_bitmap
				mem1_dc.delete
				s_dc.release
			else
					-- Everything went ok, replace the bitmaps
				private_bitmap := icon_info.color_bitmap
				private_bitmap_id := private_bitmap.object_id
				private_bitmap.increment_reference

					-- Flip the mask as 1 means full opacity in Vision2.
				create private_mask_bitmap.make_by_bitmap (icon_info.mask_bitmap)
				private_mask_bitmap.enable_reference_tracking
				create mask_dest_dc.make
				mask_dest_dc.select_bitmap (private_mask_bitmap)
				mask_dest_dc.pat_blt (0, 0, private_mask_bitmap.width, private_mask_bitmap.height, {WEL_RASTER_OPERATIONS_CONSTANTS}.dstinvert)
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

	disable_initialized is
			-- Ensure `is_initialized' = False.
		do
			set_is_initialized (False)
		end


feature {NONE} -- Constants

	Loadpixmap_error_noerror: INTEGER is 0
		-- No error.

	Loadpixmap_rgb_data: INTEGER is 0
		-- Pointer on a DIB structure.

	Loadpixmap_hicon: INTEGER is 2
		-- Pointer on a HICON handle.

	Loadpixmap_hbitmap: INTEGER is 3
		-- Pointer on a HBITMAP handle.

	Dib_colors_constants: WEL_DIB_COLORS_CONSTANTS is
			-- Class containing the DIB_COLORS constants.
		once
			create Result
		end

	Raster_operations_constants: WEL_RASTER_OPERATIONS_CONSTANTS is
			-- Class containing the RASTER_OPERATIONS constants.
		once
			create Result
		end

	Idi_constants: WEL_IDI_CONSTANTS is
		once
			create Result
		end

feature {
		EV_PIXMAP_IMP,
		EV_PIXMAP_IMP_DRAWABLE,
		EV_PIXMAP_IMP_WIDGET,
		EV_CONTAINER_IMP
		} -- Implementation

	interface: EV_PIXMAP

feature {EV_DRAWABLE_IMP} -- Implementation

	sub_pixmap (area: EV_RECTANGLE): EV_PIXMAP is
			-- Pixmap region of `Current' represented by rectangle `area'
		local
			a_drawable_pixmap: EV_PIXMAP_IMP_DRAWABLE
		do
			promote_to_drawable
			a_drawable_pixmap ?= interface.implementation
			Result := a_drawable_pixmap.sub_pixmap (area)
		end

	set_bitmap_and_mask (a_bitmap, a_mask: WEL_BITMAP; a_bitmap_width, a_bitmap_height: INTEGER) is
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
			private_bitmap.enable_reference_tracking
			if a_mask /= Void then
				private_mask_bitmap := a_mask
				private_mask_bitmap.enable_reference_tracking
			end
			private_width := a_bitmap_width
			private_height := a_bitmap_height
		end

invariant
	not_both_icon_and_cursor:
		not (private_icon /= Void and private_cursor /= Void)

	bitmap_reference_tracked:
		private_bitmap /= Void implies
			private_bitmap.reference_tracked

	palette_reference_tracked:
		private_palette /= Void implies
			private_palette.reference_tracked

	mask_reference_tracked:
		private_mask_bitmap /= Void implies
			private_mask_bitmap.reference_tracked

	icon_reference_tracked:
		private_icon /= Void implies
			private_icon.reference_tracked

	cursor_reference_tracked:
		private_cursor /= Void implies
			private_cursor.reference_tracked

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PIXMAP_IMP

