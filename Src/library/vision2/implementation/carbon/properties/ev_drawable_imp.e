indexing
	description: "EiffelVision drawable. Carbon implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "figures, primitives, drawing, line, point, ellipse"
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

	DISPOSABLE
		undefine
			copy,
			default_create
		end

	PLATFORM
		undefine
			copy,
			default_create
		end

--	EV_CARBON_EVENTABLE
--		redefine
--			on_event
--		end

	MATH_CONST

	HIVIEW_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CONTROLDEFINITIONS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CONTROLS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CARBONEVENTS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CARBONEVENTSCORE_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CGCONTEXT_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CGGEOMETRY_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CGPATH_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CGAFFINETRANSFORM_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end


feature {NONE} -- Initialization

	init_default_values is
			-- Set default values. Call during initialization.
		local
			c_imp: EV_WIDGET_IMP
			target: POINTER
			ret: INTEGER
		do
			c_imp ?= current
			if c_imp /=void then
        		target := get_control_event_target_external(c_imp.c_object)
				ret := hiview_set_drawing_enabled_external (c_imp.c_object, 1)  --enable drawing
        		event_handler := c_imp.app_implementation.install_event_handler (c_imp.event_id, target, {carbonevents_anon_enums}.kEventClassControl, {carbonevents_anon_enums}.kEventControlDraw)
				ret := hiview_set_needs_display_external (c_imp.c_object, 1)
        	end
        	create internal_background_color.make_with_8_bit_rgb (50, 50, 50)
        	create internal_foreground_color.make_with_8_bit_rgb (50, 50, 50)
        	create to_draw.make
		end

feature {EV_DRAWABLE_IMP, EV_APPLICATION_IMP} -- Implementation

	event_handler: POINTER
			-- Points to the installed drawing event handler. Is used to remove after drawing.

	pix_to_draw: EV_PIXMAP_IMP
			-- Pixmap which should be drawn by event

	new_x: INTEGER
			-- Information for drawing event

	new_y: INTEGER
			-- Information for drawing event

	gc: POINTER
			-- Pointer to GdkGC struct.
			-- The graphics context applied to the primitives.
			-- Line style, width, colors, etc. are defined in here.

	gcvalues: POINTER
			-- Pointer to GdkGCValues struct.
			-- Is allocated during creation but has to be updated
			-- every time it is accessed.

	drawable: POINTER is
			-- Pointer to the GdkWindow of `c_object'.
		deferred
		end

	mask: POINTER is
			-- Pointer to the mask used by `Current'
		deferred
		end

	line_style: INTEGER
			-- Dash-style used when drawing lines.

	cap_style: INTEGER is
			-- Style used for drawing end of lines.
		do
		end

	join_style: INTEGER is
			-- Way in which lines are joined together.				
		do
		end

	gc_clip_area: EV_RECTANGLE
			-- Clip area currently used by `gc'.

	height: INTEGER is
			-- Needed by `draw_straight_line'.
		deferred
		end

	width: INTEGER is
			-- Needed by `draw_straight_line'.
		deferred
		end

feature -- Access

	font: EV_FONT is
			-- Font used for drawing text.
		do
			if internal_font_imp /= Void then
				Result := internal_font_imp.interface.twin
			else
				create Result
			end
		end

	foreground_color: EV_COLOR is
			-- Color used to draw primitives.
		do
			Result := internal_foreground_color
		end

	background_color: EV_COLOR is
			-- Color used for erasing of canvas.
			-- Default: white.
		do
			Result := internal_background_color
		end

	line_width: INTEGER is
			-- Line thickness.
		do
			Result := internal_line_width
		end

	drawing_mode: INTEGER is
			-- Logical operation on pixels when drawing.
		do
		end

	clip_area: EV_RECTANGLE is
			-- Clip area used to clip drawing.
			-- If set to Void, no clipping is applied.
		do
		end

	tile: EV_PIXMAP
			-- Pixmap that is used to fill instead of background_color.
			-- If set to Void, `background_color' is used to fill.

	dashed_line_style: BOOLEAN is
			-- Are lines drawn dashed?
		do
			Result := internal_dashed_line_style
		end

feature -- Element change

	set_font (a_font: EV_FONT) is
			-- Set `font' to `a_font'.
		do
			if internal_font_imp /= a_font.implementation then
				internal_font_imp ?= a_font.implementation
			end
		end

	set_background_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `background_color'.
		do
			internal_background_color := a_color
		end

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		do
			internal_foreground_color := a_color
		end

	set_line_width (a_width: INTEGER) is
			-- Assign `a_width' to `line_width'.
		do
			internal_line_width := a_width
		end

	set_drawing_mode (a_mode: INTEGER) is
			-- Set drawing mode to `a_mode'.
		do
		end

	set_clip_area (an_area: EV_RECTANGLE) is
			-- Set an area to clip to.
		do
		end

	set_clip_region (a_region: EV_REGION) is
			-- Set a region to clip to.
		do
		end

	remove_clipping is
			-- Do not apply any clipping.
		do
		end

	set_tile (a_pixmap: EV_PIXMAP) is
			-- Set tile used to fill figures.
			-- Set to Void to use `background_color' to fill.
		do
		end

	remove_tile is
			-- Do not apply a tile when filling.
		do
		end

	enable_dashed_line_style is
			-- Draw lines dashed.
		do
			internal_dashed_line_style := true
		end

	disable_dashed_line_style is
			-- Draw lines solid.
		do
			internal_dashed_line_style := false
		end

feature -- Clearing operations

	clear is
			-- Erase `Current' with `background_color'.
		do
			internal_clear := true
			prepare_drawing
		end

	clear_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Erase rectangle specified with `background_color'.
		do
		end

feature -- Drawing operations

	draw_point (x, y: INTEGER) is
			-- Draw point at (`x', `y').
		local
			a_size: INTEGER
		do
			a_size := line_width
			set_line_width (2)
			draw_segment (x-1, y, x+1, y)
			set_line_width (a_size)
		end

	draw_text (x, y: INTEGER; a_text: STRING_GENERAL) is
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
		local
			a_drawer: EV_CARBON_DRAWING
		do
			create a_drawer
			a_drawer.set_text (x, y, false, foreground_color, font, 0, a_text)
			to_draw.force (a_drawer)
			prepare_drawing
		end

	draw_rotated_text (x, y: INTEGER; angle: REAL; a_text: STRING_GENERAL) is
			-- Draw rotated text `a_text' with left of baseline at (`x', `y') using `font'.
			-- Rotation is number of radians counter-clockwise from horizontal plane.
		do
		end

	draw_ellipsed_text (x, y: INTEGER; a_text: STRING_GENERAL; clipping_width: INTEGER) is
			-- Draw `a_text' with left of baseline at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		do
		end

	draw_ellipsed_text_top_left (x, y: INTEGER; a_text: STRING_GENERAL; clipping_width: INTEGER) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
			-- Text is clipped to `clipping_width' in pixels and ellipses are displayed
			-- to show truncated characters if any.
		do
		end

	draw_text_top_left (x, y: INTEGER; a_text: STRING_GENERAL) is
			-- Draw `a_text' with top left corner at (`x', `y') using `font'.
		do
		end

	draw_text_internal (x, y: INTEGER; a_text: STRING_GENERAL; draw_from_baseline: BOOLEAN; a_width: INTEGER; a_angle: REAL) is
			-- Draw `a_text' at (`x', `y') using `font'.
		do
		end

	draw_segment (x1, y1, x2, y2: INTEGER) is
			-- Draw line segment from (`x1', 'y1') to (`x2', 'y2').
		local
			a_drawer: EV_CARBON_DRAWING
		do
			create a_drawer
			a_drawer.set_line (x1, y1, x2, y2, internal_line_width, false, internal_dashed_line_style, foreground_color)
			to_draw.force (a_drawer)
			prepare_drawing
		end

	draw_arc (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- Angles are measured in radians.
		do

		end

	draw_sub_pixel_buffer (a_x, a_y: INTEGER; a_pixel_buffer: EV_PIXEL_BUFFER; area: EV_RECTANGLE) is
			-- Draw `area' of `a_pixel_buffer' with upper-left corner on (`a_x', `a_y').
		do
		end

	draw_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP) is
			-- Draw `a_pixmap' with upper-left corner on (`x', `y').
		local
			a_imp: EV_PIXMAP_IMP
			a_drawer: EV_CARBON_DRAWING
		do
			create a_drawer
			a_imp ?= a_pixmap.implementation
			if a_imp /= void then
				a_drawer.set_pixmap (x,y,a_imp)
			end
			to_draw.force (a_drawer)
			prepare_drawing
		end

	prepare_drawing is
		local
			ret : INTEGER
			c_imp: EV_WIDGET_IMP
			target, null: POINTER
			event: OPAQUE_EVENT_REF_STRUCT
		do
        	c_imp ?= current
        	if c_imp /=void then
        --		target := get_control_event_target_external(c_imp.c_object)
		--		ret := hiview_set_drawing_enabled_external (c_imp.c_object, 1)  --enable drawing
        --		event_handler := c_imp.app_implementation.install_event_handler (event_id, target, {carbonevents_anon_enums}.kEventClassControl, {carbonevents_anon_enums}.kEventControlDraw)
				ret := hiview_set_needs_display_external (c_imp.c_object, 1)
        	end
        end

    frozen kEventAttributeUserEvent: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kEventAttributeUserEvent"
	end

	frozen kCGEncodingMacRoman: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kCGEncodingMacRoman"
	end

	frozen kCGTextFillStroke: INTEGER is
	external
		"C inline use <Carbon/Carbon.h>"
	alias
		"kCGTextFillStroke"
	end



     draw (a_inevent: POINTER) is
       		-- executet by the eventhandler to draw into context
        local
        	ret: INTEGER
        	context: CGCONTEXT_STRUCT
        	context_ptr, handler_ptr: POINTER
        	null: POINTER
        	point: CGPOINT_STRUCT
        	size: CGSIZE_STRUCT
			rect: CGRECT_STRUCT
			c_imp: EV_WIDGET_IMP
			font_str: C_STRING
			transform: CGAFFINE_TRANSFORM_STRUCT
			o_test: EV_PIXMAP_IMP
        do

			c_imp ?= current
        	--if event_handler /= null then
        		--handler_ptr.set_item (event_handler.item)

				--ret := remove_event_handler_external (event_handler)
				--ret := hiview_set_drawing_enabled_external (c_imp.c_object, 0)  --disable drawing to pixmap

	        	create context.make_new_unshared
	        	context_ptr.set_item (context.item)
	        	ret := get_event_parameter_external (a_inevent, {carbonevents_anon_enums}.kEventParamCGContextRef,  {carbonevents_anon_enums}.typeCGContextRef, null, 4, null, $context_ptr)

				o_test ?= current
				if o_test = void then
				--if current is not of type Pixmap, we need to translate the coordinates
					cgcontext_translate_ctm_external (context_ptr, 0, height)
					cgcontext_scale_ctm_external (context_ptr, 1.0, -1.0)
				end


				if internal_clear then
					internal_clear := false
					create to_draw.make
				end


				from
					to_draw.start
				until
					to_draw.off
				loop


				--	cgcontext_begin_path_external (context_ptr)
				--	cgcontext_close_path_external (context_ptr)

					if to_draw.item.internal_color /= void then
						--set color of path
						if to_draw.item.internal_filled then
							cgcontext_set_rgbfill_color_external (context_ptr, to_draw.item.internal_color.red, to_draw.item.internal_color.green, to_draw.item.internal_color.blue, to_draw.item.internal_color.lightness )
						else
							cgcontext_set_rgbstroke_color_external (context_ptr, to_draw.item.internal_color.red, to_draw.item.internal_color.green, to_draw.item.internal_color.blue, to_draw.item.internal_color.lightness )
						end

					end



					if to_draw.item.internal_rectangle then
						--draw a rectangle
						cgcontext_move_to_point_external (context_ptr, to_draw.item.internal_x1, to_draw.item.internal_y1)
						cgcontext_add_line_to_point_external (context_ptr, to_draw.item.internal_x1 , to_draw.item.internal_y1 + to_draw.item.internal_draw_height)
						cgcontext_add_line_to_point_external (context_ptr, to_draw.item.internal_x1 + to_draw.item.internal_draw_width , to_draw.item.internal_y1 + to_draw.item.internal_draw_height)
						cgcontext_add_line_to_point_external (context_ptr, to_draw.item.internal_x1 + to_draw.item.internal_draw_width , to_draw.item.internal_y1)
						cgcontext_add_line_to_point_external (context_ptr, to_draw.item.internal_x1 , to_draw.item.internal_y1)
					end

		        	if  to_draw.item.internal_line then
						-- draw line
						cgcontext_move_to_point_external (context_ptr, to_draw.item.internal_x1.to_real, to_draw.item.internal_y1.to_real)
						cgcontext_add_line_to_point_external (context_ptr, to_draw.item.internal_x2.to_real , to_draw.item.internal_y2.to_real)
		        	end

		        	if to_draw.item.internal_elipse then
		        	--draw an ellipse
						create rect.make_new_unshared
						create point.make_shared (rect.origin)
						create size.make_shared (rect.size)
						point.set_x (to_draw.item.internal_x1)
						point.set_y (to_draw.item.internal_y1)
						size.set_height (to_draw.item.internal_draw_height)
						size.set_width (to_draw.item.internal_draw_width)
						cgcontext_add_ellipse_in_rect_external (context_ptr, rect.item)
		        	end



					if to_draw.item.internal_filled then
						cgcontext_fill_path_external (context_ptr)
					else
						cgcontext_stroke_path_external (context_ptr)
					end


		        	if  to_draw.item.pix_to_draw /= void then
		       			--draw_pixmap case
		           			create rect.make_new_unshared
							create point.make_new_shared
							create size.make_new_shared
							rect.set_origin (point.item)


							ret := hiview_get_frame_external (c_imp.c_object, rect.item)

							point.set_x (point.x+to_draw.item.internal_x1)
							point.set_y (point.y + to_draw.item.internal_y1)

							size.set_height (to_draw.item.pix_to_draw.height)
							size.set_width (to_draw.item.pix_to_draw.width)

							size.set_height (50)
							size.set_width (50)
							rect.set_size (size.item)

							cgcontext_draw_image_external (context_ptr, rect.item, to_draw.item.pix_to_draw.drawable)
				        	--ret := hiview_draw_cgimage_external (context_ptr, rect.item, pix_to_draw.drawable)
		        	end

		        	if to_draw.item.internal_text then
		        		cgcontext_set_rgbfill_color_external (context_ptr, to_draw.item.internal_color.red, to_draw.item.internal_color.green, to_draw.item.internal_color.blue, to_draw.item.internal_color.lightness )

						if to_draw.item.internal_font /= void then
							create font_str.make (to_draw.item.internal_font.name)
							cgcontext_select_font_external (context_ptr, font_str.item, to_draw.item.internal_font.height, kCGEncodingMacRoman)
						else
							create font_str.make ("Times-Bold")
							cgcontext_select_font_external (context_ptr, font_str.item, 20, kCGEncodingMacRoman)
						end

						cgcontext_set_character_spacing_external (context_ptr, 10)

						cgcontext_set_text_drawing_mode_external (context_ptr, kCGTextFillStroke)

						cgcontext_show_text_at_point_external (context_ptr, to_draw.item.internal_x1.to_real, to_draw.item.internal_y1.to_real, to_draw.item.internal_string.item, to_draw.item.internal_string.count)

					end

		        	to_draw.forth

				end


	        --end
        end



	draw_full_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; x_src, y_src, src_width, src_height: INTEGER) is
		local
			a_imp: EV_PIXMAP_IMP
		do

		end

	sub_pixmap (area: EV_RECTANGLE): EV_PIXMAP is
			-- Pixmap region of `Current' represented by rectangle `area'
		do
			-- TODO
			create Result
		end

	draw_sub_pixmap (x, y: INTEGER; a_pixmap: EV_PIXMAP; area: EV_RECTANGLE) is
			-- Draw `area' of `a_pixmap' with upper-left corner on (`x', `y').
		do
		end

	draw_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'.
		local
			a_drawer: EV_CARBON_DRAWING
		do
			create a_drawer
			a_drawer.set_rectangle (x, y, a_height, a_width, internal_line_width, false, internal_dashed_line_style, foreground_color)
			to_draw.force (a_drawer)

			prepare_drawing
		end

	draw_ellipse (x, y, a_width, a_height: INTEGER) is
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
		local
			a_drawer: EV_CARBON_DRAWING
		do
			create a_drawer
			a_drawer.set_elipse (x, y, a_height, a_width, internal_line_width, false, internal_dashed_line_style, foreground_color)
			to_draw.force (a_drawer)

			prepare_drawing
		end

	draw_polyline (points: ARRAY [EV_COORDINATE]; is_closed: BOOLEAN) is
			-- Draw line segments between subsequent points in
			-- `points'. If `is_closed' draw line segment between first
			-- and last point in `points'.
		local
			i: INTEGER
		do
			from
				i:=2
			until
				i > points.count
			loop
				draw_segment (points.item(i-1).x, points.item(i-1).y, points.item(i).x, points.item(i).y)
				if is_closed then
			 		draw_segment (points.item(1).x, points.item(1).y, points.item(points.count).x, points.item(points.count).y)
				end
				i := i + 1
			end

		end

	draw_pie_slice (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians
		do
		end

feature -- filling operations

	fill_rectangle (x, y, a_width, a_height: INTEGER) is
			-- Draw rectangle with upper-left corner on (`x', `y')
			-- with size `a_width' and `a_height'. Fill with `background_color'.
		local
			a_drawer: EV_CARBON_DRAWING
		do
			create a_drawer
			a_drawer.set_rectangle (x, y, a_height, a_width, internal_line_width, true, internal_dashed_line_style, background_color)
			to_draw.force (a_drawer)

			prepare_drawing
		end

	fill_ellipse (x, y, a_width, a_height: INTEGER) is
			-- Draw an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Fill with `background_color'.
				local
			a_drawer: EV_CARBON_DRAWING
		do
			create a_drawer
			a_drawer.set_elipse (x, y, a_height, a_width, internal_line_width, true, internal_dashed_line_style, background_color)
			to_draw.force (a_drawer)

			prepare_drawing
		end

	fill_polygon (points: ARRAY [EV_COORDINATE]) is
			-- Draw line segments between subsequent points in `points'.
			-- Fill all enclosed area's with `background_color'.
		do
		end

	fill_pie_slice (x, y, a_width, a_height: INTEGER; a_start_angle, an_aperture: REAL) is
			-- Draw a part of an ellipse bounded by top left (`x', `y') with
			-- size `a_width' and `a_height'.
			-- Start at `a_start_angle' and stop at `a_start_angle' + `an_aperture'.
			-- The arc is then closed by two segments through (`x', `y').
			-- Angles are measured in radians.
		do
		end

feature {NONE} -- Implemention

	coord_array_to_gdkpoint_array (pts: ARRAY [EV_COORDINATE]): ARRAY [INTEGER] is
			-- Low-level conversion.
		require
			pts_exists: pts /= Void
		do
		ensure
			Result_exists: Result /= Void
			same_size: pts.count = Result.count / 2
		end

feature {EV_ANY_I} -- Implementation

	pixbuf_from_drawable: POINTER is
			-- Return a GdkPixbuf object from the current Gdkpixbuf structure
		do
		end

	pixbuf_from_drawable_at_position (src_x, src_y, dest_x, dest_y, a_width, a_height: INTEGER): POINTER is
			-- Return a GdkPixbuf object from the current Gdkpixbuf structure
		do
		end

	pixbuf_from_drawable_with_size (a_width, a_height: INTEGER): POINTER is
			-- Return a GdkPixbuf object from the current Gdkpixbuf structure with dimensions `a_width' * `a_height'
		do
		end

feature {NONE} -- Implementation

	path: POINTER

	to_draw: LINKED_LIST [EV_CARBON_DRAWING]

	internal_clear: BOOLEAN

	internal_line_width: INTEGER

	internal_dashed_line_style: BOOLEAN

	draw_mask_on_pixbuf (a_pixbuf_ptr, a_mask_ptr: POINTER) is
		do
		end

	app_implementation: EV_APPLICATION_IMP is
			-- Return the instance of EV_APPLICATION_IMP.
		deferred
		end

	internal_foreground_color: EV_COLOR
			-- Color used to draw primitives.

	internal_background_color: EV_COLOR
			-- Color used for erasing of canvas.
			-- Default: white.

	flush is
			-- Force all queued expose events to be called.
		deferred
		end

	update_if_needed is
			-- Force update of `Current' if needed
		deferred
		end

	whole_circle: INTEGER is 23040
		-- Number of 1/64 th degrees in a full circle (360 * 64)

	radians_to_gdk_angle: INTEGER is 3667 --
			-- Multiply radian by this to get no of (1/64) degree segments.

	internal_font_imp: EV_FONT_IMP

	interface: EV_DRAWABLE

	set_dashes_pattern (a_gc, dash_pattern: POINTER) is
			-- Set the dashes pattern for gc `a_gc', `dash_pattern' is a pointer to a two count gint8[]] denoting the pattern.
		do
		end

indexing
	copyright:	"Copyright (c) 2006-2007, The Eiffel.Mac team"
end -- class EV_DRAWABLE_IMP

