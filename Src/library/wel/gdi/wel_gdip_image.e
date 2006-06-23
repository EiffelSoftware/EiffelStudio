indexing
	description: "Image functions in GDI+."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_IMAGE

inherit
	WEL_GDIP_ANY
		redefine
			delete
		end

feature -- Command

	load_image_from_file (a_file_name: STRING) is
			-- Load datas from a file.
		local
			l_wel_string: WEL_STRING
			l_result: INTEGER
		do
			delete
			create l_wel_string.make (a_file_name)
			c_gdip_load_image_from_file (l_wel_string.item, $item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Query

	width: INTEGER is
			-- Width
		local
			l_result_status: INTEGER
			l_result_width: NATURAL_32
		do
			c_gdip_get_image_width (item, $l_result_width, $l_result_status)
			check ok: l_result_status = {WEL_GDIP_STATUS}.ok end
			Result := l_result_width.to_integer_32
		end

	height: INTEGER is
			-- Height
		local
			l_result_status: INTEGER
			l_result_height: NATURAL_32
		do
			c_gdip_get_image_height (item, $l_result_height, $l_result_status)
			check ok: l_result_status = {WEL_GDIP_STATUS}.ok end
			Result := l_result_height.to_integer_32
		end

feature -- Destory

	delete is
			-- Redefine
		local
			l_result: INTEGER
		do
			c_gdip_dispose_image (item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- C externals

	c_gdip_load_image_from_file (a_wchar_file_name: POINTER; a_result_bitmap: TYPED_POINTER [POINTER]; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Create a C++ bitmap object name from file `a_wchar_file_name'.
			-- Pixmap format include BMP, GIF, JPEG, PNG, TIFF, and EMF.
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipLoadImageFromFile = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipLoadImageFromFile = GetProcAddress (user32_module, "GdipLoadImageFromFile");
					if (GdipLoadImageFromFile) {
						*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GDIPCONST  WCHAR*, GpImage **)) GdipLoadImageFromFile)
									((GDIPCONST  WCHAR *) $a_wchar_file_name,
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

	c_gdip_get_image_width (a_item: POINTER; a_result_width: TYPED_POINTER [NATURAL_32]; a_result_status: TYPED_POINTER [INTEGER])  is
			-- Width
		external
			"C inline use <gdiplus.h>"
		alias
			"[
				FARPROC GdipGetImageWidth = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipGetImageWidth = GetProcAddress (user32_module, "GdipGetImageWidth");
					if (GdipGetImageWidth) {
						*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *, UINT *)) GdipGetImageWidth)
									((GpImage *) $a_item,
									(UINT *) $a_result_width);
					}else
					{ 
						// There is no this function in the dll.
					}				
				}else
				{
					// User does not have the dll.
				}
			]"
		end

	c_gdip_get_image_height (a_item: POINTER; a_result_height: TYPED_POINTER [NATURAL_32]; a_result_status: TYPED_POINTER [INTEGER])  is
			-- Height
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipGetImageHeight = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipGetImageHeight = GetProcAddress (user32_module, "GdipGetImageHeight");
					if (GdipGetImageHeight) {
						*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *, UINT *)) GdipGetImageHeight)
									((GpImage *) $a_item,
									(UINT *) $a_result_height);
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

	c_gdip_dispose_image (a_image: POINTER; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Dispose `a_image'
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipDisposeImage = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipDisposeImage = GetProcAddress (user32_module, "GdipDisposeImage");
					if (GdipDisposeImage) {
						*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *)) GdipDisposeImage)
									((GpImage *) $a_image);
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
