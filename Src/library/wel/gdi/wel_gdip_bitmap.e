indexing
	description: "Btimap functions in Gdi+."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_BITMAP

inherit
	WEL_GDIP_IMAGE

create
	make_with_size

feature {NONE} -- Initlization

	make_with_size (a_width, a_height: INTEGER) is
			-- Creation method.
		require
			larger_than_0: a_width > 0
			larger_than_0: a_height > 0
		local
			l_result: INTEGER
		do
			cpp_bitmap_create (a_width, a_height, $item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- C externals

	cpp_bitmap_create (a_width, a_height: INTEGER; a_result_bitmap: TYPED_POINTER [POINTER]; a_result_status: TYPED_POINTER [INTEGER])  is
			-- Create a C++ bitmap object.
		require
			support: is_gdi_plus_installed
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipCreateBitmapFromScan0 = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipCreateBitmapFromScan0 = GetProcAddress (user32_module, "GdipCreateBitmapFromScan0");
					if (GdipCreateBitmapFromScan0) {

						*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (INT, INT, INT, PixelFormat, BYTE*, GpBitmap **)) GdipCreateBitmapFromScan0)
									((INT) $a_width,
									(INT) $a_height,
									(INT) 0,
									(PixelFormat) PixelFormat32bppARGB,
									(BYTE*) NULL,
									(GpBitmap **) $a_result_bitmap);
						
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
