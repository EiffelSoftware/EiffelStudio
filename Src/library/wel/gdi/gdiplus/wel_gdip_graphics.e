note
	description: "[
			Grapics functions in Gdi+.
			For more information, please see:
			MSDN Graphics Functions:					
			http://msdn.microsoft.com/en-us/library/ms534038(VS.85).aspx
		]"
	eis: "protocol=uri", "src=http://msdn.microsoft.com/en-us/library/ms534038(VS.85).aspx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_GRAPHICS

inherit
	WEL_GDIP_ANY
		redefine
			destroy_item
		end

create
	make_from_image,
	make_from_dc

feature {NONE} -- Initlization

	make_from_image (a_image: WEL_GDIP_IMAGE)
			-- Initlialize Current from `a_image'
		require
			not_void: a_image /= Void
			a_image: a_image.exists
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_get_image_graphics_context (gdi_plus_handle, a_image.item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	make_from_dc (a_dc: WEL_DC)
			-- Initlialize Current from `a_dc'
		require
			not_void: a_dc /= Void
			exists: a_dc.exists
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_create_from_hdc (gdi_plus_handle, a_dc.item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Command

	flush (a_intention: INTEGER)
			-- Flushes all pending graphics operations
		require
			valid: (create {WEL_GDIP_FLUSH_INTENTION}).is_valid (a_intention)
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_flush (gdi_plus_handle, item, a_intention, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	draw_line (a_pen: WEL_GDIP_PEN;  a_x_1, a_y_1, a_x_2, a_y_2: INTEGER)
			-- Draw a line
		require
			not_void: a_pen /= Void
			a_pen_exists: a_pen.exists
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_draw_line_i (gdi_plus_handle, item, a_pen.item, a_x_1, a_y_1, a_x_2, a_y_2, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	draw_ellipse (a_pen: WEL_GDIP_PEN; a_x, a_y, a_width, a_height: INTEGER)
			-- Draw a ellipse with the specified `a_x'/`a_y' and `a_width'/`a_height'
		require
			not_void: a_pen /= Void
			a_pen_exists: a_pen.exists
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_draw_ellipse_i (gdi_plus_handle, item, a_pen.item, a_x, a_y, a_width, a_height, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	draw_image (a_image: WEL_GDIP_IMAGE; a_dest_x, a_dest_y: INTEGER)
			-- Draw `a_image' at `a_dest_x' `a_dest_y'
		require
			not_void: a_image /= Void
			a_image_exists: a_image.exists
			exists: exists
		local
			l_dest_rect, l_src_rect: WEL_RECT
		do
			create l_dest_rect.make (a_dest_x, a_dest_y, a_dest_x + a_image.width, a_dest_y + a_image.height)
			create l_src_rect.make (0, 0, a_image.width, a_image.height)

			draw_image_with_dest_rect_src_rect (a_image, l_dest_rect, l_src_rect)

			l_dest_rect.dispose
			l_src_rect.dispose
		end

	draw_image_with_dest_rect_src_rect (a_image: WEL_GDIP_IMAGE; a_dest_rect, a_src_rect: WEL_RECT)
			-- Draw `a_image' at `a_dest_rect' from `a_src_dest'
		require
			not_void: a_image /= Void
			a_image_exists: a_image.exists
			not_void: a_dest_rect /= Void
			a_dest_rect_exists: a_dest_rect.exists
			not_void: a_src_rect /= Void
			a_src_rect_exists: a_src_rect.exists
			exists: exists
		do
			draw_image_with_src_rect_dest_rect_unit_attributes (a_image, a_dest_rect, a_src_rect, {WEL_GDIP_UNIT}.unitpixel, Void)
		end

	draw_image_with_src_rect_dest_rect_unit_attributes (a_image: WEL_GDIP_IMAGE; a_dest_rect, a_src_rect: WEL_RECT; a_unit: INTEGER; a_image_attributes: detachable WEL_GDIP_IMAGE_ATTRIBUTES)
			-- Draw `a_image' with arguments.
		require
			not_void: a_image /= Void
			a_image_exists: a_image.exists
			not_void: a_dest_rect /= Void
			a_dest_rect_exists: a_dest_rect.exists
			not_void: a_src_rect /= Void
			a_src_rect_exists: a_src_rect.exists
			valid: (create {WEL_GDIP_UNIT}).is_valid (a_unit)
			exists: exists
		local
			l_result: INTEGER
			l_null_pointer: POINTER
		do
			if a_image_attributes = Void then
				c_gdip_draw_image_rect_rect_i (gdi_plus_handle, item, a_image.item, a_dest_rect.x, a_dest_rect.y, a_dest_rect.width, a_dest_rect.height, a_src_rect.x, a_src_rect.y, a_src_rect.width, a_src_rect.height, a_unit, l_null_pointer, l_null_pointer, l_null_pointer, $l_result)
			else
				c_gdip_draw_image_rect_rect_i (gdi_plus_handle, item, a_image.item, a_dest_rect.x, a_dest_rect.y, a_dest_rect.width, a_dest_rect.height, a_src_rect.x, a_src_rect.y, a_src_rect.width, a_src_rect.height, a_unit, a_image_attributes.item, l_null_pointer, l_null_pointer, $l_result)
			end
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	draw_lines (pen: WEL_GDIP_PEN; coorinates: ARRAY [INTEGER_32])
			-- Draw a series of line segments that connect an array of specified coordinates `coorinates` with a pen `pen`.
		require
			pen_attached: attached pen
			pen_exists: pen.exists
			exists: exists
			coordinates_attached: attached coorinates
			coordinates_in_pairs: coorinates.count & 1 = 0
		local
			a: WEL_INTEGER_ARRAY
			r: INTEGER
		do
			create a.make (coorinates)
			c_gdip_draw_lines_i (gdi_plus_handle, item, pen.item, a.item, coorinates.count // 2, $r)
			a.dispose
		end

	draw_polygon (pen: WEL_GDIP_PEN; coorinates: ARRAY [INTEGER_32])
			-- Draw a polygon with a pen `pen` at specified coordinates `coorinates`.
		require
			pen_attached: attached pen
			pen_exists: pen.exists
			exists: exists
			coordinates_attached: attached coorinates
			coordinates_in_pairs: coorinates.count & 1 = 0
		local
			a: WEL_INTEGER_ARRAY
			r: INTEGER
		do
			create a.make (coorinates)
			c_gdip_draw_polygon_i (gdi_plus_handle, item, pen.item, a.item, coorinates.count // 2, $r)
			a.dispose
		end

	draw_rectangle (a_pen: WEL_GDIP_PEN; a_x, a_y, a_width, a_height: INTEGER)
			-- Draw a rectangle with the specified `a_x'/`a_y' and `a_width'/`a_height'
		require
			not_void: a_pen /= Void
			a_pen_exists: a_pen.exists
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_draw_rectangle_i (gdi_plus_handle, item, a_pen.item, a_x, a_y, a_width, a_height, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	draw_string (a_string: READABLE_STRING_GENERAL; a_font: WEL_GDIP_FONT; a_x, a_y: REAL)
			-- Draw `a_length' characters of `a_string' with `a_font' at `a_x',`a_y' position.
		require
			not_void: a_string /= Void
			not_void: a_font /= Void
			a_font_exists: a_font.exists
			valid: a_x >= 0 and a_y >= 0
			exists: exists
		local
			l_rect_f: WEL_GDIP_RECT_F
			l_format: WEL_GDIP_STRING_FORMAT
			l_brush: WEL_GDIP_BRUSH
			l_color: WEL_GDIP_COLOR
			l_system_color: WEL_SYSTEM_COLORS
			l_wel_color_ref: WEL_COLOR_REF
		do
			create l_rect_f.make_with_size (a_x, a_y, 0, 0)
			create l_format.make
			create l_system_color
			l_wel_color_ref := l_system_color.system_color_btntext
			create l_color.make_from_argb (255, l_wel_color_ref.red, l_wel_color_ref.green, l_wel_color_ref.blue)
			create l_brush.make_solid (l_color)
			draw_string_with_length_font_rect_format_brush (a_string, a_string.count, a_font, l_rect_f, l_format, l_brush)
		end

	draw_string_with_length_font_rect_format_brush (a_string: READABLE_STRING_GENERAL; a_length: INTEGER; a_font: WEL_GDIP_FONT; a_rect_f: WEL_GDIP_RECT_F; a_format: WEL_GDIP_STRING_FORMAT; a_brush: WEL_GDIP_BRUSH)
			-- Draw string with arguments.
		require
			not_void: a_string /= Void
			valid: a_length >= 0
			not_void: a_font /= Void
			a_font_exists: a_font.exists
			not_void: a_rect_f /= Void
			a_format_not_void: a_format /= Void
			a_format_exists: a_format.exists
			a_brush_not_void: a_brush /= Void
			a_brush_exists: a_brush.exists
			exists: exists
		local
			l_result: INTEGER
			l_wel_string: WEL_STRING
			l_font_item: POINTER
			l_rect_item: POINTER
			l_format_item: POINTER
			l_brush_item: POINTER
		do
			create l_wel_string.make_empty (a_length)
			l_wel_string.set_substring (a_string, 1, a_length)

			l_font_item := a_font.item
			l_rect_item := a_rect_f.item
			l_format_item := a_format.item
			l_brush_item := a_brush.item

			c_gdip_draw_string (gdi_plus_handle, item, l_wel_string.item, l_wel_string.count, l_font_item, l_rect_item, l_format_item, l_brush_item, $l_result)

			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	fill_ellipse (a_brush: WEL_GDIP_BRUSH; a_x, a_y, a_width, a_height: INTEGER)
			-- Fill a ellipse with the specified `a_x'/`a_y' and `a_width'/`a_height'
		require
			not_void: a_brush /= Void
			a_pen_exists: a_brush.exists
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_fill_ellipse_i (gdi_plus_handle, item, a_brush.item, a_x, a_y, a_width, a_height, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	fill_polygon (brush: WEL_GDIP_BRUSH; coorinates: ARRAY [INTEGER_32]; mode: INTEGER)
			-- Fill the interior of a polygon defined by an array of coordinates `coorinates` using a brush `brush` and fill mode `mode`.
		require
			brush_attached: attached brush
			brush_exists: brush.exists
			exists: exists
			coordinates_attached: attached coorinates
			coordinates_in_pairs: coorinates.count & 1 = 0
			is_mode_valid: {WEL_GDIP_FILL_MODE}.is_valid (mode)
		local
			a: WEL_INTEGER_ARRAY
			r: INTEGER
		do
			create a.make (coorinates)
			c_gdip_fill_polygon_i (gdi_plus_handle, item, brush.item, a.item, coorinates.count // 2, mode, $r)
			a.dispose
		end

	fill_rectangle (a_brush: WEL_GDIP_BRUSH; a_rect: WEL_GDIP_RECT)
			-- Uses `a_brush' to fill the interior of a rectangle.
		require
			a_brush_not_void: a_brush /= Void
			a_brush_exists: a_brush.exists
			a_rect_not_void: a_rect /= Void
			exists: exists
		local
			l_result: INTEGER
	 	do
			c_gdip_fill_rectangle_i (gdi_plus_handle, item, a_brush.item, a_rect.x, a_rect.y, a_rect.width, a_rect.height, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
	 	end

	 rotate_transform (a_angle: REAL)
	 		-- Applies the specified rotation to the transformation matrix of this Graphics.
	 		-- `a_angle': Angle of rotation in degrees.
	 	require
			exists: exists
		local
			l_result: INTEGER
	 	do
			c_gdip_rotate_world_transform (gdi_plus_handle, item, a_angle, {WEL_GDIP_MATRIX_ORDER}.prepend, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
	 	end

	translate_transform (a_dx, a_dy: REAL)
			-- Updates Current's world transformation matrix with the product of itself and a translation matrix (`a_dx', `a_dy').
		require
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_translate_world_transform (gdi_plus_handle, item, a_dx, a_dy, {WEL_GDIP_MATRIX_ORDER}.prepend, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	scale_transform (a_sx, a_sy: REAL)
			-- Updates Current's world transformation matrix with the product of itself and a scaling matrix (`a_sx', `a_sy').
		require
			valid: a_sx > 0 and a_sy > 0
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_scale_world_transform (gdi_plus_handle, item, a_sx, a_sy, {WEL_GDIP_MATRIX_ORDER}.prepend, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	clear (a_color: WEL_GDIP_COLOR)
			-- Clears the entire drawing surface and fills it with `a_color'
		require
			not_void: a_color /= Void
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_clear (gdi_plus_handle, item, a_color.item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	set_clip_rect (a_rect: WEL_GDIP_RECT)
			-- Sets the clipping region of Current to `a_rect'
		require
			not_void: a_rect /= Void
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_set_clip_rect_i (gdi_plus_handle, item, a_rect.x, a_rect.y, a_rect.width, a_rect.height, {WEL_GDIP_COMBINE_MODE}.replace, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	set_clip_graphics (a_src_graphics: WEL_GDIP_GRAPHICS)
			-- Updates the clipping region of Current to a region that is the combination of itself and the clipping region of `a_graphics'.
		require
			not_void: a_src_graphics /= Void and then a_src_graphics.exists
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_set_clip_graphics (gdi_plus_handle, item, a_src_graphics.item, {WEL_GDIP_COMBINE_MODE}.replace, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	set_clip_path (a_path: WEL_GDIP_GRAPHICS_PATH)
			-- Updates the clipping region of this Graphics object to a region that is the combination of itself and the region specified by
			-- a graphics path. If a figure in the path is not closed, this method treats the nonclosed figure as if it were closed by a
			-- straight line that connects the figure's starting and ending points.
		require
			a_path_not_void: a_path /= Void
			a_path_exists: a_path.exists
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_set_clip_path (gdi_plus_handle, item, a_path.item, {WEL_GDIP_COMBINE_MODE}.replace, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	set_smoothing_mode (mode: INTEGER)
		require
			is_mode_valid: {WEL_GDIP_SMOOTHING_MODE}.is_valid (mode)
			exists
		local
			r: INTEGER
		do
			c_gdip_set_smoothing_mode (gdi_plus_handle, item, mode, $r)
		end

	reset_clip
			-- Resets the clip region of Current to an infinite region.
		require
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_reset_clip (gdi_plus_handle, item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Query

	dc: WEL_MEMORY_DC
			-- Get a gdi DC.
		require
			exists: exists
		local
			l_pointer: POINTER
			l_result: INTEGER
		do
			l_pointer := c_gdip_get_dc (gdi_plus_handle, item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
			create {WEL_MEMORY_DC} Result.make_by_pointer (l_pointer)
		ensure
			dc_not_void: Result /= Void
			dc_exists: Result.exists
		end

	release_dc (a_dc: WEL_DC)
			-- Release `a_dc' which was created by previous calling of `dc'.
		require
			a_dc_not_void: a_dc /= Void
			a_dc_exists: a_dc.exists
			exists: exists
		local
			l_result: INTEGER
		do
			c_gdip_release_dc (gdi_plus_handle, item, a_dc.item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Destroy

	destroy_item
			-- <Precursor>
		local
			l_result: INTEGER
		do
			if item /= default_pointer then
				c_gdip_delete_graphics (gdi_plus_handle, item, $l_result)
				check ok: l_result = {WEL_GDIP_STATUS}.ok end
				item := default_pointer
			end
		end

feature {NONE} -- C externals

	c_gdip_flush (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_flush_intention: INTEGER; a_result_status: TYPED_POINTER [INTEGER])
			-- Flushes all pending graphics operations
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipFlush = NULL;
				GpGraphics *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipFlush) {
					GdipFlush = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipFlush");
				}
				if (GdipFlush) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, GpFlushIntention)) GdipFlush)
								((GpGraphics *) $a_graphics,
								(GpFlushIntention) $a_flush_intention);
				}									
			}
			]"
		end

	c_gdip_create_from_hdc (a_gdiplus_handle: POINTER; a_dc: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
			-- Create a graphics object from a win32 `a_dc'.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipCreateFromHDC = NULL;
				GpGraphics *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipCreateFromHDC) {
					GdipCreateFromHDC = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCreateFromHDC");
				}
				if (GdipCreateFromHDC) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (HDC, GpGraphics **)) GdipCreateFromHDC)
								((HDC) $a_dc,
								(GpGraphics **) &l_result);
				}
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_get_image_graphics_context (a_gdiplus_handle: POINTER; a_image: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
			-- Get gdi+ graphics from `a_image'
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipGetImageGraphicsContext = NULL;
				GpGraphics *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipGetImageGraphicsContext) {
					GdipGetImageGraphicsContext = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipGetImageGraphicsContext");
				}
				if (GdipGetImageGraphicsContext) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *, GpGraphics **)) GdipGetImageGraphicsContext)
								((GpImage *) $a_image,
								(GpGraphics **) &l_result);
				}				
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_get_dc (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
			-- Get gdi HDC related with Current.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipGetDC = NULL;
				HDC *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipGetDC) {
					GdipGetDC = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipGetDC");
				}
				if (GdipGetDC) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics* , HDC *)) GdipGetDC)
								((GpImage *) $a_graphics,
								(HDC *) &l_result);
				}				
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_release_dc (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_dc: POINTER; a_result_status: TYPED_POINTER [INTEGER])
				-- Release gdi HDC which was created by `c_gdip_get_dc'.
			require
				a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			external
				"C inline use %"wel_gdi_plus.h%""
			alias
				"[
				{
					static FARPROC GdipReleaseDC = NULL;
					*(EIF_INTEGER *) $a_result_status = 1;
					
					if (!GdipReleaseDC) {
						GdipReleaseDC = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipReleaseDC");
					}
					if (GdipReleaseDC) {
						*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics* , HDC)) GdipReleaseDC)
									((GpImage *) $a_graphics,
									(HDC) $a_dc);
					}				
				}
				]"
			end

	c_gdip_delete_graphics (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_result_status: TYPED_POINTER [INTEGER])
			-- Delete `a_graphics' gdi+ object.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_handle_not_null: a_graphics /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipDeleteGraphics = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipDeleteGraphics) {
					GdipDeleteGraphics = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipDeleteGraphics");
				}
				
				if (GdipDeleteGraphics) {			
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *)) GdipDeleteGraphics)
								((GpGraphics *) $a_graphics);
				}					
			}
			]"
		end

	c_gdip_fill_ellipse_i (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_brush: POINTER; a_x, a_y, a_width, a_height: INTEGER; a_result_status: TYPED_POINTER [INTEGER])
			-- Fill a ellipse on `a_graphics' with specified `a_x', `a_y', `a_width', `a_height'.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_not_null: a_graphics /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipFillEllipseI = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipFillEllipseI) {
					GdipFillEllipseI = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipFillEllipseI");
				}
				
				if (GdipFillEllipseI) {			
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, GpBrush *, INT, INT, INT, INT)) GdipFillEllipseI)
								((GpGraphics *) $a_graphics,
								(GpBrush *) $a_brush,
								(INT) $a_x,
								(INT) $a_y,
								(INT) $a_width,
								(INT) $a_height);
				}
			}
			]"
		end

feature {NONE} -- Drawing

	c_gdip_draw_ellipse_i (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_pen: POINTER; a_x, a_y, a_width, a_height: INTEGER; a_result_status: TYPED_POINTER [INTEGER])
			-- Draw a ellipse on `a_graphics' with specified `a_x', `a_y', `a_width', `a_height'.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_not_null: a_graphics /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipDrawEllipseI = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipDrawEllipseI) {
					GdipDrawEllipseI = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipDrawEllipseI");
				}
				
				if (GdipDrawEllipseI) {			
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, GpPen *, INT, INT, INT, INT)) GdipDrawEllipseI)
								((GpGraphics *) $a_graphics,
								(GpPen *) $a_pen,
								(INT) $a_x,
								(INT) $a_y,
								(INT) $a_width,
								(INT) $a_height);
				}
			}
			]"
		end

	c_gdip_draw_image_rect_rect_i (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_image: POINTER; a_dest_x, a_dest_y, a_dest_width, a_dest_height, a_src_x, a_src_y, a_src_width, a_src_height: INTEGER; a_unit: INTEGER; a_image_attributes: POINTER; a_abort_callback: POINTER; a_callback_data: POINTER; a_result_status: TYPED_POINTER [INTEGER])
			-- Draw `a_image' on `a_graphics'.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_not_null: a_graphics /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipDrawImageRectRectI = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipDrawImageRectRectI) {
					GdipDrawImageRectRectI = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipDrawImageRectRectI");
				}
				if (GdipDrawImageRectRectI) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, GpImage *, INT, INT, INT, INT, INT, INT, INT, INT, GpUnit, GDIPCONST GpImageAttributes*, DrawImageAbort, VOID *)) GdipDrawImageRectRectI)
								((GpGraphics *) $a_graphics,
								(GpImage *) $a_image,
								(INT) $a_dest_x,
								(INT) $a_dest_y,
								(INT) $a_dest_width,
								(INT) $a_dest_height,
								(INT) $a_src_x,
								(INT) $a_src_y,
								(INT) $a_src_width,
								(INT) $a_src_height,
								(GpUnit) $a_unit,
								(GDIPCONST GpImageAttributes*) $a_image_attributes,
								(DrawImageAbort) $a_abort_callback,
								(VOID *) $a_callback_data);
				}
			}
			]"
		end

	c_gdip_draw_line_i (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_pen: POINTER; a_x_1, a_y_1, a_x_2, a_y_2: INTEGER; a_result_status: TYPED_POINTER [INTEGER])
			-- Draw a line on `a_graphics' from `a_x_1', `a_y_1' to `a_x_2', `a_y_2'.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_not_null: a_graphics /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipDrawLineI = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipDrawLineI) {
					GdipDrawLineI = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipDrawLineI");
				}
				
				if (GdipDrawLineI) {			
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, GpPen *, INT, INT, INT, INT)) GdipDrawLineI)
								((GpGraphics *) $a_graphics,
								(GpPen *) $a_pen,
								(INT) $a_x_1,
								(INT) $a_y_1,
								(INT) $a_x_2,
								(INT) $a_y_2);
				}
			}
			]"
		end

	c_gdip_draw_lines_i (handle: POINTER; graphics: POINTER; pen: POINTER; coordinates: POINTER; count: INTEGER; status: TYPED_POINTER [INTEGER])
			-- Draw a series of line segments that connect an array of specified coordinates `coorinates` with a total number of points (pairs of coordinates) `count` using a pen `pen` on the Graphics object `graphics` accessible through a GDI+ handle `handle` and record the return value to `status`.
		require
			handle_not_null: handle /= default_pointer
			graphics_not_null: graphics /= default_pointer
			pen_not_null: pen /= default_pointer
			coordinates_not_null: coordinates /= default_pointer
			count_non_negative: count >= 0
		external
			"[
				C inline use "wel_gdi_plus.h"
			]"
		alias
			"[
			{
				static FARPROC GdipDrawLinesI = NULL;
				*(EIF_INTEGER *) $status = 1;
				
				if (!GdipDrawLinesI) {
					GdipDrawLinesI = GetProcAddress ((HMODULE) $handle, "GdipDrawLinesI");
				}
				
				if (GdipDrawLinesI) {			
					*(EIF_INTEGER *) $status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, GpPen *, INT *, INT)) GdipDrawLinesI)
								((GpGraphics *) $graphics,
								(GpPen *) $pen,
								(INT *) $coordinates,
								(INT) $count);
				}
			}
			]"
		end

	c_gdip_draw_polygon_i (handle: POINTER; graphics: POINTER; pen: POINTER; coordinates: POINTER; count: INTEGER; status: TYPED_POINTER [INTEGER])
			-- Draw a polygon on the Graphics object `graphics` accessible using a GDI+ handle `handle` with pen `pen` using coordinates `coordinates` with a total number of points (pairs of coordinates) `count` and record return value to `status`.
		require
			handle_not_null: handle /= default_pointer
			graphics_not_null: graphics /= default_pointer
			pen_not_null: pen /= default_pointer
			coordinates_not_null: coordinates /= default_pointer
			count_non_negative: count >= 0
		external
			"[
				C inline use "wel_gdi_plus.h"
			]"
		alias
			"[
			{
				static FARPROC GdipDrawPolygonI = NULL;
				*(EIF_INTEGER *) $status = 1;
				
				if (!GdipDrawPolygonI) {
					GdipDrawPolygonI = GetProcAddress ((HMODULE) $handle, "GdipDrawPolygonI");
				}
				
				if (GdipDrawPolygonI) {			
					*(EIF_INTEGER *) $status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, GpPen *, INT *, INT)) GdipDrawPolygonI)
								((GpGraphics *) $graphics,
								(GpPen *) $pen,
								(INT *) $coordinates,
								(INT) $count);
				}
			}
			]"
		end

	c_gdip_draw_rectangle_i (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_pen: POINTER; a_x, a_y, a_width, a_height: INTEGER; a_result_status: TYPED_POINTER [INTEGER])
			-- Draw a rectangle on `a_graphics' with specified `a_x', `a_y', `a_width', `a_height'.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_not_null: a_graphics /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipDrawRectangleI = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipDrawRectangleI) {
					GdipDrawRectangleI = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipDrawRectangleI");
				}
				
				if (GdipDrawRectangleI) {			
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, GpPen *, INT, INT, INT, INT)) GdipDrawRectangleI)
								((GpGraphics *) $a_graphics,
								(GpPen *) $a_pen,
								(INT) $a_x,
								(INT) $a_y,
								(INT) $a_width,
								(INT) $a_height);
				}
			}
			]"
		end

	c_gdip_draw_string (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_wchar_string: POINTER; a_length: INTEGER; a_font: POINTER; a_gp_rect_f: POINTER; a_gp_string_format: POINTER; a_gp_brush: POINTER; a_result_status: TYPED_POINTER [INTEGER])
			-- Draw `a_wchar_string' on `a_graphics'.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_not_null: a_graphics /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipDrawString = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipDrawString) {
					GdipDrawString = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipDrawString");
				}
				if (GdipDrawString) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, GDIPCONST WCHAR *, INT, GDIPCONST GpFont *, GDIPCONST RectF *, GDIPCONST GpStringFormat *, GDIPCONST GpBrush *)) GdipDrawString)
								((GpGraphics *) $a_graphics,
								(GDIPCONST WCHAR *) $a_wchar_string,
								(INT) $a_length,
								(GDIPCONST GpFont *) $a_font,
								(GDIPCONST RectF *) $a_gp_rect_f,
								(GDIPCONST GpStringFormat *) $a_gp_string_format,
								(GDIPCONST GpBrush *) $a_gp_brush);
				}
			}
			]"
		end

	c_gdip_fill_polygon_i (handle: POINTER; graphics: POINTER; brush: POINTER; coordinates: POINTER; count: INTEGER; mode: INTEGER; status: TYPED_POINTER [INTEGER])
			-- Fill the interior of a polygon defined by an array of coordinate pairs `coordinates` with the number of pairs `count` on the Graphics object `graphics` accessible using a GDI+ handle `handle` with a brush `brush` and record return value to `status`.
		require
			handle_not_null: handle /= default_pointer
			graphics_not_null: graphics /= default_pointer
			brush_not_null: brush /= default_pointer
			coordinates_not_null: coordinates /= default_pointer
			count_non_negative: count >= 0
			valid_mode: {WEL_GDIP_FILL_MODE}.is_valid (mode)
		external
			"[
				C inline use "wel_gdi_plus.h"
			]"
		alias
			"[
			{
				static FARPROC GdipFillPolygonI = NULL;
				*(EIF_INTEGER *) $status = 1;
				
				if (!GdipFillPolygonI) {
					GdipFillPolygonI = GetProcAddress ((HMODULE) $handle, "GdipFillPolygonI");
				}
				
				if (GdipFillPolygonI) {			
					*(EIF_INTEGER *) $status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, GpPen *, INT *, INT, INT)) GdipFillPolygonI)
								((GpGraphics *) $graphics,
								(GpPen *) $brush,
								(INT *) $coordinates,
								(INT) $count,
								(INT) $mode);
				}
			}
			]"
		end

	c_gdip_fill_rectangle_i (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_brush: POINTER; a_x, a_y, a_width, a_height: INTEGER; a_result_status: TYPED_POINTER [INTEGER])
			-- Uses a brush to fill the interior of a rectangle.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_not_null: a_graphics /= default_pointer
			a_brush_not_null: a_brush /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipFillRectangleI = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipFillRectangleI) {
					GdipFillRectangleI = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipFillRectangleI");
				}
				if (GdipFillRectangleI) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, GpBrush *, INT, INT, INT, INT)) GdipFillRectangleI)
								((GpGraphics *) $a_graphics,
								(GpBrush *) $a_brush,
								(INT) $a_x,
								(INT) $a_y,
								(INT) $a_width,
								(INT) $a_height);
				}
			}
			]"
		end

	c_gdip_rotate_world_transform (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_angle: REAL; a_order: INTEGER; a_result_status: TYPED_POINTER [INTEGER])
			-- Rotate drawing in subsequent calling of `draw_xxx'.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_not_null: a_graphics /= default_pointer
			a_order_valid: (create {WEL_GDIP_MATRIX_ORDER}).is_valid (a_order)
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipRotateWorldTransform = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipRotateWorldTransform) {
					GdipRotateWorldTransform = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipRotateWorldTransform");
				}
				if (GdipRotateWorldTransform) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, REAL, GpMatrixOrder)) GdipRotateWorldTransform)
								((GpGraphics *) $a_graphics,
								(REAL) $a_angle,
								(GpMatrixOrder) $a_order);
				}
			}
			]"
		end

	c_gdip_translate_world_transform (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_dx, a_dy: REAL; a_order: INTEGER; a_result_status: TYPED_POINTER [INTEGER])
			-- Updates Current's world transformation matrix with the product of itself and a translation matrix.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_not_null: a_graphics /= default_pointer
			a_order_valid: (create {WEL_GDIP_MATRIX_ORDER}).is_valid (a_order)
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipTranslateWorldTransform = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipTranslateWorldTransform) {
					GdipTranslateWorldTransform = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipTranslateWorldTransform");
				}
				if (GdipTranslateWorldTransform) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, REAL, REAL, GpMatrixOrder)) GdipTranslateWorldTransform)
								((GpGraphics *) $a_graphics,
								(REAL) $a_dx,
								(REAL) $a_dy,
								(GpMatrixOrder) $a_order);
				}
			}
			]"
		end

	c_gdip_scale_world_transform (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_sx, a_sy: REAL; a_order: INTEGER; a_result_status: TYPED_POINTER [INTEGER])
			-- Updates Current's world transformation matrix with the product of itself and a scaling matrix.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_not_null: a_graphics /= default_pointer
			a_order_valid: (create {WEL_GDIP_MATRIX_ORDER}).is_valid (a_order)
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipScaleWorldTransform = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipScaleWorldTransform) {
					GdipScaleWorldTransform = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipScaleWorldTransform");
				}
				if (GdipScaleWorldTransform) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, REAL, REAL, GpMatrixOrder)) GdipScaleWorldTransform)
								((GpGraphics *) $a_graphics,
								(REAL) $a_sx,
								(REAL) $a_sy,
								(GpMatrixOrder) $a_order);
				}
			}
			]"
		end

	c_gdip_clear (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_color: INTEGER_64; a_result_status: TYPED_POINTER [INTEGER])
			-- Clears the entire drawing surface and fills it with `a_color'
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_not_null: a_graphics /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipGraphicsClear = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipGraphicsClear) {
					GdipGraphicsClear = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipGraphicsClear");
				}
				if (GdipGraphicsClear) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, ARGB)) GdipGraphicsClear)
								((GpGraphics *) $a_graphics,
								(ARGB) $a_color);
				}
			}
			]"
		end

	c_gdip_set_clip_rect_i (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_x, a_y, a_width, a_height: INTEGER; a_combine_mode: INTEGER; a_result_status: TYPED_POINTER [INTEGER])
			-- Sets the clipping region of Current to the Clip property of parameters.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_not_null: a_graphics /= default_pointer
			a_combine_mode_valid: (create {WEL_GDIP_COMBINE_MODE}).is_valid (a_combine_mode)
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipSetClipRectI = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipSetClipRectI) {
					GdipSetClipRectI = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipSetClipRectI");
				}
				if (GdipSetClipRectI) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, INT, INT, INT, INT, CombineMode)) GdipSetClipRectI)
								((GpGraphics *) $a_graphics,
								(INT) $a_x,
								(INT) $a_y,
								(INT) $a_width,
								(INT) $a_height,
								(CombineMode) $a_combine_mode);
				}
			}
			]"
		end

	c_gdip_set_clip_graphics (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_src_graphics: POINTER; a_combine_mode: INTEGER; a_result_status: TYPED_POINTER [INTEGER])
			-- Sets the clipping region of Current to the Clip property of `a_src_graphics'.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_not_null: a_graphics /= default_pointer
			a_src_graphics_not_null: a_src_graphics /= default_pointer
			a_combine_mode_valid: (create {WEL_GDIP_COMBINE_MODE}).is_valid (a_combine_mode)
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipSetClipGraphics = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipSetClipGraphics) {
					GdipSetClipGraphics = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipSetClipGraphics");
				}
				if (GdipSetClipGraphics) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, GpGraphics *, CombineMode)) GdipSetClipGraphics)
								((GpGraphics *) $a_graphics,
								(GpGraphics *) $a_src_graphics,
								(CombineMode) $a_combine_mode);
				}
			}
			]"
		end

	c_gdip_set_clip_path (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_graphics_path: POINTER; a_combine_mode: INTEGER; a_result_status: TYPED_POINTER [INTEGER])
			-- Updates the clipping region of Current to a region that is the combination of itself and the region specified by a graphics path.
			-- If a figure in the path is not closed, this method treats the nonclosed figure as if it were closed by a straight line that connects
			-- the figure's starting and ending points.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_not_null: a_graphics /= default_pointer
			a_src_graphics_not_null: a_graphics_path /= default_pointer
			a_combine_mode_valid: (create {WEL_GDIP_COMBINE_MODE}).is_valid (a_combine_mode)
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipSetClipPath = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipSetClipPath) {
					GdipSetClipPath = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipSetClipPath");
				}
				if (GdipSetClipPath) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, GpPath *, CombineMode)) GdipSetClipPath)
								((GpGraphics *) $a_graphics,
								(GpPath *) $a_graphics_path,
								(CombineMode) $a_combine_mode);
				}
			}
			]"
		end

	c_gdip_set_smoothing_mode (handle: POINTER; graphics: POINTER; mode: INTEGER; status: TYPED_POINTER [INTEGER])
			-- Sets the rendering quality of the Graphics object `graphics` accessible using a GDI+ handle `handle` to smoothing mode `mode` and record return value to `status`.
		require
			handle_not_null: handle /= default_pointer
			graphics_not_null: graphics /= default_pointer
			mode_valid: {WEL_GDIP_SMOOTHING_MODE}.is_valid (mode)
		external
			"[
				C++ inline use "wel_gdi_plus.h"
			]"
		alias
			"[
			{
				static FARPROC GdipSetSmoothingMode = NULL;
				*(EIF_INTEGER *) $status = 1;

				if (!GdipSetSmoothingMode) {
					GdipSetSmoothingMode = GetProcAddress ((HMODULE) $handle, "GdipSetSmoothingMode");
				}
				if (GdipSetSmoothingMode) {
					*(EIF_INTEGER *) $status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, INT)) GdipSetSmoothingMode)
								((GpGraphics *) $graphics,
								(INT) $mode);
				}
			}
			]"
		end

	c_gdip_reset_clip (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_result_status: TYPED_POINTER [INTEGER])
			-- Resets the clip region of `a_graphics' to an infinite region.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_graphics_not_null: a_graphics /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipResetClip = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;

				if (!GdipResetClip) {
					GdipResetClip = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipResetClip");
				}
				if (GdipResetClip) {
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *)) GdipResetClip)
								((GpGraphics *) $a_graphics);
				}
			}
			]"
		end

feature -- Obsolete

	draw_image_with_src_rect_dest_rect (a_image: WEL_GDIP_IMAGE; a_dest_rect, a_src_rect: WEL_RECT)
			-- Draw `a_image' at `a_dest_rect' from `a_src_dest'
		obsolete
			"Use draw_image_with_dest_rect_src_rect instead [2017-05-31]."
		require
			not_void: a_image /= Void
			a_image_exists: a_image.exists
			not_void: a_dest_rect /= Void
			a_dest_rect_exists: a_dest_rect.exists
			not_void: a_src_rect /= Void
			a_src_rect_exists: a_src_rect.exists
		do
			draw_image_with_dest_rect_src_rect (a_image, a_dest_rect, a_src_rect)
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
