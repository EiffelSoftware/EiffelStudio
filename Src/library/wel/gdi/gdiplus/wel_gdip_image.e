indexing
	description: "Image functions in GDI+."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_IMAGE

inherit
	WEL_GDIP_ANY
		redefine
			destroy_item
		end

feature -- Command

	load_image_from_file (a_file_name: STRING) is
			-- Load datas from a file.
		local
			l_wel_string: WEL_STRING
			l_result: INTEGER
		do
			destroy_item
			create l_wel_string.make (a_file_name)
			item := c_gdip_load_image_from_file (gdi_plus_handle, l_wel_string.item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Query

	width: INTEGER is
			-- Width
		local
			l_result_status: INTEGER
			l_result_width: NATURAL_32
		do
			Result := c_gdip_get_image_width (gdi_plus_handle, item, $l_result_status).to_integer_32
			check ok: l_result_status = {WEL_GDIP_STATUS}.ok end
		end

	height: INTEGER is
			-- Height
		local
			l_result_status: INTEGER
			l_result_height: NATURAL_32
		do
			Result := c_gdip_get_image_height (gdi_plus_handle, item, $l_result_status).to_integer_32
			check ok: l_result_status = {WEL_GDIP_STATUS}.ok end
		end

feature -- Destory

	destroy_item is
			-- Redefine
		local
			l_result: INTEGER
		do
			c_gdip_dispose_image (gdi_plus_handle, item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- C externals

	c_gdip_load_image_from_file (a_gdiplus_handle: POINTER; a_wchar_file_name: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER is
			-- Create a C++ bitmap object name from file `a_wchar_file_name'.
			-- Pixmap format include BMP, GIF, JPEG, PNG, TIFF, and EMF.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_wchar_file_name_not_null: a_wchar_file_name /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipLoadImageFromFile = NULL;
				GpImage *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipLoadImageFromFile) {
					GdipLoadImageFromFile = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipLoadImageFromFile");
				}	
				
				if (GdipLoadImageFromFile) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GDIPCONST  WCHAR*, GpImage **)) GdipLoadImageFromFile)
								((GDIPCONST  WCHAR *) $a_wchar_file_name,
								(GpBitmap **) &l_result);
				}							
				
				return (EIF_POINTER) l_result;
			}
			]"
		end

	c_gdip_get_image_width (a_gdiplus_handle: POINTER; a_item: POINTER; a_result_status: TYPED_POINTER [INTEGER]): NATURAL_32  is
			-- Width
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_item_not_null: a_item /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
				static FARPROC GdipGetImageWidth = NULL;
				EIF_NATURAL_32 l_result;
				
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipGetImageWidth) {
					GdipGetImageWidth = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipGetImageWidth");
				}
				if (GdipGetImageWidth) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *, UINT *)) GdipGetImageWidth)
								((GpImage *) $a_item,
								(UINT *) &l_result);
				}
				
				return l_result;
			]"
		end

	c_gdip_get_image_height (a_gdiplus_handle: POINTER; a_item: POINTER; a_result_status: TYPED_POINTER [INTEGER]): NATURAL_32  is
			-- Height
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_item_not_null: a_item /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipGetImageHeight = NULL;
				EIF_NATURAL_32 l_result;
				
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipGetImageHeight) {
					GdipGetImageHeight = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipGetImageHeight");
				}			
				
				if (GdipGetImageHeight) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *, UINT *)) GdipGetImageHeight)
								((GpImage *) $a_item,
								(UINT *) &l_result);
				}				
				return l_result;
			}
			]"
		end

	c_gdip_dispose_image (a_gdiplus_handle: POINTER; a_image: POINTER; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Dispose `a_image'
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_iamge_not_null: a_image /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipDisposeImage = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipDisposeImage) {
					GdipDisposeImage = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipDisposeImage");
				}			
				if (GdipDisposeImage) {
					*(EIF_INTEGER *)$a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImage *)) GdipDisposeImage)
								((GpImage *) $a_image);
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
