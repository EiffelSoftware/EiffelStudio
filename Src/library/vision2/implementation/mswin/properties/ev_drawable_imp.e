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

	EV_DRAWABLE_CONSTANTS

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end

	WEL_ROP2_CONSTANTS
		export
			{NONE} all
		end

	WEL_TA_CONSTANTS
		export
			{NONE} all
		end

	WEL_WINDOWS_ROUTINES
		export
			{NONE} all
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

	WEL_PS_CONSTANTS
		export
			{NONE} all
		end

	WEL_BRUSH_STYLE_CONSTANTS
		export
			{NONE} all
		end

	WEL_RASTER_OPERATIONS_CONSTANTS
		export
			{NONE} all
		end

	WEL_HS_CONSTANTS
		export
			{NONE} all
		end

	EXCEPTIONS
		rename
			raise as exception_raise,
			class_name as exception_class_name
		end

feature {NONE} -- Initialization

	initialize is
			-- Set some default values.
		do
			create internal_font
			create foreground_color.make_with_rgb (0, 0, 0)
			create background_color.make_with_rgb (1, 1, 1)

				-- Initialise the device for painting.
			dc.set_background_opaque
			dc.set_background_transparent
--			dc.set_text_alignment (Ta_baseline)

			set_drawing_mode (Ev_drawing_mode_copy)
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
			exists: dc.exists
		end

	get_dc: BOOLEAN

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
				Result := Ev_drawing_mode_copy
			elseif wel_drawing_mode = R2_xorpen then
				Result := Ev_drawing_mode_xor
			elseif wel_drawing_mode = R2_not then
				Result := Ev_drawing_mode_invert
			elseif wel_drawing_mode = R2_maskpen then
				Result := Ev_drawing_mode_and
			elseif wel_drawing_mode = R2_mergepen then
				Result := Ev_drawing_mode_or
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

	font: EV_FONT is
			-- Character appearance.
		do
			Result := internal_font
		end

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
		do
			if not a_color.is_equal(background_color) then
				background_color.copy (a_color)

					-- update current background brush (lazzy evaluation)
				internal_initialized_background_brush := False
			end
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		do
			if not a_color.is_equal(foreground_color) then
				foreground_color.copy (a_color)
			
					-- update current pen & brush (lazzy evaluation)
				internal_initialized_brush := False
				internal_initialized_pen := False
				dc.set_text_color (wel_fg_color)
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
			when Ev_drawing_mode_copy then
				wel_drawing_mode := R2_copypen
			when Ev_drawing_mode_xor then
				wel_drawing_mode := R2_xorpen
			when Ev_drawing_mode_invert then
				wel_drawing_mode := R2_not
			when Ev_drawing_mode_and then
				wel_drawing_mode := R2_maskpen
			when Ev_drawing_mode_or then
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
		end

	remove_clip_area is
			-- Do not apply any clipping.
		local
			region: WEL_REGION
		do
			clip_area := Void
			create region.make_rect (0, 0, width, height)
			dc.select_clip_region (region)
		end

	set_tile (a_pixmap: EV_PIXMAP) is
			-- Set tile used to fill figures.
			-- Set to Void to use `background_color' to fill.
		do
			--| FIXME DO net set reference but copy.
			tile := a_pixmap
			reset_brush
		end

	remove_tile is
			-- Do not apply a tile when filling.
		do
			tile := Void
			internal_initialized_brush := False
			reset_brush
		end

	enable_dashed_line_style is
			-- Draw lines dashed.
		do
			dashed_line_style := True
			internal_initialized_pen := False
			reset_pen
		end

	disable_dashed_line_style is
			-- Draw lines solid.
		do
			dashed_line_style := False
			internal_initialized_pen := False
			reset_pen
		end

	set_font (a_font: EV_FONT) is
			-- Set `font' to `a_font'.
		local
			font_imp: EV_FONT_IMP
		do
			internal_font := a_font
			font_imp ?= internal_font.implementation
			if dc.font_selected then
				dc.unselect_font
			end
			dc.select_font (font_imp.wel_font)
		end

feature -- Clearing and drawing operations

	clear is
			-- Erase `Current' with `background_color'.
		do
			clear_rectangle (0, 0, width + 1, height + 1)
		end

	clear_rectangle (x1, y1, x2, y2: INTEGER) is
			-- Erase rectangle (`x1, `y1) - (`x2', `y2') with `background_color'.
		local
			a_rect: WEL_RECT
		do
			create a_rect.make (x1, y1, x2, y2)
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
		end

	draw_text (x, y: INTEGER; a_text: STRING) is
			-- Draw `a_text' at (`x', `y') using `font'.
		do
			dc.text_out (x, y, a_text)
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		do
			if not internal_initialized_pen then
				reset_pen
			end
			dc.move_to (x1, y1)
			dc.line_to (x2, y2)
		end

	draw_straight_line (x1, y1, x2, y2: INTEGER) is
			-- Draw infinite straight line through (`x1', 'y1') and (`x2', 'y2').
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
		end

	draw_arc (x, y, a_vertical_radius, a_horizontal_radius: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- Angles are measured in radians.
		local
			left, top, right, bottom: INTEGER
			x_start_arc, y_start_arc, x_end_arc, y_end_arc: INTEGER
		do
			left := x - a_horizontal_radius
			right := x + a_horizontal_radius
			top := y - a_vertical_radius
			bottom := y + a_vertical_radius
			x_start_arc := x + (a_horizontal_radius * cosine (a_start_angle)).rounded
			y_start_arc := y - (a_vertical_radius * sine (a_start_angle)).rounded
			x_end_arc := x + (a_horizontal_radius * cosine ((a_start_angle + an_aperture))).rounded
			y_end_arc := y - (a_vertical_radius * sine ((a_start_angle + an_aperture))).rounded

			if not internal_initialized_pen then
				reset_pen
			end
			dc.arc (left, top, right, bottom, x_start_arc,
				y_start_arc, x_end_arc, y_end_arc)
		end

	draw_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' with upper-left corner on (`x', `y').
		local
			pix_imp: EV_PIXMAP_IMP
		do
			pix_imp ?= a_pixmap.implementation
			dc.bit_blt (x, y, pix_imp.width, pix_imp.height, 
				pix_imp.bitmap_dc, 0, 0, Srccopy)
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
			reset_brush
		end

	draw_ellipse (x, y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Draw an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
		do
			remove_brush
			if not internal_initialized_pen then
				reset_pen
			end
			dc.ellipse (x - a_horizontal_radius, y - a_vertical_radius,
				x + a_vertical_radius, y + a_vertical_radius)
			reset_brush
		end

	draw_polyline (points: ARRAY [EV_COORDINATES]; is_closed: BOOLEAN) is
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		local
			flat_points: ARRAY [INTEGER]
			flat_index: INTEGER
			i: INTEGER
		do
			if is_closed then
				create flat_points.make (1, 2 * points.count + 2)
			else
				!! flat_points.make (1, 2 * points.count)
			end
			flat_index := 1
			from
				i := points.lower
			until
				i > points.upper
			loop
				flat_points.put ((points.item (i)).x, flat_index)
				flat_index := flat_index + 1
				flat_points.put ((points.item (i)).y, flat_index)
				i := i + 1
				flat_index := flat_index + 1
			end
			if is_closed then
				i := points.lower
				flat_points.put ((points.item (i)).x, flat_index)
				flat_index := flat_index + 1
				flat_points.put ((points.item (i)).y, flat_index)
			end

			if not internal_initialized_pen then
				reset_pen
			end
			dc.polyline (flat_points)
		end

	draw_pie_slice (x, y, a_vertical_radius, a_horizontal_radius: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians.
		local
			left, top, right, bottom: INTEGER
			x_start_arc, y_start_arc, x_end_arc, y_end_arc: INTEGER
			null_brush: WEL_NULL_BRUSH
		do
			left := x - a_horizontal_radius
			right := x + a_horizontal_radius
			top := y - a_vertical_radius
			bottom := y + a_vertical_radius
			x_start_arc := x + (a_horizontal_radius * cosine (a_start_angle)).rounded
			y_start_arc := y - (a_vertical_radius * sine (a_start_angle)).rounded
			x_end_arc := x + (a_horizontal_radius * cosine ((a_start_angle + an_aperture))).rounded
			y_end_arc := y - (a_vertical_radius * sine ((a_start_angle + an_aperture))).rounded
			remove_brush
			if not internal_initialized_pen then
				reset_pen
			end
			dc.pie (left, top, right, bottom, x_start_arc,
				y_start_arc, x_end_arc, y_end_arc)
			reset_brush
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
			dc.rectangle (x, y, x + a_width, y + a_height)
			reset_pen
		end 

	fill_ellipse (x, y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Draw an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Fill with `background_color'.
		do
			remove_pen
			if not internal_initialized_brush then
				reset_brush
			end
			dc.ellipse (x - a_horizontal_radius, y - a_vertical_radius,
				x + a_vertical_radius, y + a_vertical_radius)
			reset_pen
		end

	fill_polygon (points: ARRAY [EV_COORDINATES]) is
			-- Draw line segments between subsequent points in `points'.
			-- Fill all enclosed area's with `foreground_color'.
		local
			flat_points: ARRAY [INTEGER]
			i, flat_i: INTEGER
		do
			!! flat_points.make (1, 2 * points.count)
			flat_i := 1
			from
				i := points.lower
			until
				i > points.upper
			loop
				flat_points.put ((points.item (i)).x, flat_i)
				flat_i := flat_i + 1
				flat_points.put ((points.item (i)).y, flat_i)
				flat_i := flat_i + 1
				i := i + 1
			end
			remove_pen
			if not internal_initialized_brush then
				reset_brush
			end
			dc.polygon (flat_points)
			reset_pen
		end

	fill_pie_slice (x, y, a_vertical_radius, a_horizontal_radius: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians.
		local
			left, top, right, bottom: INTEGER
			x_start_arc, y_start_arc, x_end_arc, y_end_arc: INTEGER
		do
			left := x - a_horizontal_radius
			right := x + a_horizontal_radius
			top := y - a_vertical_radius
			bottom := y + a_vertical_radius
			x_start_arc := x + (a_horizontal_radius * cosine (a_start_angle)).rounded
			y_start_arc := y - (a_vertical_radius * sine (a_start_angle)).rounded
			x_end_arc := x + (a_horizontal_radius * cosine ((a_start_angle + an_aperture))).rounded
			y_end_arc := y - (a_vertical_radius * sine ((a_start_angle + an_aperture))).rounded
			remove_pen
			if not internal_initialized_brush then
				reset_brush
			end
			dc.pie (left, top, right, bottom, x_start_arc,
				y_start_arc, x_end_arc, y_end_arc)
			reset_pen
		end

feature {NONE} -- Implementation

	wel_drawing_mode: INTEGER
			-- The WEL equivalent for the Ev_drawing_mode_* selected.

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
			if not internal_initialized_background_brush then
				internal_background_brush := allocated_brushes.get(Void, wel_bg_color)
				internal_initialized_background_brush := True
			end

			Result := internal_background_brush
		end

	set_background_brush is
			-- Set background-brush. For clear-operations.
		do
			dc.select_brush (our_background_brush)
		end

	reset_brush is
			-- Restore brush to tile or color.
		local
			brush: WEL_BRUSH
			pix_imp: EV_PIXMAP_IMP
		do
			if not internal_initialized_brush then
				if tile /= Void then
					pix_imp ?= tile.implementation
					internal_brush := allocated_brushes.get(pix_imp.bitmap, Void)
				else
					internal_brush := allocated_brushes.get(Void, wel_fg_color)
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
					if dashed_line_style then
						dmode := Ps_dot
					else
						dmode := Ps_solid
					end
					internal_pen := allocated_pens.get (dmode, line_width, wel_fg_color)
					internal_initialized_pen := True
				end

				dc.select_pen (internal_pen)
			end
		end

	remove_pen is
			-- Draw without outline.
		local
			pen: WEL_PEN
			log_pen: WEL_LOG_PEN
		do
			if dc.pen_selected then
				dc.unselect_pen
			end
			dc.select_pen (empty_pen)
		end

	remove_brush is
			-- Draw without filling.
		local
			brush: WEL_BRUSH
			log_brush: WEL_LOG_BRUSH
		do
			if dc.brush_selected then
				dc.unselect_brush
			end
			dc.select_brush (empty_brush)
		end


feature {EV_ANY_I} -- Implementation

	interface: EV_DRAWABLE

feature {EV_DRAWABLE_IMP} -- Internal datas.

	internal_font: EV_FONT
			-- Font used to draw text.

	internal_background_brush: WEL_BRUSH
			-- Buffered background brush. Created in order to
			-- avoid multiple WEL_BRUSHes creation.

	internal_brush: WEL_BRUSH
			-- Buffered current brush. Created in order to
			-- avoid multiple WEL_BRUSHes creation.

	internal_pen: WEL_PEN
			-- Buffered current pen. Created in order to
			-- avoid multiple WEL_BRUSHes creation.

	internal_initialized_pen: BOOLEAN
			-- Is `internal_pen' valid? (can be invalidated if
			-- the user change the foreground color, the width, ...)

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

	allocated_pens: EV_GDI_ALLOCATED_PENS is
		once
			create Result
		end

	allocated_brushes: EV_GDI_ALLOCATED_BRUSHES is
		once
			create Result
		end

end -- class EV_DRAWABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.22  2000/03/14 19:41:20  brendel
--| Replaced R2_notcopypen with R2_not.
--|
--| Revision 1.21  2000/02/24 05:05:19  pichery
--| Efficiency improvement. `set_font' do not copy the content of the font
--| passed in parameter anymore. Now we do a direct assignment.
--| The feature `font' now return a clone of our internal font. So the user
--| is still not able to change the aspect of the font without using `set_font'.
--|
--| Revision 1.20  2000/02/20 20:29:44  pichery
--| created a factory that build WEL objects (pens & brushes). This factory
--| keeps created objects into an hashtable in order to avoid multiple object
--| creation for the same pen or brush.
--|
--| Revision 1.19  2000/02/19 20:24:44  brendel
--| Updated copyright to 1986-2000.
--|
--| Revision 1.18  2000/02/19 06:22:06  oconnor
--| released
--|
--| Revision 1.17  2000/02/16 18:06:57  pichery
--| Cosmetics: renammed feature `clear_rect' into `clear_rectangle'.
--|
--| Revision 1.14.6.24  2000/01/27 19:30:12  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.14.6.23  2000/01/25 23:32:07  brendel
--| Removed _enum from drawing mode constants.
--|
--| Revision 1.14.6.22  2000/01/24 23:54:20  oconnor
--| renamed EV_CLIP -> EV_RECTANGLE
--|
--| Revision 1.14.6.21  2000/01/21 23:16:01  brendel
--| Clean-up.
--|
--| Revision 1.14.6.20  2000/01/21 00:44:39  brendel
--| Fixed bug in `clear'.
--|
--| Revision 1.14.6.19  2000/01/20 23:26:53  brendel
--| Fixed bug in set_clip_area.
--|
--| Revision 1.14.6.18  2000/01/20 22:25:54  brendel
--| Implemented remove_tile.
--| Clean-up.
--|
--| Revision 1.14.6.17  2000/01/20 21:48:44  brendel
--| Added remove_tile and remove_clip_area.
--| Implemented remove_clip_area.
--|
--| Revision 1.14.6.16  2000/01/20 21:27:09  brendel
--| Implemented set_tile.
--|
--| Revision 1.14.6.15  2000/01/20 19:00:14  brendel
--| Implemented clip_area.
--|
--| Revision 1.14.6.14  2000/01/20 17:49:20  king
--| Added features update_brush and update_pen.
--|
--| Revision 1.14.6.13  2000/01/20 01:51:43  king
--| Removed useless features.
--| Implemented dashed line.
--|
--| Revision 1.14.6.12  2000/01/19 17:56:28  king
--| Changed to comply with EV_DRAWABLE.
--|
--| Revision 1.14.6.11  2000/01/19 01:46:00  king
--| Fixed bug in ellipse.
--| Improved implementation.
--| No outline for filled figures.
--|
--| Revision 1.14.6.10  2000/01/18 01:30:33  king
--| Removed a lot of commented out stuff.
--| Changed color imp.
--|
--| Revision 1.14.6.9  2000/01/11 00:51:31  king
--| Added and fixed font feature.
--| Changed all occ of 'y' with `y'.
--|
--| Revision 1.14.6.8  1999/12/30 18:38:34  king
--| Corrected insufficiently copied/pasted code for pie-slice.
--|
--| Revision 1.14.6.7  1999/12/17 17:19:44  rogers
--| Altered to fit in with the review branch. Previous commital would not compile at all, so this work attemopts to fix it.
--|
--| Revision 1.14.6.6  1999/12/09 18:16:34  brendel
--| Improved `draw_straight_line'.
--| Accidentally messed up draw_any_arc. Not needed anymore anyway.
--| Changed drawing-mode interaction. Internally uses `wel_drawing_mode' now.
--|
--| Revision 1.14.6.5  1999/12/09 16:50:26  brendel
--| Applied changes to EV_DRAWABLE. introduced `wel_drawing_mode' that is
--| set and read by (set_)drawing_mode.
--|
--| Revision 1.14.6.4  1999/12/08 19:51:07  brendel
--| Changed to comply with new EV_DRAWABLE_I.
--| features are not yet implemented.
--|
--| Revision 1.14.6.3  1999/12/08 01:20:44  brendel
--| Changed to comply with new EV_DRAWABLE_I.
--| Simplified , so more efficient drawing primitives.
--| draw_any_rectangle and draw_any_arc are not used at this point, but
--| might be useful in the future.
--| Now inherits from EV_FONTABLE_IMP, so that needs taking a look at.
--|
--| Revision 1.14.6.2  1999/12/07 23:40:33  rogers
--| Alerations to fit in with the new ii.
--|
--| Revision 1.14.6.1  1999/11/24 17:30:19  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.14.2.3  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
