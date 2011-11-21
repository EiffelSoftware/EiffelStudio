note
	description: "Routines for rendering graphics to a context"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DRAWABLE_ROUTINES

feature -- Basic Operation

	draw_point (drawable_context: NATIVE_DRAWABLE_CONTEXT; x, y: INTEGER_16; native_pen: NATIVE_PEN)
			-- Render a point at (`x', `y') to `drawable_context' using `native_pen'
		require
			drawable_context_not_void: drawable_context /= Void
			drawable_context_initialized: drawable_context.initialized
			native_pen_not_void: native_pen /= Void
		do
			c_native_draw_point (drawable_context.native_handle, x, y, native_pen.native_pen)
		end

	draw_text (drawable_context: NATIVE_DRAWABLE_CONTEXT; native_rectangle: NATIVE_RECTANGLE; a_text: STRING_8)
		require
			drawable_context_not_void: drawable_context /= Void
			drawable_context_initialized: drawable_context.initialized
		local
			l_text: ANY
		do
			l_text := a_text.to_c
			c_native_draw_text (drawable_context.native_handle, native_rectangle.native_rectangle_handle, $l_text, a_text.count.as_natural_16)
		end

	fill_rectangle (drawable_context: NATIVE_DRAWABLE_CONTEXT; native_rectangle: NATIVE_RECTANGLE; native_brush: NATIVE_BRUSH)
		require
			drawable_context_not_void: drawable_context /= Void
			drawable_context_initialized: drawable_context.initialized
			native_brush_not_void: native_brush /= Void
		do
			c_native_draw_rectangle (drawable_context.native_handle, native_rectangle.native_rectangle_handle, native_brush.native_brush, True)
		end

feature {NONE} -- Implementation

	c_native_draw_point (a_native_graphics_context_handle: POINTER; x, y: INTEGER_16; a_native_pen_handle: POINTER)
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					PAINTSTRUCT* lPaint;
					HPEN lPen;
					POINT lPointArray[4];
					HDC lHdc;
					HGDIOBJ lGdiObj;
					int lx, ly;
					
					lx = (int) $x;
					ly = (int) $y;			
					
					lPaint = (PAINTSTRUCT*) $a_native_graphics_context_handle;
					lHdc = lPaint->hdc;					
					lPen = (HPEN*) $a_native_pen_handle;

					lPointArray[0].x = lx;
					lPointArray[0].y = ly;
					lPointArray[1].x = lx;
					lPointArray[1].y = ly;

					lGdiObj = SelectObject (lHdc, lPen);
					Polyline (lHdc, lPointArray, 2);
					SelectObject (lHdc, lGdiObj);
				#endif
			]"
		end

	c_native_draw_rectangle (a_native_graphics_context_handle, a_native_rectangle_handle, a_native_brush_handle: POINTER; a_filled: BOOLEAN)
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					PAINTSTRUCT* lPaint;
					RECT* lRect;
					
					lPaint = (PAINTSTRUCT*) $a_native_graphics_context_handle;
					lRect = (RECT*) $a_native_rectangle_handle;
					if ((EIF_BOOLEAN) $a_filled)
					{
						FillRect (lPaint->hdc, lRect, (HBRUSH) $a_native_brush_handle);
					}
					else
					{
						Rectangle (lPaint->hdc, lRect->left, lRect->top, lRect->right, lRect->bottom);
					}
				#endif
			]"
		end

	c_native_draw_text (a_native_graphics_context_handle, a_native_rectangle_handle, a_native_text_handle: POINTER; a_text_count: NATURAL_16)
		external
			"C inline use <edk.h>"
		alias
			"[
				#ifdef EIF_OS = EIF_WINNT
					PAINTSTRUCT* lPaint;
					RECT* lRect;
					
					char szTitle[] = "These are the dimensions of your client area:";
					
					lPaint = (PAINTSTRUCT*) $a_native_graphics_context_handle;
					lRect = (RECT*) $a_native_rectangle_handle;
					DrawText (lPaint->hdc, szTitle, $a_text_count, lRect, DT_CENTER);
				#endif
			]"
		end


end
