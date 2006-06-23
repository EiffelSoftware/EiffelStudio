indexing
	description: "Gdi+ pen's functions."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_PEN

inherit
	WEL_GDIP_ANY
		redefine
			delete
		end

create
	make

feature {NONE} -- Initialization

	make (a_color: WEL_GDIP_COLOR; a_width: REAL) is
			-- Creation method
		local
			l_result: INTEGER
		do
			c_gdip_create_pen_l (a_color.item, a_width, {WEL_GDIP_UNIT}.unitpixel, $item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature {NONE} -- Destroy

	delete is
			-- Redefine
		local
			l_result: INTEGER
		do
			c_gdip_delete_pen (item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature {NONE} -- C externals

	c_gdip_create_pen_l (a_argb: INTEGER_64; a_width: REAL; a_unit: INTEGER; a_result_pen: TYPED_POINTER [POINTER]; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Create Current
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipCreatePen1 = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipCreatePen1 = GetProcAddress (user32_module, "GdipCreatePen1");
					if (GdipCreatePen1) {			
						*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (ARGB, REAL, GpUnit, GpPen **)) GdipCreatePen1)
									((ARGB) $a_argb,
									(REAL) $a_width,
									(GpUnit) $a_unit,
									(GpPen **) $a_result_pen);
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

	c_gdip_delete_pen (a_pen: POINTER; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Delete Gdi+ object `a_pen'
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipDeletePen = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipDeletePen = GetProcAddress (user32_module, "GdipDeletePen");
					if (GdipDeletePen) {			
						*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpPen *)) GdipDeletePen)
									((GpPen *) $a_pen);
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

end
