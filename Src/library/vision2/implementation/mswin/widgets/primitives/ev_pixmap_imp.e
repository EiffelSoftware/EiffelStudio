--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description:
		"Eiffel Vision pixmap. Mswindows implementation for%N%
		%simple pixmap (not drawable, not self-displayable)"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PIXMAP_IMP

inherit
	EV_PIXMAP_I
		redefine
			interface,
			on_parented
		end

	EV_PIXMAP_IMP_STATE

	EXCEPTIONS
		rename
			raise as exception_raise,
			class_name as exception_class_name
		redefine
			default_create
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create an empty drawing area.
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize a default 1x1 pixmap.
		local
			s_dc: WEL_SCREEN_DC
		do
			create s_dc
			s_dc.get
			create bitmap.make_compatible (s_dc, 1, 1)
			s_dc.release

			width := 1
			height := 1

			is_initialized := True
		end

feature -- Loading/Saving

	read_from_file (a_file: IO_MEDIUM) is
			-- Load the pixmap described in 'file_name'. 
		local
			dib: EV_WEL_DIB
			s_dc: WEL_SCREEN_DC
		do
			create s_dc
			s_dc.get

			create dib.make_by_stream (a_file)
			s_dc.select_palette (dib.palette)
			create bitmap.make_by_dib (
				s_dc, 
				dib, 
				Dib_colors_constants.Dib_rgb_colors
				)
			s_dc.unselect_palette
			s_dc.release

				-- Update width & height attributes.
			width := bitmap.width
			height := bitmap.height
		end

	read_from_named_file (file_name: STRING) is
			-- Load the pixmap described in 'file_name'. 
			--
			-- Exceptions "Unable to retrieve icon information", 
			--            "Unable to load the file"
		local
			filename_ptr: ANY
		do
				-- Disable invariant checking.
			is_initialized := False

			filename_ptr := file_name.to_c
			c_ev_load_pixmap($Current, $filename_ptr, $update_fields)
		end

	update_fields(
		error_code		: INTEGER -- Loadpixmap_error_xxxx 
		data_type		: INTEGER -- Loadpixmap_hicon, ...
		pixmap_width	: INTEGER -- Height of the loaded pixmap
		pixmap_height	: INTEGER -- Width of the loaded pixmap
		rgb_data		: POINTER -- Pointer on a C memory zone
		alpha_data		: POINTER -- Pointer on a C memory zone
		) is
			-- Callback function called from the C code by c_ev_load_pixmap.
			-- 
			-- See `read_from_named_file'
			-- Exceptions "Unable to retrieve icon information",
			--            "Unable to load the file"
		local
			icon_info: WEL_ICON_INFO
			dib: WEL_DIB
			size_row: INTEGER
			memory_dc: WEL_MEMORY_DC
			s_dc: WEL_SCREEN_DC
		do
			if error_code = Loadpixmap_error_noerror then
					-- No error while loading the file
				if data_type = Loadpixmap_hicon then
						-- create the icon
					create icon.make_by_pointer(rgb_data)

						-- retrieve the bitmap from the icon.
					icon_info := icon.get_icon_info
					if icon_info /= Void then
						bitmap := icon_info.color_bitmap
						mask_bitmap := icon_info.mask_bitmap
					else
						exception_raise ("Unable to retrieve icon information")
					end
				end

				if data_type = Loadpixmap_hbitmap then
					create bitmap.make_by_pointer(rgb_data)
					create mask_bitmap.make_by_pointer(alpha_data)
				end

				if data_type = Loadpixmap_rgb_data then
					size_row := 4 * ((pixmap_width * 24 + 31) // 32)
					create dib.make_by_content_pointer (
						rgb_data, 
						size_row * pixmap_height + 40
						)
					create s_dc
					s_dc.get
					create bitmap.make_by_dib(
						s_dc, 
						dib, 
						Dib_colors_constants.Dib_rgb_colors
						)
					s_dc.release
					palette := dib.palette

					size_row := 4 * ((pixmap_width * 1 + 31) // 32)
					create dib.make_by_content_pointer (
						alpha_data, 
						size_row * pixmap_height + 40 + 8
						)
					create memory_dc.make
					create mask_bitmap.make_by_dib (
						memory_dc, dib, 
						Dib_colors_constants.Dib_rgb_colors
						)
				end
			else
					-- An error occurred while loading the file
				exception_raise ("Unable to load the file")
			end

				-- Update width & height
			width := bitmap.width
			height := bitmap.height
			
				-- Enable invariant checking again
			is_initialized := True
		end

feature -- Access

	bitmap: WEL_BITMAP
			-- Current bitmap used. Void if not initialized, not
			-- Void otherwise (see Invariant at the end of class).

	mask_bitmap: WEL_BITMAP
		-- Monochrome bitmap used as mask. Void if none.

	has_mask: BOOLEAN is
			-- Has the current pixmap a mask?
		do
			Result := mask_bitmap /= Void
		end

	icon: WEL_ICON
		-- Current icon used. Void if none.

	palette: WEL_PALETTE
		-- Current palette used. Void if none.

	transparent_color: EV_COLOR
			-- Color used as transparent (Void by default).

feature -- Status setting

	set_with_buffer (a_buffer: STRING) is
			-- Load pixmap data from `a_buffer' into memory.
		do
			--|FIXME Implement
			check
				not_yet_implemented: False
			end
		end

	stretch (new_width, new_height: INTEGER) is
			-- Stretch the image to fit in size 
			-- `new_width' by `new_height'.
		local
			new_bitmap			: WEL_BITMAP
			new_mask			: WEL_BITMAP
			wel_rect			: WEL_RECT
		do
				-- Operation not possible on icons.
			icon := Void	-- Stop using icons.

				-- Stretch the bitmap
			bitmap := stretch_wel_bitmap (
				bitmap,
				new_width,
				new_height
				)

				-- Stretch the mask if any.
			if mask_bitmap /= Void then
				mask_bitmap := stretch_wel_bitmap (
					mask_bitmap,
					new_width,
					new_height
					)
			end

				-- Update the width & height attributes
			width := bitmap.width
			height := bitmap.height
		end

	set_transparent_color (value: EV_COLOR) is
			-- Make `value' the new transparent color.
		do
			transparent_color := value
			check
				not_yet_implemented: False
			end
		end

feature -- Measurement

	width: INTEGER
			-- Width of the pixmap.

	height: INTEGER
			-- Height of the pixmap.

feature -- Delegated features

	set_size (new_width, new_height: INTEGER) is
			-- Resize the current bitmap. If the new size
			-- is smaller than the old one, the bitmap is
			-- clipped.
		local
			old_interface: like interface
		do
			promote_to_drawable
			interface.implementation.set_size (new_width, new_height)
		end

	clear is
			-- Erase `Current' with `background_color'.
		do
			promote_to_drawable
			interface.implementation.clear
		end

	clear_rectangle (x1, y1, x2, y2: INTEGER) is
			-- Erase rectangle (`x1, `y1) - (`x2', `y2') with
			-- `background_color'.
		do
			promote_to_drawable
			interface.implementation.clear_rectangle (x1, y1, x2, y2)
		end

	draw_point (a_x, a_y: INTEGER) is
			-- Draw point at (`x', 'y').
		do
			promote_to_drawable
			interface.implementation.draw_point (a_x, a_y)
		end

	draw_text (a_x, a_y: INTEGER; a_text: STRING) is
			-- Draw `a_text' at (`x', 'y') using `font'.
		do
			promote_to_drawable
			interface.implementation.draw_text (a_x, a_y, a_text)
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
		points				: ARRAY [EV_COORDINATES]
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
		points				: ARRAY [EV_COORDINATES]
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
			-- Logical operation on pixels when drawing.
		do
				-- Simple pixmap => default drawing state.
			Result := Ev_drawing_mode_copy
		end

	enable_dashed_line_style is
			-- Draw lines dashed.
		do
			promote_to_drawable
			interface.implementation.enable_dashed_line_style
		end

	font: EV_FONT is
			-- Character appearance.
		do
				-- Simple pixmap => default drawing state.
			create Result
		end

	line_width: INTEGER is
			-- Line thickness.
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
			-- Set area which will be refreshed.
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
			-- Set `font' to `a_font'.
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
			-- Pixmap that is used to instead of background_color.
			-- If set to Void, `background_color' is used to fill.
		do
				-- Simple implementation => no tile.
			Result := Void
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
		local
			new_imp: EV_PIXMAP_IMP_WIDGET
		do
			promote_to_widget
			new_imp ?= interface.implementation
			new_imp.enable_transport
		end

	end_transport (
			a_x: INTEGER
			a_y: INTEGER
			a_button: INTEGER
		) is
			-- Terminate the pick and drop mechanism.
		do
			promote_to_widget
			interface.implementation.end_transport(
				a_x,
				a_y,
				a_button
				)
		end

	erase_rubber_band is
			-- Erase previously drawn rubber band.
		do
			promote_to_widget
			interface.implementation.erase_rubber_band
		end

	pointed_target: EV_PICK_AND_DROPABLE is
			-- Target at mouse position
		do
			promote_to_widget
			Result := interface.implementation.pointed_target
		end

	set_pointer_style (c: EV_CURSOR) is
			-- Set `c' as new cursor pixmap
		local
			new_imp: EV_PIXMAP_IMP
		do
			promote_to_widget
			new_imp ?= interface.implementation
			new_imp.set_pointer_style(c)
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

	dimensions_set (new_width: INTEGER; new_height: INTEGER): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
		obsolete "don't use it"
		do
			promote_to_widget
			Result := interface.implementation.dimensions_set (
				new_width,
				new_height
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
			-- Request that `Current' not be displayed when its parent is.
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

	is_sensitive: BOOLEAN is
			-- Does `Current' respond to user input events.
		do
				-- Simple pixmap => not in a container.
			Result := False
		end

	is_show_requested: BOOLEAN is
			-- Will `Current' be displayed when its parent is?
			-- See also `is_displayed'.
		do
				-- Simple pixmap => not in a container.
			Result := False
		end

	minimum_dimensions_set (
			new_width: INTEGER; 
			new_height: INTEGER
		): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
			-- When the widget is not shown, the result is 0
		obsolete "don't use it"
		do
			promote_to_widget
			Result := interface.implementation.minimum_dimensions_set (
				new_width,
				new_height
				)
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

	pointer_position: EV_COORDINATES is
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

	position_set (
			new_x: INTEGER
			new_y: INTEGER
		): BOOLEAN is
			-- Check if the dimensions of the widget are set to 
			-- the values given or the minimum values possible 
			-- for that widget.
			-- When the widget is not shown, the result is -1
		obsolete "don't use it"
		do
			promote_to_widget
			Result := interface.implementation.position_set (
				new_x,
				new_y
				)
		end

	remove_tooltip is
			-- Set `tooltip' to `Void'.
		do
			promote_to_widget
			interface.implementation.remove_tooltip
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
			-- Assign `a_color' to `foreground_color'
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

	set_tooltip (a_text: STRING) is
			-- Set `tooltip' to `a_text'.
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

	on_parented is
			-- `Current' has just been added to a container
		do
			promote_to_widget
			interface.implementation.on_parented
		end

feature {EV_PIXMAP_I} -- Implementation

	destroy is
			-- Destroy actual object.
		do
				-- Turn off invariant checking.
			is_initialized := False

			bitmap.delete
			bitmap := Void
		end

feature {EV_PIXMAP_I, EV_PIXMAP_IMP_STATE} -- Duplication

	copy_pixmap (other_interface: EV_PIXMAP) is
			-- Update `Current' to have same appearence as `other'.
			-- (So as to satisfy `is_equal'.)
		local
			simple_pixmap: EV_PIXMAP_IMP
			other: EV_PIXMAP_IMP_STATE
		do
			other ?= other_interface.implementation

				-- Disable invariant checking
			is_initialized := False

			create bitmap.make_by_bitmap(other.bitmap)
			if other.has_mask then
				create mask_bitmap.make_by_bitmap(other.mask_bitmap)
			end
			simple_pixmap ?= other
			if simple_pixmap /= Void then
				icon := simple_pixmap.icon
			end
			transparent_color := other.transparent_color

			width := bitmap.width
			height := bitmap.height

				-- Enable invariant checking
			is_initialized := True
		end

feature {NONE} -- Implementation

	promote_to_drawable is
			-- Promote the current implementation to
			-- EV_PIXMAP_IMP_DRAWABLE which allows
			-- drawing operations on the pixmap.
		local
			drawable_pixmap: EV_PIXMAP_IMP_DRAWABLE
		do
			create drawable_pixmap.make_with_simple(Current)
			interface.replace_implementation(drawable_pixmap)
		end

	promote_to_widget is
			-- Promote the current implementation to
			-- EV_PIXMAP_IMP_WIDGET which allows
			-- drawing operations on the pixmap and
			-- display on the screen.
		local
			widget_pixmap: EV_PIXMAP_IMP_WIDGET
		do
			create widget_pixmap.make_with_simple(Current)
			interface.replace_implementation(widget_pixmap)
		end

	stretch_wel_bitmap(
			old_bitmap	: WEL_BITMAP
			new_width	: INTEGER
			new_height	: INTEGER
		): WEL_BITMAP is
			-- Stretch `old_bitmap' to fit in size `new_width' by 
			-- `new_height'. The resulting bitmap is stored into
			-- `Result'
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
			new_dc := Void	-- The GC can collect it.
			old_dc.unselect_bitmap
			old_dc.delete
			old_dc := Void	-- The GC can collect it.
			s_dc.release
			s_dc := Void	-- The GC can collect it.

			Result := new_bitmap
		end

feature {NONE} -- Constants

	Loadpixmap_error_noerror: INTEGER is 0
		-- No error

	Loadpixmap_rgb_data: INTEGER is 0
		-- Pointer on a DIB structure

	Loadpixmap_hicon: INTEGER is 2
		-- Pointer on a HICON handle

	Loadpixmap_hbitmap: INTEGER is 3
		-- Pointer on a HBITMAP handle

	Dib_colors_constants: WEL_DIB_COLORS_CONSTANTS is
			-- Class containing the DIB_COLORS constants
		once
			create Result
		end

	Raster_operations_constants: WEL_RASTER_OPERATIONS_CONSTANTS is
			-- Class containing the RASTER_OPERATIONS constants
		once
			create Result
		end

feature {
		EV_PIXMAP_IMP, 
		EV_PIXMAP_IMP_DRAWABLE,
		EV_PIXMAP_IMP_WIDGET
		} -- Implementation

	interface: EV_PIXMAP

feature {NONE} -- Externals

	c_ev_load_pixmap(
		curr_object: POINTER; 
		file_name: POINTER; 
		update_fields_routine: POINTER
		) is
		external
			"C | %"load_pixmap.h%""
		end

invariant
	bitmap_not_void: 
		is_initialized implies bitmap /= Void

	valid_bitmap_width: 
		is_initialized implies width = bitmap.width

	valid_bitmap_height: 
		is_initialized implies height = bitmap.height
	
	valid_mask_condition:
		(has_mask implies mask_bitmap /= Void) and
		(mask_bitmap /= Void implies has_mask)

end -- class EV_PIXMAP_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.31  2000/04/13 18:45:28  pichery
--| cosmetics
--|
--| Revision 1.30  2000/04/12 17:00:17  brendel
--| Added redefine of on_parented.
--| Fixed indexing clause to EV2 standards.
--| Updated copyright notice.
--|
--| Revision 1.29  2000/04/12 01:34:55  pichery
--| New pixmap implementation.
--| Use 3 differents states depending on
--| what the user is doing with the pixmap.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
