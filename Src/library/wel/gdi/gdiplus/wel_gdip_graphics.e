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
			delete
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
			c_gdip_get_image_graphics_context (a_image.item, $item, $l_result)
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
			c_gdip_create_from_hdc (a_dc.item, $l_result, $item)
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
			c_gdip_draw_line_i (item, a_pen.item, a_x_1, a_y_1, a_x_2, a_y_2, $l_result)
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
				c_gdip_draw_image_rect_rect_i (item, a_image.item, a_dest_rect.x, a_dest_rect.y, a_dest_rect.width, a_dest_rect.height, a_src_rect.x, a_src_rect.y, a_src_rect.width, a_src_rect.height, a_unit, l_null_pointer, l_null_pointer, l_null_pointer, $l_result)
			else
				c_gdip_draw_image_rect_rect_i (item, a_image.item, a_dest_rect.x, a_dest_rect.y, a_dest_rect.width, a_dest_rect.height, a_src_rect.x, a_src_rect.y, a_src_rect.width, a_src_rect.height, a_unit, a_image_attributes.item, l_null_pointer, l_null_pointer, $l_result)
			end
		end

feature -- Destroy

	delete is
			-- Redefine
		local
			l_result: INTEGER
		do
			c_gdip_delete_graphics (item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature {NONE} -- C externals

	c_gdip_create_from_hdc (a_dc: POINTER; a_result_status: TYPED_POINTER [INTEGER]; a_result_graphic: TYPED_POINTER [POINTER]) is
			-- Create `a_item' from a win32 `a_dc'.
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipCreateFromHDC = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipCreateFromHDC = GetProcAddress (user32_module, "GdipCreateFromHDC");
					if (GdipCreateFromHDC) {
						
						*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (HDC, GpGraphics **)) GdipCreateFromHDC)
									((HDC) $a_dc,
									(GpGraphics **) $a_result_graphic);
					}else
					{
						// There is no this function in the dll.
					}				
				}else
				{
					// User does not have the dll.
				}
			}
			]"
		end

	c_gdip_get_image_graphics_context (a_image: POINTER; a_result_graphics: TYPED_POINTER [POINTER]; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Get `a_result_graphics' from `a_image'
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipGetImageGraphicsContext = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipGetImageGraphicsContext = GetProcAddress (user32_module, "GdipGetImageGraphicsContext");
					if (GdipGetImageGraphicsContext) {
						
						*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *, GpGraphics **)) GdipGetImageGraphicsContext)
									((GpImage *) $a_image,
									(GpGraphics **) $a_result_graphics);
					}else
					{
						// There is no this function in the dll.
					}				
				}else
				{
					// User does not have the dll.
				}
			}
			]"
		end

	c_gdip_delete_graphics (a_graphics: POINTER; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Delete `a_graphics' gdi+ object.
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipDeleteGraphics = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipDeleteGraphics = GetProcAddress (user32_module, "GdipDeleteGraphics");
					if (GdipDeleteGraphics) {			
						*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *)) GdipDeleteGraphics)
									((GpGraphics *) $a_graphics);
					}else
					{
						// There is no this function in the dll.
					}				
				}else
				{
					// User does not have the dll.
				}				
			}
			]"
		end

	c_gdip_draw_line_i (a_graphics: POINTER; a_pen: POINTER; a_x_1, a_y_1, a_x_2, a_y_2: INTEGER; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Draw a line on `a_graphics' from `a_x_1', `a_y_1' to `a_x_2', `a_y_2'.
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipDrawLineI = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipDrawLineI = GetProcAddress (user32_module, "GdipDrawLineI");
					if (GdipDrawLineI) {			
						*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpGraphics *, GpPen *, INT, INT, INT, INT)) GdipDrawLineI)
									((GpGraphics *) $a_graphics,
									(GpPen *) $a_pen,
									(INT) $a_x_1,
									(INT) $a_y_1,
									(INT) $a_x_2,
									(INT) $a_y_2);
					}else
					{
						// There is no this function in the dll.
					}				
				}else
				{
					// User does not have the dll.
				}
			}
			]"
		end

	c_gdip_draw_image_rect_rect_i (a_graphics: POINTER; a_image: POINTER; a_dest_x, a_dest_y, a_dest_width, a_dest_height, a_src_x, a_src_y, a_src_width, a_src_height: INTEGER; a_unit: INTEGER; a_image_attributes: POINTER; a_abort_callback: POINTER; a_callback_data: POINTER; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Draw `a_image' on `a_graphics'.
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipDrawImageRectRectI = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipDrawImageRectRectI = GetProcAddress (user32_module, "GdipDrawImageRectRectI");
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
					}else
					{
						// There is no this function in the dll.
					}				
				}else
				{
					// User does not have the dll.
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
