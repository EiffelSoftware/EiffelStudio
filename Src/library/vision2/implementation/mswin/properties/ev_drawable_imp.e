--| FIXME Not for release
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
			create font
			create foreground_color.make_with_rgb (0, 0, 0)
			set_foreground_color (foreground_color)
			create background_color.make_with_rgb (1, 1, 1)
			set_background_color (background_color)
			dc.set_background_opaque
			dc.set_background_transparent
			dc.set_text_alignment (Ta_baseline)

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
			elseif wel_drawing_mode = R2_notcopypen then
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

	font: EV_FONT
			-- Character appearance.

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
			background_color.copy (a_color)
			if background_brush /= Void then
				background_brush.delete
			end
			create background_brush.make_solid (wel_bg_color)
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		do
			foreground_color.copy (a_color)
			dc.set_text_color (wel_fg_color)
			reset_pen
			reset_brush
		end

	set_line_width (a_width: INTEGER) is
			-- Assign `a_width' to `line_width'.
		do
			line_width := a_width
			reset_pen
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
				wel_drawing_mode := R2_notcopypen
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
			reset_brush
		end

	enable_dashed_line_style is
			-- Draw lines dashed.
		do
			dashed_line_style := True
			reset_pen
		end

	disable_dashed_line_style is
			-- Draw lines solid.
		do
			dashed_line_style := False
			reset_pen
		end

	set_font (a_font: EV_FONT) is
			-- Set `font' to `a_font'.
		local
			font_imp: EV_FONT_IMP
		do
			font.copy (a_font)
			font_imp ?= font.implementation
			dc.select_font (font_imp.wel_font)
		end

feature -- Clearing operations

	clear is
			-- Erase `Current' with `background_color'.
		do
			clear_rect (0, 0, width + 1, height + 1)
		end

	clear_rect (x1, y1, x2, y2: INTEGER) is
			-- Erase rectangle (`x1, `y1) - (`x2', `y2') with `background_color'.
		do
			remove_pen
			set_background_brush
			dc.rectangle (x1, y1, x2, y2)
			reset_brush
			reset_pen
		end

feature -- Drawing operations

	draw_point (x, y: INTEGER) is
			-- Draw point at (`x', `y').
		do
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
			dc.rectangle (x, y, x + a_width, y + a_height)
			reset_brush
		end

	draw_ellipse (x, y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Draw an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
		do
			remove_brush
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
			dc.pie (left, top, right, bottom, x_start_arc,
				y_start_arc, x_end_arc, y_end_arc)
			reset_brush
		end

feature -- Filling operations

	fill_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'. Fill with `background_color'.
		do
			remove_pen
			dc.rectangle (x, y, x + a_width, y + a_height)
			reset_pen
		end 

	fill_ellipse (x, y, a_vertical_radius, a_horizontal_radius: INTEGER) is
			-- Draw an ellipse centered on (`x', `y') with
			-- size `a_vertical_radius' and `a_horizontal_radius'.
			-- Fill with `background_color'.
		do
			remove_pen
			dc.ellipse (x - a_horizontal_radius, y - a_vertical_radius,
				x + a_vertical_radius, y + a_vertical_radius)
			reset_pen
		end

	fill_polygon (points: ARRAY [EV_COORDINATES]) is
			-- Draw line segments between subsequent points in `points'.
			-- Fill all enclosed area's with `background_color'.
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
			dc.pie (left, top, right, bottom, x_start_arc,
				y_start_arc, x_end_arc, y_end_arc)
			reset_pen
		end

feature {NONE} -- Implementation

	wel_drawing_mode: INTEGER
			-- The WEL equivalent for the Ev_drawing_mode_* selected.

	wel_bg_color: WEL_COLOR_REF is
			-- Get implementation object of `background_color'.
		do
			Result ?= background_color.implementation
		ensure
			not_void: Result /= Void
		end

	wel_fg_color: WEL_COLOR_REF is
			-- Get implementation object of `foreground_color'.
		do
			Result ?= foreground_color.implementation
		ensure
			not_void: Result /= Void
		end

	background_brush: WEL_BRUSH
			-- Current window background color used to refresh the window when
			-- requested by the Wm_erasebkgnd windows message.

	set_background_brush is
			-- Set background-brush. For clear-operations.
		do
			dc.unselect_brush
			dc.select_brush (background_brush)
		end

	pen: WEL_PEN

	brush: WEL_BRUSH

	reset_brush is
			-- Restore brush to tile or color.
		local
			pix_imp: EV_PIXMAP_IMP
		do
			if brush /= Void then
				dc.unselect_brush
				brush.delete
			end
			if tile /= Void then
				pix_imp ?= tile.implementation
				create brush.make_by_pattern (pix_imp.bitmap)
			else
				create brush.make_solid (wel_fg_color)
			end				
			dc.select_brush (brush)
		end

	reset_pen is
			-- Restore pen to correct line width and color
		local
			dmode: INTEGER
		do
			if line_width = 0 then
				remove_pen
			else
				if dashed_line_style then
					dmode := Ps_dot
				else
					dmode := Ps_solid
				end
				if pen /= Void then
					dc.unselect_pen
					pen.delete
				end
				create pen.make (dmode, line_width, wel_fg_color)
				dc.select_pen (pen)
			end
		end

	null_pen: WEL_PEN is
			-- Pen that appears as if no pen is used.
		local
			log_pen: WEL_LOG_PEN
		once
			create log_pen.make (Ps_null, 1, wel_fg_color)
			create Result.make_indirect (log_pen)
		end			

	remove_pen is
			-- Draw without outline.
		do
			dc.select_pen (null_pen)
		end

	null_brush: WEL_BRUSH is
			-- Brush that appears as if no brush is used.
		local
			log_brush: WEL_LOG_BRUSH
		do
			create log_brush.make (Bs_null, wel_fg_color, Hs_horizontal)
			create Result.make_indirect (log_brush)
		end			

	remove_brush is
			-- Draw without filling.
		do
			dc.select_brush (null_brush)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_DRAWABLE

end -- class EV_DRAWABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
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
--| Revision 1.16  2000/02/15 17:41:13  brendel
--| Changed to avoid any memory leak. Changes:
--|  - For `reset_pen' and `reset_brush', once-functions are used to create
--|    resp. `null_pen' and `null_brush'.
--|  - In `reset_pen' and `reset_brush', a reference to the old pen/brush
--|    object is stored so that it can be deleted when it has to be recreated.
--|  - Feature `background_brush' is now an attribute that is reinstantiated
--|    every time the background color is changed.
--|  - The leak caused by font turned out to be a bug in WEL and should be
--|    fixed now.
--|
--| Revision 1.15  2000/02/14 11:40:40  oconnor
--| merged changes from prerelease_20000214
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
