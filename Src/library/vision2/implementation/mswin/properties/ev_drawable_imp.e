indexing
	description: "EiffelVision drawable. Mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_DRAWABLE_IMP

inherit
	EV_DRAWABLE_I
		redefine
			interface
		end

	EV_FONTABLE_IMP
		export
			{NONE} wel_set_font
		redefine
			interface,
			set_font
		end

	EV_DRAWABLE_CONSTANTS

	EXCEPTIONS
		rename
			raise as exception_raise,
			class_name as exception_class_name
		end

	EV_SHARED_GDI_OBJECTS			export {NONE} all end
	WEL_DIB_COLORS_CONSTANTS		export {NONE} all end
	WEL_ROP2_CONSTANTS 				export {NONE} all end
	WEL_TA_CONSTANTS				export {NONE} all end
	WEL_WINDOWS_ROUTINES			export {NONE} all end
	WEL_COLOR_CONSTANTS				export {NONE} all end
	WEL_PS_CONSTANTS				export {NONE} all end
	WEL_BRUSH_STYLE_CONSTANTS		export {NONE} all end
	WEL_RASTER_OPERATIONS_CONSTANTS export {NONE} all end
	WEL_HS_CONSTANTS 				export {NONE} all end

feature {NONE} -- Initialization

	initialize is
			-- Set some default values.
		do
			set_default_font
			create foreground_color.make_with_rgb (0, 0, 0)
			create background_color.make_with_rgb (1, 1, 1)

				-- Initialise the device for painting.
			dc.set_background_opaque
			dc.set_background_transparent
			set_drawing_mode (drawing_mode_copy)
			set_line_width (1)
			reset_pen
			reset_brush

			is_initialized := True
		end

feature --{EV_ANY_I} -- Implementation

	dc: WEL_DC is
			-- Device context applied to the primitives.
		deferred
		ensure
			not_void: dc /= Void
		end

feature -- Access

	background_color: EV_COLOR
			-- Color used to fill figures.

	foreground_color: EV_COLOR
			-- Color used for lines and text.

	line_width: INTEGER 
			-- Line thickness.

	drawing_mode: INTEGER is
			-- Logical operation on pixels when drawing.
		do
			if wel_drawing_mode = R2_copypen then
				Result := drawing_mode_copy
			elseif wel_drawing_mode = R2_xorpen then
				Result := drawing_mode_xor
			elseif wel_drawing_mode = R2_not then
				Result := drawing_mode_invert
			elseif wel_drawing_mode = R2_maskpen then
				Result := drawing_mode_and
			elseif wel_drawing_mode = R2_mergepen then
				Result := drawing_mode_or
			end
		end

	clip_area: EV_RECTANGLE
			-- Clip area used to clip drawing.
			-- If set to Void, no clipping is applied.

	tile: EV_PIXMAP
			-- Pixmap that is used to instead of background_color.
			-- If set to Void, `background_color' is used to fill.

	dashed_line_style: BOOLEAN
			-- Are lines drawn dashed?

feature {NONE} -- Implementation

	width: INTEGER is
			-- Width of the widget.
			--| Used in `draw_straight_line'.
		deferred
		end

	height: INTEGER is
			-- Height of the widget
			--| Used in `draw_straight_line'.
		deferred
		end

feature -- Element change

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `background_color'.
		local
			a_color_imp: EV_COLOR_IMP
			background_color_imp: EV_COLOR_IMP
		do
			a_color_imp ?= a_color.implementation
			background_color_imp ?= background_color.implementation
			if a_color_imp.item /= background_color_imp.item then
				background_color_imp.set_color (a_color_imp.item)
					-- update current background brush (lazzy evaluation)
				internal_initialized_background_brush := False
			end
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		local
			a_color_imp: EV_COLOR_IMP
			foreground_color_imp: EV_COLOR_IMP
		do
			a_color_imp ?= a_color.implementation
			foreground_color_imp ?= foreground_color.implementation
			if a_color_imp.item /= foreground_color_imp.item then
				foreground_color_imp.set_color (a_color_imp.item)							
					-- update current pen & brush (lazzy evaluation)
				internal_initialized_brush := False
				internal_initialized_pen := False
				internal_initialized_text_color := False
			end
		end

	set_line_width (a_width: INTEGER) is
			-- Assign `a_width' to `line_width'.
		do
			line_width := a_width
			internal_initialized_pen := False
		end

	set_drawing_mode (a_mode: INTEGER) is
			-- Set drawing mode to `a_mode'.
		do
			inspect a_mode
			when drawing_mode_copy then
				wel_drawing_mode := R2_copypen
			when drawing_mode_xor then
				wel_drawing_mode := R2_xorpen
			when drawing_mode_invert then
				wel_drawing_mode := R2_not
			when drawing_mode_and then
				wel_drawing_mode := R2_maskpen
			when drawing_mode_or then
				wel_drawing_mode := R2_mergepen
			else
				check
					drawing_mode_existent: False
				end
			end
			dc.set_rop2 (wel_drawing_mode)
		end

	set_clip_area (an_area: EV_RECTANGLE) is
			-- Set an area to clip to.
			-- Set to Void when no clipping should be applied.
		local
			region: WEL_REGION
		do
			remove_clip_area
			clip_area := clone (an_area)
			create region.make_rect (clip_area.x, clip_area.y,
				clip_area.width + clip_area.x,
				clip_area.height + clip_area.y)
			dc.select_clip_region (region)
			region.delete
		end

	remove_clip_area is
			-- Do not apply any clipping.
		local
			region: WEL_REGION
		do
			clip_area := Void
			create region.make_rect (0, 0, width, height)
			dc.select_clip_region (region)
			region.delete
		end

	set_tile (a_pixmap: EV_PIXMAP) is
			-- Set tile used to fill figures.
			-- Set to Void to use `background_color' to fill.
		do
			tile := a_pixmap
		end

	remove_tile is
			-- Do not apply a tile when filling.
		do
			tile := Void
			internal_initialized_brush := False
		end

	enable_dashed_line_style is
			-- Draw lines dashed.
		do
			dashed_line_style := True
			internal_initialized_pen := False
		end

	disable_dashed_line_style is
			-- Draw lines solid.
		do
			dashed_line_style := False
			internal_initialized_pen := False
		end

	set_font (a_font: EV_FONT) is
			-- Set `font' to `a_font'.
		do
			private_font := a_font
			private_wel_font := Void
			internal_initialized_font := False
		end

feature -- Clearing and drawing operations

	clear is
			-- Erase `Current' with `background_color'.
		do
			clear_rectangle (0, 0, width + 1, height + 1)
		end

	clear_rectangle (x1, y1, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height' in `background_color'.
		local
			a_rect: WEL_RECT
		do
			create a_rect.make (x1, y1, x1 + a_width, y1 + a_height)
			dc.fill_rect (a_rect, our_background_brush)
		end

feature -- Drawing operations

	draw_point (x, y: INTEGER) is
			-- Draw point at (`x', `y').
		do
			if not internal_initialized_pen then
				reset_pen
			end
			dc.set_pixel (x, y, wel_fg_color)
			
			on_drawing_modified
		end

	draw_text (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
		do
			draw_text_top_left (x, y - font.ascent, a_text)
			
			on_drawing_modified
		end

	draw_text_top_left (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		do
			if not internal_initialized_text_color then
				dc.set_text_color (wel_fg_color)
				internal_initialized_text_color := True
			end

			if not internal_initialized_font then
				dc.select_font (wel_font)
				internal_initialized_font := True
			end
			dc.text_out (x, y, a_text)
			
			on_drawing_modified
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		local
			internal_x1, internal_x2, internal_y1, internal_y2: INTEGER
		do
			if not internal_initialized_pen then
				reset_pen
			end
			internal_x1 := x1
			internal_y1 := y1
					--| area.
			if x2 > internal_x1 then
				internal_x2 := x2 + 1
			elseif x2 < internal_x1 then
				internal_x2 := x2 - 1
			else
				internal_x2 := x2
			end
			if y2 > internal_y1 then
				internal_y2 := y2 + 1
			elseif y2 < internal_y1 then
				internal_y2 := y2 - 1
			else
				internal_y2 := y2
			end
			dc.move_to (internal_x1, internal_y1)
			
			dc.line_to (internal_x2, internal_y2)
			on_drawing_modified
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER) is
			-- Draw infinite straight line through (`x1','y1') and (`x2','y2').
		local
			ax1, ax2, ay1, ay2, dx, dy: INTEGER
		do
			--| VB: Should work now. Draws lines that are too big.
			--| Catch worst cases like when `dy' approaches zero.
			--| This implementation is the same for GTK.
			dx := (x2 - x1)
			dy := (y2 - y1)
			if dy /= 0 then
				ax1 := x1 - ((dx / dy) * y2).rounded
				ax2 := x1 - ((dx / dy) * (y1 - height)).rounded
				ay1 := 0
				ay2 := height
			else
				ay1 := y1
				ay2 := y2
				ax1 := 0
				ax2 := width
			end
			draw_segment (ax1, ay1, ax2, ay2)			
			
			on_drawing_modified
		end

	draw_arc (
		x,y : INTEGER;
		a_bounding_width, a_bounding_height: INTEGER;
		a_start_angle, an_aperture: REAL) is
			-- Draw part of an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- Angles are measured in radians, and go
			-- counterclockwise from the 3 o'clock angle.
		local
			left, top, right, bottom: INTEGER
			x_start_arc, y_start_arc, x_end_arc, y_end_arc: INTEGER
			semi_width, semi_height: DOUBLE
			tang_start, tang_end: DOUBLE
			x_tmp, y_tmp: DOUBLE			
		do
			left := x
			top := y
			right := left + a_bounding_width
			bottom := top + a_bounding_height
			
			semi_width := a_bounding_width / 2
			semi_height := a_bounding_height / 2
			tang_start := tangent (a_start_angle)
			tang_end := tangent (a_start_angle + an_aperture)
			x_tmp := semi_height / (sqrt (tang_start ^ 2 + semi_height ^ 2 / semi_width ^ 2))
			y_tmp := semi_height / (sqrt (1 + semi_height ^ 2 / (semi_width ^ 2 * tang_start ^ 2)))
			if sine (a_start_angle) > 0 then
				y_tmp := - y_tmp
			end
			if cosine (a_start_angle) < 0 then
				x_tmp := - x_tmp
			end
			x_start_arc := (x_tmp + left + semi_width).rounded
			y_start_arc := (y_tmp + top + semi_height).rounded
			x_tmp := semi_height / (sqrt (tang_end ^ 2 + semi_height ^ 2 / semi_width ^ 2))
			y_tmp := semi_height / (sqrt (1 + semi_height ^ 2 / (semi_width ^ 2 * tang_end ^ 2)))
			if sine (a_start_angle + an_aperture) > 0 then
				y_tmp := - y_tmp
			end
			if cosine (a_start_angle + an_aperture) < 0 then
				x_tmp := - x_tmp
			end
			x_end_arc := (x_tmp + left + semi_width).rounded
			y_end_arc := (y_tmp + top + semi_height).rounded
				
			if not internal_initialized_pen then
				reset_pen
			end
			if an_aperture /= 0.0 then
				dc.arc (left, top, right, bottom, x_start_arc,
					y_start_arc, x_end_arc, y_end_arc)
			else
				dc.set_pixel (x_start_arc, y_start_arc, wel_fg_color)
			end
			
			on_drawing_modified
		end

	draw_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' with upper-left corner on (`x', `y').
		local
			pixmap_imp		: EV_PIXMAP_IMP_STATE
			bounding_area	: EV_RECTANGLE
		do
			pixmap_imp ?= a_pixmap.implementation
			create bounding_area.make (0, 0, pixmap_imp.width, pixmap_imp.height)
			draw_sub_pixmap (x, y, a_pixmap, bounding_area)
			
			on_drawing_modified
		end

	draw_sub_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; area: EV_RECTANGLE) is
			-- Draw `area' of `a_pixmap' with upper-left corner on (`x', `y').
		local
			pixmap_height		: INTEGER
			pixmap_width		: INTEGER
			source_x			: INTEGER
			source_y			: INTEGER
			source_width		: INTEGER
			source_height		: INTEGER
			display_mask_bitmap	: WEL_BITMAP
			display_bitmap		: WEL_BITMAP
			s_dc				: WEL_SCREEN_DC
			display_mask_dc		: WEL_MEMORY_DC
			display_bitmap_dc	: WEL_MEMORY_DC
			pixmap_imp			: EV_PIXMAP_IMP_STATE
			pixmap_imp_drawable	: EV_PIXMAP_IMP_DRAWABLE
			tmp_bitmap			: WEL_BITMAP
		do
			pixmap_imp ?= a_pixmap.implementation
			pixmap_height := pixmap_imp.height
			pixmap_width := pixmap_imp.width
			source_x := area.x
			source_y := area.y
			source_width := area.width
			source_height := area.height

			if
				pixmap_imp.icon /= Void 
			and then
				source_x = 0
			and then
				source_y = 0
			and then
				source_width = pixmap_width
			and then
				source_height = pixmap_height
			then
				dc.draw_icon_ex (
					pixmap_imp.icon, 
					x, y, 
					pixmap_width, pixmap_height, 
					0, Void, Drawing_constants.Di_normal
				)
			else
					-- Allocate GDI objects
				create s_dc
				s_dc.get

				if pixmap_imp.has_mask then -- Display a masked pixmap
	
						-- Create the mask and image used for display. 
						-- They are different than the real image because 
						-- we need to apply logical operation in order 
						-- to display the masked bitmap.
					tmp_bitmap := pixmap_imp.get_mask_bitmap
					create display_mask_bitmap.make_by_bitmap (tmp_bitmap)
					tmp_bitmap.decrement_reference
					tmp_bitmap := Void
					
					create display_mask_dc.make
					display_mask_dc.select_bitmap(display_mask_bitmap)
						-- Display_mask_dc = NOT MASK
					display_mask_dc.pat_blt
						(source_x, source_y, source_width, source_height, Dstinvert)

					tmp_bitmap := pixmap_imp.get_bitmap
					create display_bitmap.make_by_bitmap(tmp_bitmap)
					tmp_bitmap.decrement_reference
					tmp_bitmap := Void
					
					create display_bitmap_dc.make_by_dc(s_dc)
					display_bitmap_dc.select_bitmap(display_bitmap)

						-- display_bitmap_dc = IMAGE AND (NOT MASK)
					display_bitmap_dc.bit_blt (
						source_x, source_y, 
						source_width, source_height, 
						display_mask_dc, 0, 0, Srcand
					)

						-- Apply NOT MASK
					dc.bit_blt (
						x, y, 
						source_width, source_height, 
						display_mask_dc, source_x, source_y, Maskpaint
					)

						-- Apply IMAGE AND (NOT MASK)
					dc.bit_blt (
						x, y,
						source_width, source_height, 
						display_bitmap_dc, source_x, source_y, Srcpaint
					)

						-- Free GDI Objects
					display_bitmap_dc.unselect_bitmap
					display_bitmap_dc.delete
					display_mask_dc.unselect_bitmap
					display_mask_dc.delete
					display_bitmap.delete
					display_mask_bitmap.delete
	
				else -- Display a not masked pixmap.

					pixmap_imp_drawable ?= pixmap_imp
					if pixmap_imp_drawable = Void then
						tmp_bitmap := pixmap_imp.get_bitmap
						create display_bitmap.make_by_bitmap(tmp_bitmap)
						tmp_bitmap.decrement_reference
						tmp_bitmap := Void
						
						create display_bitmap_dc.make_by_dc(s_dc)
						display_bitmap_dc.select_bitmap(display_bitmap)
					else
						display_bitmap_dc := pixmap_imp_drawable.dc
					end

					dc.bit_blt (
						x, y, 
						source_width, source_height, 
						display_bitmap_dc, source_x, source_y, Srccopy
					)
				end

					-- Free GDI objects
				s_dc.release
			end
			
			on_drawing_modified
		end

	draw_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'.
		do
			remove_brush
			if not internal_initialized_pen then
				reset_pen
			end
			dc.rectangle (x, y, x + a_width, y + a_height)
			on_drawing_modified
		end

	draw_ellipse (x, y, a_bounding_width, a_bounding_height: INTEGER) is
			-- Draw an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
		do
			remove_brush
			if not internal_initialized_pen then
				reset_pen
			end
			dc.ellipse (x, y, x + a_bounding_width, y + a_bounding_height)
			
			on_drawing_modified
		end

	draw_polyline (points: ARRAY [EV_COORDINATE]; is_closed: BOOLEAN) is
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		local
			flat_points: ARRAY [INTEGER]
			flat_index: INTEGER
			i: INTEGER
			coords: EV_COORDINATE
		do
			if is_closed then
				create flat_points.make (1, 2 * points.count + 2)
			else
				create flat_points.make (1, 2 * points.count)
			end
			flat_index := 1
			from
				i := points.lower
			until
				i > points.upper
			loop
				coords := points.item (i)
				flat_points.put (coords.x, flat_index)
				flat_index := flat_index + 1
				flat_points.put (coords.y, flat_index)
				i := i + 1
				flat_index := flat_index + 1
			end
			if is_closed then
				i := points.lower
				flat_points.put ((points.item (i)).x, flat_index)
				flat_index := flat_index + 1
				flat_points.put ((points.item (i)).y, flat_index)
			end

			remove_brush
			if not internal_initialized_pen then
				reset_pen
			end
			dc.polyline (flat_points)
			
			on_drawing_modified
		end

	draw_pie_slice (
		x, y: INTEGER;
		a_bounding_width, a_bounding_height: INTEGER;
		a_start_angle, an_aperture: REAL
	) is
			-- Draw part of an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', 'y').
			-- Angles are measured in radians, start at the
			-- 3 o'clock angle and grow counterclockwise.
		local
			left, top, right, bottom: INTEGER
			x_start_arc, y_start_arc, x_end_arc, y_end_arc: INTEGER
			semi_width, semi_height: DOUBLE
			tang_start, tang_end: DOUBLE
			x_tmp, y_tmp: DOUBLE
		do
			left := x
			top := y
			right := left + a_bounding_width
			bottom := top + a_bounding_height
			
			semi_width := a_bounding_width / 2
			semi_height := a_bounding_height / 2
			tang_start := tangent (a_start_angle)
			tang_end := tangent (a_start_angle + an_aperture)
			
			x_tmp := semi_height / (sqrt (tang_start^2 + semi_height^2 / semi_width^2))
			y_tmp := semi_height / (sqrt (1 + semi_height^2 / (semi_width^2 * tang_start^2)))
			if sine (a_start_angle) > 0 then
				y_tmp := -y_tmp
			end
			if cosine (a_start_angle) < 0 then
				x_tmp := -x_tmp
			end
			x_start_arc := (x_tmp + left + semi_width).rounded
			y_start_arc := (y_tmp + top + semi_height).rounded

			x_tmp := semi_height / (sqrt (tang_end^2 + semi_height^2 / semi_width^2))
			y_tmp := semi_height / (sqrt (1 + semi_height^2 / (semi_width^2 * tang_end^2)))
			if sine (a_start_angle + an_aperture) > 0 then
				y_tmp := -y_tmp
			end
			if cosine (a_start_angle + an_aperture) < 0 then
				x_tmp := -x_tmp
			end
			x_end_arc := (x_tmp + left + semi_width).rounded
			y_end_arc := (y_tmp + top + semi_height).rounded
			
			remove_brush
			if not internal_initialized_pen then
				reset_pen
			end
			if an_aperture /= 0.0 then
				dc.pie (left, top, right, bottom, x_start_arc,
					y_start_arc, x_end_arc, y_end_arc)
			else
				dc.move_to ((left + semi_width).rounded, (top + semi_height).rounded)
				dc.line_to (x_start_arc, y_start_arc)
			end
			
			on_drawing_modified
		end

feature -- Filling operations

	fill_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'. Fill with `foreground_color'.
		do
			remove_pen
			if not internal_initialized_brush then
				reset_brush
			end
			dc.rectangle (x, y, x + a_width + 1, y + a_height + 1)
			
			on_drawing_modified
		end 

	fill_ellipse (x, y, a_bounding_width, a_bounding_height: INTEGER) is
			-- Fill an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
		do
			remove_pen
			if not internal_initialized_brush then
				reset_brush
			end
			dc.ellipse (x, y, x + a_bounding_width + 1, y + a_bounding_height + 1)
			
			on_drawing_modified
		end

	fill_polygon (points: ARRAY [EV_COORDINATE]) is
			-- Draw line segments between subsequent points in `points'.
			-- Fill all enclosed area's with `foreground_color'.
		local
			flat_points: ARRAY [INTEGER]
			i, flat_i: INTEGER
			coords: EV_COORDINATE
		do
			create flat_points.make (1, 2 * points.count)
			flat_i := 1
			from
				i := points.lower
			until
				i > points.upper
			loop
				coords := points.item (i)
				flat_points.put (coords.x, flat_i)
				flat_i := flat_i + 1
				flat_points.put (coords.y, flat_i)
				flat_i := flat_i + 1
				i := i + 1
			end
			remove_pen
			if not internal_initialized_brush then
				reset_brush
			end
			dc.polygon (flat_points)
			
			on_drawing_modified
		end

	fill_pie_slice (
		x, y :INTEGER;
		a_bounding_width, a_bounding_height: INTEGER;
		a_start_angle, an_aperture: REAL
	) is
			-- Fill part of an ellipse defined by a rectangular area with an
			-- upper left corner at `x',`y', width `a_bounding_width' and height
			-- `a_bounding_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', 'y').
			-- Angles are measured in radians, start at the 3
			-- o'clock angle and grow counterclockwise.
		local
			left, top, right, bottom: INTEGER
			x_start_arc, y_start_arc, x_end_arc, y_end_arc: INTEGER
			internal_bounding_width, internal_bounding_height: INTEGER
			semi_width, semi_height: DOUBLE
			tang_start, tang_end: DOUBLE
			x_tmp, y_tmp: DOUBLE			
		do
			--| We add one to `a_bounding_width' and `a_bounding_height' as
			--| when we fill on Windows, the filled area seems to be slightly smaller
			--| than when we simple draw.
			
			if an_aperture /= 0.0 then
				left := x
				top := y
				internal_bounding_width := a_bounding_width + 1
				internal_bounding_height := a_bounding_height + 1
				right := x + internal_bounding_width
				bottom := top + internal_bounding_height
	
				semi_width := internal_bounding_width / 2
				semi_height := internal_bounding_height / 2
				tang_start := tangent (a_start_angle)
				tang_end := tangent (a_start_angle + an_aperture)
				
				x_tmp := semi_height / (sqrt (tang_start^2 + semi_height^2 / semi_width^2))
				y_tmp := semi_height / (sqrt (1 + semi_height^2 / (semi_width^2 * tang_start^2)))
				if sine (a_start_angle) > 0 then
					y_tmp := -y_tmp
				end
				if cosine (a_start_angle) < 0 then
					x_tmp := -x_tmp
				end
				x_start_arc := (x_tmp + left + semi_width).rounded
				y_start_arc := (y_tmp + top + semi_height).rounded
	
				x_tmp := semi_height / (sqrt (tang_end^2 + semi_height^2 / semi_width^2))
				y_tmp := semi_height / (sqrt (1 + semi_height^2 / (semi_width^2 * tang_end^2)))
				if sine (a_start_angle + an_aperture) > 0 then
					y_tmp := -y_tmp
				end
				if cosine (a_start_angle + an_aperture) < 0 then
					x_tmp := -x_tmp
				end
				x_end_arc := (x_tmp + left + semi_width).rounded
				y_end_arc := (y_tmp + top + semi_height).rounded
				
				remove_pen
				if not internal_initialized_brush then
					reset_brush
				end
				dc.pie (left, top, right, bottom, x_start_arc,
					y_start_arc, x_end_arc, y_end_arc)
				
				on_drawing_modified
			end
		end

feature {NONE} -- Implementation

	on_drawing_modified is
			-- Called when the content of the drawing has been modified.
		do
		end

	wel_drawing_mode: INTEGER
			-- The WEL equivalent for the drawing_mode_* selected.

	wel_font: WEL_FONT is
		local
			font_imp: EV_FONT_IMP
		do
			if private_font /= Void then
				font_imp ?= private_font.implementation
				Result := font_imp.wel_font
			else
				Result := private_wel_font
			end
		end

	wel_bg_color: WEL_COLOR_REF is
		do
			Result ?= background_color.implementation
		ensure
			not_void: Result /= Void
		end

	wel_fg_color: WEL_COLOR_REF is
		do
			Result ?= foreground_color.implementation
		ensure
			not_void: Result /= Void
		end

	our_background_brush: WEL_BRUSH is
			-- Current window background color used to refresh the window when
			-- requested by the WM_ERASEBKGND windows message.
		do
			Result := allocated_brushes.get (Void, wel_bg_color)
			if not internal_initialized_background_brush then
				internal_initialized_background_brush := True
				internal_background_brush := Result
			elseif Result /= internal_background_brush then
					-- If it is different, it means that `wel_bg_color' changed
					-- since last time and we need to update it
				internal_background_brush.decrement_reference
				internal_background_brush := Result
			end
		end

	set_background_brush is
			-- Set background-brush. For clear-operations.
		do
			dc.select_brush (our_background_brush)
		end

	reset_brush is
			-- Restore brush to tile or color.
		local
			pix_imp: EV_PIXMAP_IMP
			a_wel_bitmap: WEL_BITMAP
		do
			if not internal_initialized_brush then

					-- Reset `internal_brush'.
				if internal_brush /= Void then
					internal_brush.decrement_reference
					internal_brush := Void
				end

				if tile /= Void then
					pix_imp ?= tile.implementation
					a_wel_bitmap := pix_imp.get_bitmap
					internal_brush := allocated_brushes.get(
						a_wel_bitmap, Void)
					a_wel_bitmap.decrement_reference
				else
					internal_brush := allocated_brushes.get(
						Void, wel_fg_color)
				end
				internal_initialized_brush := True
			end

				-- Unselect previously selected brush.
			if dc.brush_selected then
				dc.unselect_brush
			end
				-- Select new brush.
			dc.select_brush (internal_brush)
		end

	reset_pen is
			-- Restore pen to correct line width and color
		local
			dmode: INTEGER
		do
			if line_width = 0 then
				remove_pen
			else
					-- unselect currently selected pen.
				if dc.pen_selected then
					dc.unselect_pen
				end

				if not internal_initialized_pen then

						-- Reset `internal_pen'.
					if internal_pen /= Void then
						internal_pen.decrement_reference
						internal_pen := Void
					end

					if dashed_line_style then
						dmode := Ps_dot
					else
						dmode := Ps_solid
					end
					internal_pen := allocated_pens.get (
						dmode, line_width, wel_fg_color)
					internal_initialized_pen := True
				end

				dc.select_pen (internal_pen)
			end
		end

	remove_pen is
			-- Draw without outline.
		do
			if dc.pen_selected then
				dc.unselect_pen
			end
			dc.select_pen (empty_pen)

			if internal_pen /= Void then
				internal_initialized_pen := False
				internal_pen.decrement_reference
				internal_pen := Void
			end
		end

	remove_brush is
			-- Draw without filling.
		do
			if dc.brush_selected then
				dc.unselect_brush
			end
			dc.select_brush (empty_brush)

			if internal_brush /= Void then
				internal_initialized_brush := False
				internal_brush.decrement_reference
				internal_brush := Void
			end
		end

feature {EV_ANY, EV_ANY_I} -- Command

	destroy is
			-- Destroy actual object.
		do
			if internal_brush /= Void then
				internal_brush.decrement_reference
				internal_brush := Void
			end
			if internal_pen /= Void then
				internal_pen.decrement_reference
				internal_pen := Void
			end
			if internal_background_brush /= Void then
				internal_background_brush.decrement_reference
				internal_background_brush := Void
			end

			is_destroyed := True
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_DRAWABLE

feature {EV_DRAWABLE_IMP} -- Internal datas.

	internal_background_brush: WEL_BRUSH
			-- Buffered background brush. Created in order to
			-- avoid multiple WEL_BRUSHes creation.

	internal_brush: WEL_BRUSH
			-- Buffered current brush. Created in order to
			-- avoid multiple WEL_BRUSHes creation.

	internal_pen: WEL_PEN
			-- Buffered current pen. Created in order to
			-- avoid multiple WEL_PENs creation.

	internal_initialized_pen: BOOLEAN
			-- Is `internal_pen' valid? (can be invalidated if
			-- the user change the foreground color, the width, ...)

	internal_initialized_text_color: BOOLEAN
			-- Is the current text valid? (can be invalidated if
			-- the user change the foreground color)

	internal_initialized_font: BOOLEAN
			-- Is the current selected font valid? (can be invalidated if
			-- the user change the font)

	internal_initialized_background_brush: BOOLEAN
			-- Is `internal_background_brush' valid?

	internal_initialized_brush: BOOLEAN
			-- Is `internal_brush' valid?

	empty_brush: WEL_BRUSH is
			-- Null brush (used when one want to draw
			-- a figure without filling it)
		local
			log_brush: WEL_LOG_BRUSH
		once
			create log_brush.make (Bs_null, wel_fg_color, Hs_horizontal)
			create Result.make_indirect(log_brush)
		end

	empty_pen: WEL_PEN is
			-- Null brush (used when one want to draw
			-- a figure without outlining it)
		once
			create Result.make (Ps_null, 1, wel_fg_color)
		end

feature {NONE} -- Non-applicable

	wel_set_font (a_font: WEL_FONT) is
			-- Make `a_font' new font of widget.
		do
		end

feature {NONE} -- Constants

	Drawing_constants: WEL_DRAWING_CONSTANTS is
			-- WEL Drawing constants.
		once
			create Result
		end

invariant
	reference_tracked_on_brush:
		internal_brush /= Void implies internal_brush.reference_tracked

	brush_exists:
		internal_brush /= Void implies internal_brush.exists

	reference_tracked_on_pen:
		internal_pen /= Void implies internal_pen.reference_tracked

end -- class EV_DRAWABLE_IMP

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

