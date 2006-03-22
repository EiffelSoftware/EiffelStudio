indexing
	description: "EiffelVision drawable. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
	WEL_DT_CONSTANTS				export {NONE} all end

	WEL_SHARED_TEMPORARY_OBJECTS
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	initialize is
			-- Set some default values.
		do
			set_default_font

			if background_color = Void then
				background_color := create {EV_COLOR}.make_with_rgb (1, 1, 1)
			end
			if foreground_color = Void then
				foreground_color := create {EV_COLOR}.make_with_rgb (0, 0, 0)
			end

				-- Initialise the device for painting.
			set_drawing_mode (drawing_mode_copy)
			reset_pen
			reset_brush
			set_line_width (1)

			set_is_initialized (True)
		end

feature --{EV_ANY_I} -- Implementation

	dc: WEL_DC is
			-- Device context applied to the primitives.
		deferred
		ensure
			not_void: dc /= Void
		end

	get_dc is
			-- Get `dc'.
			-- By default does nothing, but is
			-- redefined by primitives that do not keep a consistent
			-- dc. Example : EV_DRAWING_AREA_IMP
		do
		end

	release_dc is
			-- Release `dc'.
			-- By default does nothing, but is
			-- redefined by primitives that do not keep a consistent
			-- dc. Example : EV_DRAWING_AREA_IMP
		do
		end

feature -- Access

	sub_pixmap (area: EV_RECTANGLE): EV_PIXMAP is
			-- Return the subpixmap of `Current' described by rectangle `area'.
		local
			a_pixmap_imp: EV_PIXMAP_IMP
			a_private_bitmap: WEL_BITMAP
			reusable_dc: WEL_MEMORY_DC
		do
			create Result
			a_pixmap_imp ?= Result.implementation
			create reusable_dc.make_by_dc (dc)
			create a_private_bitmap.make_compatible (dc, area.width, area.height)
			reusable_dc.select_bitmap (a_private_bitmap)

			reusable_dc.bit_blt (0, 0, area.width, area.height, dc, area.x, area.y, srccopy)

			a_pixmap_imp.set_bitmap_and_mask (a_private_bitmap, Void, area.width, area.height)

				-- Clean up
			reusable_dc.unselect_bitmap
			reusable_dc.delete
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
			get_dc
			dc.set_rop2 (wel_drawing_mode)
			release_dc
		end

	set_clip_area (an_area: EV_RECTANGLE) is
			-- Set an area to clip to.
			-- Set to Void when no clipping should be applied.
		local
			region: WEL_REGION
		do
			clip_area := an_area.twin
			create region.make_rect (clip_area.x, clip_area.y,
				clip_area.width + clip_area.x,
				clip_area.height + clip_area.y)
			get_dc
			dc.select_clip_region (region)
			release_dc
			region.delete
		end

	remove_clip_area is
			-- Do not apply any clipping.
		do
			clip_area := Void
			get_dc
			dc.remove_clip_region
			release_dc
		end

	set_tile (a_pixmap: EV_PIXMAP) is
			-- Set tile used to fill figures.
			-- Set to Void to use `background_color' to fill.
		do
			tile := a_pixmap
			internal_initialized_brush := False
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
		local
			font_imp: EV_FONT_IMP
		do
			private_font := a_font
			font_imp ?= private_font.implementation
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
		do
			wel_rect.set_rect (x1, y1, x1 + a_width, y1 + a_height)
			get_dc
			dc.fill_rect (wel_rect, our_background_brush)
			release_dc
		end

feature -- Drawing operations

	draw_point (x, y: INTEGER) is
			-- Draw point at (`x', `y').
		do
			if not internal_initialized_pen then
				reset_pen
			end
			get_dc
			dc.set_pixel (x, y, wel_fg_color)
			release_dc
		end

	draw_rotated_text (x, y: INTEGER; a_angle: REAL; a_text: STRING) is
			-- Draw rotated text `a_text' with left of baseline at (`x', `y') using `font'.
			-- Rotation is number of radians counter-clockwise from horizontal plane.
		do
			internal_draw_text (x, y, a_angle, 0, True, a_text)
		end

	draw_text (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
		do
			internal_draw_text (x, y, 0, 0, True, a_text)
		end

	draw_text_top_left (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		do
			internal_draw_text (x, y, 0, 0, False, a_text)
		end

	draw_ellipsed_text (x, y: INTEGER; a_text: STRING; clipping_width: INTEGER) is
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		do
			internal_draw_text (x, y, 0, clipping_width, True, a_text)
		end

	draw_ellipsed_text_top_left (x, y: INTEGER; a_text: STRING; clipping_width: INTEGER) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		do
			internal_draw_text (x, y, 0, clipping_width, False, a_text)
		end

	internal_draw_text (x, y: INTEGER; angle: REAL; clipping_width: INTEGER; from_baseline: BOOLEAN; a_text: STRING) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
			-- Text is rotated counter-clockwise from the horizontal axis `degrees' degrees.
		local
			l_font: WEL_FONT
			l_log_font: WEL_LOG_FONT
			l_flags: INTEGER
			l_dc: like dc
			l_wel_rect: like wel_rect
		do
			get_dc
			l_dc := dc
			if not internal_initialized_text_color then
				l_dc.set_text_color (wel_fg_color)
				internal_initialized_text_color := True
			end

			l_font := wel_font
			if angle /= 0 then
				l_log_font := l_font.log_font
					-- Convert radians to escapement units which is 1/10th of a degree
				l_log_font.set_escapement ((angle * 1800 / Pi).rounded)
				create l_font.make_indirect (l_log_font)
				l_log_font.dispose
				if l_dc.font_selected then
					l_dc.unselect_font
				end
				l_dc.select_font (l_font)
				internal_initialized_font := False
					-- We want to make sure that the font gets reset upon next call to draw text.
			elseif not internal_initialized_font then
				l_dc.select_font (l_font)
				internal_initialized_font := True
			end


			l_flags := Dt_noprefix | Dt_noclip

			if clipping_width > 0 then
				l_flags := l_flags | Dt_word_ellipsis
			else
				l_flags := l_flags | Dt_expandtabs
			end

			if from_baseline then
				l_dc.set_text_alignment (ta_baseline | ta_left)
			else
				l_dc.set_text_alignment (ta_top | ta_left)
			end

			l_wel_rect := wel_rect
			l_wel_rect.set_rect (x, y, x + clipping_width, 10)
				-- Note that the size of the rectangle does not matter if we use the `dt_noclip' flag.
			l_dc.draw_text (a_text, l_wel_rect, l_flags)

			if not internal_initialized_font then
					-- We must have rotated a font so cleanup.
				l_dc.unselect_font
				l_font.delete
			end
			release_dc
		end


	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		do
			if not internal_initialized_pen then
				reset_pen
			end
			get_dc
			dc.move_to (x1, y1)

			dc.line_to (x2, y2)
				-- As `line_to' does not actually draw the final
				-- pixel, we need to draw this ourselved, so ensure
				-- that the line really does include `x2', `y2'.
			dc.set_pixel (x2, y2, wel_fg_color)
			release_dc
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
				-- It appears that the divide by 0 we are protecting against in
				-- `Current' will fail on Borland, but not microsoft.
			left := x
			top := y
			right := left + a_bounding_width
			bottom := top + a_bounding_height

			semi_width := a_bounding_width / 2
			semi_height := a_bounding_height / 2
			tang_start := tangent (a_start_angle)
			tang_end := tangent (a_start_angle + an_aperture)
				-- We must protect against both possible divides by 0.
			if tang_start + semi_height /= 0 and semi_width /= 0 then
				x_tmp := semi_height / (sqrt (tang_start ^ 2 + semi_height ^ 2 / semi_width ^ 2))
			else
				x_tmp := 0
			end
				-- We must protect against divide by 0.
			if tang_start /= 0 and semi_width /= 0 then
				y_tmp := semi_height / (sqrt (1 + semi_height ^ 2 / (semi_width ^ 2 * tang_start ^ 2)))
			else
				y_tmp := 0
			end
			if sine (a_start_angle) > 0 then
				y_tmp := - y_tmp
			end
			if cosine (a_start_angle) < 0 then
				x_tmp := - x_tmp
			end
			x_start_arc := (x_tmp + left + semi_width).rounded
			y_start_arc := (y_tmp + top + semi_height).rounded
				-- We must protect against both possible divides by 0.
			if tang_end + semi_height /= 0 and semi_width /= 0 then
				x_tmp := semi_height / (sqrt (tang_end ^ 2 + semi_height ^ 2 / semi_width ^ 2))
			else
				x_tmp := 0
			end
				-- We must ensure that we protect against divide by 0.
			if tang_end /= 0 and semi_width /= 0 then
				y_tmp := semi_height / (sqrt (1 + semi_height ^ 2 / (semi_width ^ 2 * tang_end ^ 2)))
			else
				y_tmp := 0
			end
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
			get_dc
			if an_aperture /= 0.0 then
				dc.arc (left, top, right, bottom, x_start_arc,
					y_start_arc, x_end_arc, y_end_arc)
			else
				dc.set_pixel (x_start_arc, y_start_arc, wel_fg_color)
			end
			release_dc
		end

	draw_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' with upper-left corner on (`x', `y').
		local
			pixmap_imp : EV_PIXMAP_IMP_STATE
			l_bounding_area: like bounding_area
		do
			pixmap_imp ?= a_pixmap.implementation
			l_bounding_area := bounding_area
			l_bounding_area.move_and_resize (0, 0, pixmap_imp.width, pixmap_imp.height)
			draw_sub_pixmap (x, y, a_pixmap, l_bounding_area)
		end

	bounding_area: EV_RECTANGLE is
			-- Temporary rectangle used internally.
		once
			create Result
		end

	--| FIXME IEK Update with new feature when pixmap masking code is fully integrated
	draw_sub_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; area: EV_RECTANGLE) is
			-- Draw `area' of `a_pixmap' with upper-left corner on (`x', `y').
		local
			pixmap_height		: INTEGER
			pixmap_width		: INTEGER
			source_x			: INTEGER
			source_y			: INTEGER
			source_width		: INTEGER
			source_height		: INTEGER
			source_mask_bitmap	: WEL_BITMAP
			source_bitmap		: WEL_BITMAP
			s_dc				: WEL_SCREEN_DC
			source_mask_dc		: WEL_MEMORY_DC
			source_bitmap_dc	: WEL_MEMORY_DC
			pixmap_imp			: EV_PIXMAP_IMP_STATE
			source_drawable	: EV_PIXMAP_IMP_DRAWABLE
			dest_dc				: WEL_DC
			temp_foreground_color	: WEL_COLOR_REF
			temp_background_color	: WEL_COLOR_REF
		do
			pixmap_imp ?= a_pixmap.implementation
			pixmap_height := pixmap_imp.height
			pixmap_width := pixmap_imp.width
			source_x := area.x
			source_y := area.y
			source_width := area.width
			source_height := area.height
			get_dc
			if
				pixmap_imp.icon /= Void and then
				source_x = 0 and then source_y = 0 and then
				source_width = pixmap_width and then
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
				
				dest_dc := dc

				if pixmap_imp.has_mask then -- Display a masked pixmap
				
					source_drawable ?= pixmap_imp
					
					if source_drawable /= Void then
							-- If the dc's are already available then we use them without reffing
						source_bitmap_dc := source_drawable.dc
						source_mask_dc := source_drawable.mask_dc
					else
							-- Retrieve Source bitmap
						source_bitmap := pixmap_imp.get_bitmap
						
							-- Create dc for Source bitmap
						create source_bitmap_dc.make_by_dc (s_dc)
						source_bitmap_dc.select_bitmap (source_bitmap)
						
							-- Retrieve Mask bitmap
						source_mask_bitmap := pixmap_imp.get_mask_bitmap
						
							-- Create dc for Mask bitmap
						create source_mask_dc.make_by_dc (s_dc)
						source_mask_dc.select_bitmap (source_mask_bitmap)
					end

						-- Store original colors as they need to be unset for masking
					temp_background_color := dest_dc.background_color
					temp_foreground_color := dest_dc.text_color

					dest_dc.set_text_color (create {WEL_COLOR_REF}.make_rgb (0, 0, 0))
					dest_dc.set_background_color (create {WEL_COLOR_REF}.make_rgb (255, 255, 255))

						-- Xor source to destination
					dest_dc.bit_blt (x, y, source_width, source_height, source_bitmap_dc, source_x, source_y, Srcinvert)
					
						-- Set opaque pixels to black on destination
					dest_dc.bit_blt (x, y, source_width, source_height, source_mask_dc, source_x, source_y, Srcand)
					
						-- Re Xor source to destination to restore original pixels
					dest_dc.bit_blt (x, y, source_width, source_height, source_bitmap_dc, source_x, source_y, Srcinvert)
					
						-- Reset colors
					dest_dc.set_text_color (temp_foreground_color)
					dest_dc.set_background_color (temp_background_color)

						-- Free newly created GDI Objects if source isn't a pixmap drawable
					if source_drawable = Void then
						source_bitmap_dc.unselect_bitmap
						source_bitmap_dc.delete
						source_mask_dc.unselect_bitmap
						source_mask_dc.delete
						source_bitmap.decrement_reference
						source_mask_bitmap.decrement_reference						
					end

				else -- Display a not masked pixmap.

					source_drawable ?= pixmap_imp
					if source_drawable = Void then
							-- Source bitmap dc
						source_bitmap := pixmap_imp.get_bitmap
						create source_bitmap_dc.make_by_dc (s_dc)
						source_bitmap_dc.select_bitmap (source_bitmap)
						
						dest_dc.bit_blt (
							x, y, 
							source_width, source_height, 
							source_bitmap_dc, source_x, source_y, src_drawing_mode
						)
							-- Free GDI Objects
						source_bitmap_dc.unselect_bitmap
						source_bitmap_dc.delete
						source_bitmap.decrement_reference
					else
						source_bitmap_dc := source_drawable.dc
						dest_dc.bit_blt (
							x, y, 
							source_width, source_height, 
							source_bitmap_dc, source_x, source_y, src_drawing_mode
						)
					end

				end

					-- Free GDI objects
				s_dc.release
			end
			release_dc
		end

--	draw_sub_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; area: EV_RECTANGLE) is
--			-- Draw `area' of `a_pixmap' with upper-left corner on (`x', `y').
--		local
--			pixmap_height		: INTEGER
--			pixmap_width		: INTEGER
--			source_x			: INTEGER
--			source_y			: INTEGER
--			source_width		: INTEGER
--			source_height		: INTEGER
--			source_mask_bitmap	: WEL_BITMAP
--			source_bitmap		: WEL_BITMAP
--			s_dc				: WEL_SCREEN_DC
--			source_mask_dc		: WEL_MEMORY_DC
--			source_bitmap_dc	: WEL_MEMORY_DC
--			pixmap_imp			: EV_PIXMAP_IMP_STATE
--			source_drawable	: EV_PIXMAP_IMP_DRAWABLE
--			dest_dc				: WEL_DC
--			temp_foreground_color	: WEL_COLOR_REF
--			temp_background_color	: WEL_COLOR_REF
--			l_backbuffer: WEL_BITMAP
--			l_backbuffer_dc: WEL_MEMORY_DC
--		do
--			pixmap_imp ?= a_pixmap.implementation
--			pixmap_height := pixmap_imp.height
--			pixmap_width := pixmap_imp.width
--			source_x := area.x
--			source_y := area.y
--			source_width := area.width
--			source_height := area.height
--			get_dc
--			if
--				pixmap_imp.icon /= Void and then
--				source_x = 0 and then source_y = 0 and then
--				source_width = pixmap_width and then
--				source_height = pixmap_height
--			then
--				dc.draw_icon_ex (
--					pixmap_imp.icon,
--					x, y,
--					pixmap_width, pixmap_height,
--					0, Void, Drawing_constants.Di_normal
--				)
--			else
--					-- Allocate GDI objects
--				create s_dc
--				s_dc.get
--
--				dest_dc := dc
--
--				if pixmap_imp.has_mask then -- Display a masked pixmap
--
--					source_drawable ?= pixmap_imp
--
--					if source_drawable /= Void then
--							-- If the dc's are already available then we use them without reffing
--						source_bitmap_dc := source_drawable.dc
--						source_mask_dc := source_drawable.mask_dc
--					else
--							-- Retrieve Source bitmap
--						source_bitmap := pixmap_imp.get_bitmap
--
--							-- Create dc for Source bitmap
--						create source_bitmap_dc.make_by_dc (s_dc)
--						source_bitmap_dc.select_bitmap (source_bitmap)
--
--							-- Retrieve Mask bitmap
--						source_mask_bitmap := pixmap_imp.get_mask_bitmap
--
--							-- Create dc for Mask bitmap
--						create source_mask_dc.make_by_dc (s_dc)
--						source_mask_dc.select_bitmap (source_mask_bitmap)
--					end
--
--
--					create l_backbuffer.make_compatible (dest_dc, source_width, source_height)
--					create l_backbuffer_dc.make_by_dc (dest_dc)
--					l_backbuffer_dc.select_bitmap (l_backbuffer)
--
--					l_backbuffer_dc.bit_blt (0, 0, source_width, source_height, source_bitmap_dc, source_x, source_y, srccopy)
--					l_backbuffer_dc.bit_blt (0, 0, source_width, source_height, source_mask_dc, source_x, source_y, srcand)
--
--					dest_dc.bit_blt (x, y, source_width, source_height, source_mask_dc, source_x, source_y, maskpaint)
--
--					dest_dc.bit_blt (x, y, source_width, source_height, l_backbuffer_dc, 0, 0, srcpaint)
--
--					l_backbuffer_dc.unselect_bitmap
--					l_backbuffer_dc.delete
--					l_backbuffer.delete
--
--						-- Free newly created GDI Objects if source isn't a pixmap drawable
--					if source_drawable = Void then
--						source_bitmap_dc.unselect_bitmap
--						source_bitmap_dc.delete
--						source_mask_dc.unselect_bitmap
--						source_mask_dc.delete
--						source_bitmap.decrement_reference
--						source_mask_bitmap.decrement_reference
--					end
--
--				else -- Display a not masked pixmap.
--
--					source_drawable ?= pixmap_imp
--					if source_drawable = Void then
--							-- Source bitmap dc
--						source_bitmap := pixmap_imp.get_bitmap
--						create source_bitmap_dc.make_by_dc (s_dc)
--						source_bitmap_dc.select_bitmap (source_bitmap)
--
--						dest_dc.bit_blt (
--							x, y,
--							source_width, source_height,
--							source_bitmap_dc, source_x, source_y, src_drawing_mode
--						)
--							-- Free GDI Objects
--						source_bitmap_dc.unselect_bitmap
--						source_bitmap_dc.delete
--						source_bitmap.decrement_reference
--					else
--						source_bitmap_dc := source_drawable.dc
--						dest_dc.bit_blt (
--							x, y,
--							source_width, source_height,
--							source_bitmap_dc, source_x, source_y, src_drawing_mode
--						)
--					end
--
--				end
--
--					-- Free GDI objects
--				s_dc.release
--			end
--			release_dc
--		end

	draw_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'.
		do
			remove_brush
			if not internal_initialized_pen then
				reset_pen
			end
			get_dc
			dc.rectangle (x, y, x + a_width, y + a_height)
			release_dc
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
			get_dc
			dc.ellipse (x, y, x + a_bounding_width, y + a_bounding_height)
			release_dc
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
			get_dc
			dc.polyline (flat_points)
			release_dc
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
				-- It appears that the divide by 0 we are protecting against in
				-- `Current' will fail on Borland, but not microsoft.
			left := x
			top := y
			right := left + a_bounding_width
			bottom := top + a_bounding_height

			semi_width := a_bounding_width / 2
			semi_height := a_bounding_height / 2
			tang_start := tangent (a_start_angle)
			tang_end := tangent (a_start_angle + an_aperture)

				-- We must protect against both possible divides by 0.
			if tang_start + semi_height /= 0 and semi_width /= 0 then
				x_tmp := semi_height / (sqrt (tang_start^2 + semi_height^2 / semi_width^2))
			else
				x_tmp := 0
			end
				-- We must ensure that we protect against divide by 0.
			if tang_start /= 0 and semi_width /= 0 then
				y_tmp := semi_height / (sqrt (1 + semi_height^2 / (semi_width^2 * tang_start^2)))
			else
				y_tmp := 0
			end
			if sine (a_start_angle) > 0 then
				y_tmp := -y_tmp
			end
			if cosine (a_start_angle) < 0 then
				x_tmp := -x_tmp
			end
			x_start_arc := (x_tmp + left + semi_width).rounded
			y_start_arc := (y_tmp + top + semi_height).rounded

				-- We must protect against both possible divides by 0.
			if tang_end + semi_height /= 0 and semi_width /= 0 then
				x_tmp := semi_height / (sqrt (tang_end^2 + semi_height^2 / semi_width^2))
			else
				x_tmp := 0
			end
				-- We must ensure that we protect against divide by 0.
			if semi_width /= 0 and tang_end /= 0 then
				y_tmp := semi_height / (sqrt (1 + semi_height^2 / (semi_width^2 * tang_end^2)))
			else
				y_tmp := 0
			end
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
			get_dc
			if an_aperture /= 0.0 then
				dc.pie (left, top, right, bottom, x_start_arc,
					y_start_arc, x_end_arc, y_end_arc)
			else
				dc.move_to ((left + semi_width).rounded, (top + semi_height).rounded)
				dc.line_to (x_start_arc, y_start_arc)
			end
			release_dc
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
			get_dc
			dc.rectangle (x, y, x + a_width + 1, y + a_height + 1)
			release_dc
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
			get_dc
			dc.ellipse (x, y, x + a_bounding_width + 1, y + a_bounding_height + 1)
			release_dc
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
			get_dc
			dc.polygon (flat_points)
			release_dc
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
			-- It appears that the divide by 0 we are protecting against in
			-- `Current' will fail on Borland, but not microsoft.
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

					-- We must protect against both possible divides by 0.
				if tang_start + semi_height /= 0 and semi_width /= 0 then
					x_tmp := semi_height / (sqrt (tang_start^2 + semi_height^2 / semi_width^2))
				else
					x_tmp := 0
				end
					-- We must ensure that we protect against divide by 0.
				if semi_width /= 0 and tang_start /= 0 then
					y_tmp := semi_height / (sqrt (1 + semi_height^2 / (semi_width^2 * tang_start^2)))
				else
					y_tmp := 0
				end
				if sine (a_start_angle) > 0 then
					y_tmp := -y_tmp
				end
				if cosine (a_start_angle) < 0 then
					x_tmp := -x_tmp
				end
				x_start_arc := (x_tmp + left + semi_width).rounded
				y_start_arc := (y_tmp + top + semi_height).rounded

					-- We must protect against both possible divides by 0.
				if tang_end + semi_height /= 0 and semi_width /= 0 then
					x_tmp := semi_height / (sqrt (tang_end^2 + semi_height^2 / semi_width^2))
				else
					x_tmp := 0
				end
					-- We must ensure that we protect against divide by 0.
				if semi_width /= 0 and tang_end /= 0 then
					y_tmp := semi_height / (sqrt (1 + semi_height^2 / (semi_width^2 * tang_end^2)))
				else
					y_tmp := 0
				end
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
				get_dc
				dc.pie (left, top, right, bottom, x_start_arc,
					y_start_arc, x_end_arc, y_end_arc)
				release_dc
			end
		end

feature {NONE} -- Implementation

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
			pix_imp: EV_PIXMAP_IMP_STATE
			a_wel_bitmap: WEL_BITMAP
		do
			get_dc
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
			release_dc
		end

	reset_pen is
			-- Restore pen to correct line width and color
		local
			dmode: INTEGER
		do
			get_dc
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
			release_dc
		end

	remove_pen is
			-- Draw without outline.
		do
			get_dc
			if dc.pen_selected then
				dc.unselect_pen
			end
			dc.select_pen (empty_pen)

			if internal_pen /= Void then
				internal_initialized_pen := False
				internal_pen.decrement_reference
				internal_pen := Void
			end
			release_dc
		end

	remove_brush is
			-- Draw without filling.
		do
			get_dc
			if dc.brush_selected then
				dc.unselect_brush
			end
			dc.select_brush (empty_brush)

			if internal_brush /= Void then
				internal_initialized_brush := False
				internal_brush.decrement_reference
				internal_brush := Void
			end
			release_dc
		end

	src_drawing_mode: INTEGER is
			-- Src drawing mode from current `wel_drawing_mode'
			-- Used for bit blits.
		do
			inspect wel_drawing_mode
			when R2_copypen then
				Result := Srccopy
			when R2_xorpen then
				Result := Srcerase
			when R2_not then
				Result := Srcinvert
			when R2_maskpen then
				Result := Srcand
			when R2_mergepen then
				Result := Srcpaint
			else
				check
					invalid_mode: False
				end
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

			set_is_destroyed (True)
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




end -- class EV_DRAWABLE_IMP

