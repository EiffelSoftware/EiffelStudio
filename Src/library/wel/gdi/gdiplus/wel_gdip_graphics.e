indexing
	description: "Grapics functions in Gdi+."
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

	make_from_image (a_image: WEL_GDIP_IMAGE) is
			-- Initlialize Current from `a_image'
		require
			not_void: a_image /= Void
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_get_image_graphics_context (gdi_plus_handle, a_image.item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	make_from_dc (a_dc: WEL_DC) is
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

	draw_line (a_pen: WEL_GDIP_PEN;  a_x_1, a_y_1, a_x_2, a_y_2: INTEGER) is
			-- Draw a line
		require
			not_void: a_pen /= Void
		local
			l_result: INTEGER
		do
			c_gdip_draw_line_i (gdi_plus_handle, item, a_pen.item, a_x_1, a_y_1, a_x_2, a_y_2, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	draw_image (a_image: WEL_GDIP_IMAGE; a_dest_x, a_dest_y: INTEGER) is
			-- Draw `a_image' at `a_dest_x' `a_dest_y'
		require
			not_void: a_image /= Void
		local
			l_dest_rect, l_src_rect: WEL_RECT
		do
			create l_dest_rect.make (a_dest_x, a_dest_y, a_dest_x + a_image.width, a_image.height)
			create l_src_rect.make (0, 0, a_image.width, a_image.height)

			draw_image_with_src_rect_dest_rect (a_image, l_dest_rect, l_src_rect)

			l_dest_rect.dispose
			l_src_rect.dispose
		end

	draw_image_with_src_rect_dest_rect (a_image: WEL_GDIP_IMAGE; a_dest_rect, a_src_rect: WEL_RECT) is
			-- Draw `a_image' at `a_dest_rect' from `a_src_dest'
		require
			not_void: a_image /= Void
			not_void: a_dest_rect /= Void
			not_void: a_src_rect /= Void
		do
			draw_image_with_src_rect_dest_rect_unit_attributes (a_image, a_dest_rect, a_src_rect, {WEL_GDIP_UNIT}.unitpixel, Void)
		end

	draw_image_with_src_rect_dest_rect_unit_attributes (a_image: WEL_GDIP_IMAGE; a_dest_rect, a_src_rect: WEL_RECT; a_unit: INTEGER; a_image_attributes: WEL_GDIP_IMAGE_ATTRIBUTES) is
			-- Draw `a_image' with arguments.
		require
			not_void: a_image /= Void
			not_void: a_dest_rect /= Void
			not_void: a_src_rect /= Void
			valid: (create {WEL_GDIP_UNIT}).is_valid (a_unit)
		local
			l_result: INTEGER
			l_null_pointer: POINTER
		do
			if a_image_attributes = Void then
				c_gdip_draw_image_rect_rect_i (gdi_plus_handle, item, a_image.item, a_dest_rect.x, a_dest_rect.y, a_dest_rect.width, a_dest_rect.height, a_src_rect.x, a_src_rect.y, a_src_rect.width, a_src_rect.height, a_unit, l_null_pointer, l_null_pointer, l_null_pointer, $l_result)
			else
				c_gdip_draw_image_rect_rect_i (gdi_plus_handle, item, a_image.item, a_dest_rect.x, a_dest_rect.y, a_dest_rect.width, a_dest_rect.height, a_src_rect.x, a_src_rect.y, a_src_rect.width, a_src_rect.height, a_unit, a_image_attributes.item, l_null_pointer, l_null_pointer, $l_result)
			end
		end

	draw_string (a_string: STRING_GENERAL; a_length: INTEGER; a_font: WEL_GDIP_FONT; a_x, a_y: REAL) is
			-- Draw `a_length' characters of `a_string' with `a_font' at `a_x',`a_y' position.
		require
			not_void: a_string /= Void
			valid: a_length >= 0
			not_void: a_font /= Void
			valid: a_x >= 0 and a_y >= 0
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
			draw_string_with_length_font_rect_format_brush (a_string, a_length, a_font, l_rect_f, l_format, l_brush)
		end

	draw_string_with_length_font_rect_format_brush (a_string: STRING_GENERAL; a_length: INTEGER; a_font: WEL_GDIP_FONT; a_rect_f: WEL_GDIP_RECT_F; a_format: WEL_GDIP_STRING_FORMAT; a_brush: WEL_GDIP_BRUSH) is
			-- Draw string with arguments.
		require
			not_void: a_string /= Void
			valid: a_length >= 0
			not_void: a_font /= Void
			not_void: a_rect_f /= Void
		local
			l_result: INTEGER
			l_wel_string: WEL_STRING
		do
			create l_wel_string.make (a_string)
			c_gdip_draw_string (gdi_plus_handle, item, l_wel_string.item, a_length, a_font.item, a_rect_f.item, a_format.item, a_brush.item, $l_result)
		end

feature -- Destroy

	destroy_item is
			-- Redefine
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

	c_gdip_create_from_hdc (a_gdiplus_handle: POINTER; a_dc: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER is
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

	c_gdip_get_image_graphics_context (a_gdiplus_handle: POINTER; a_image: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER is
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

	c_gdip_delete_graphics (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_result_status: TYPED_POINTER [INTEGER]) is
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

	c_gdip_draw_line_i (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_pen: POINTER; a_x_1, a_y_1, a_x_2, a_y_2: INTEGER; a_result_status: TYPED_POINTER [INTEGER]) is
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

	c_gdip_draw_image_rect_rect_i (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_image: POINTER; a_dest_x, a_dest_y, a_dest_width, a_dest_height, a_src_x, a_src_y, a_src_width, a_src_height: INTEGER; a_unit: INTEGER; a_image_attributes: POINTER; a_abort_callback: POINTER; a_callback_data: POINTER; a_result_status: TYPED_POINTER [INTEGER]) is
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

	c_gdip_draw_string (a_gdiplus_handle: POINTER; a_graphics: POINTER; a_wchar_string: POINTER; a_length: INTEGER; a_font: POINTER; a_gp_rect_f: POINTER; a_gp_string_format: POINTER; a_gp_brush: POINTER; a_result_status: TYPED_POINTER [INTEGER]) is
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

end
