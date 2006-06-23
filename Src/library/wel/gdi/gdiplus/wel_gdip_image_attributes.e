indexing
	description: "Gdi+ image attributes functions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_IMAGE_ATTRIBUTES

inherit
	WEL_GDIP_ANY
		redefine
			delete
		end

create
	make

feature -- Initlization

	make is
			-- Creation method
		local
			l_result: INTEGER
		do
			c_gdip_create_image_attributes ($item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Command

	clear_color_key is
			-- Clear color key
		do
			clear_color_key_with_type ({WEL_GDIP_COLOR_ADJUST_TYPE}.coloradjusttypedefault)
		end

	clear_color_key_with_type (a_type: INTEGER) is
			-- Clear color key with `a_type'
		require
			valid: (create {WEL_GDIP_COLOR_ADJUST_TYPE}).is_valid (a_type)
		local
			l_result: INTEGER
		do
			c_gdip_set_image_attributes_color_keys (item, a_type, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	set_color_matrix (a_color_matrix: WEL_COLOR_MATRIX) is
			-- Set color matrix to `a_color_matrix'
		require
			not_void: a_color_matrix /= Void
		do
			set_color_matrix_with_flag (a_color_matrix, {WEL_GDIP_COLOR_ADJUST_TYPE}.coloradjusttypedefault, {WEL_GDIP_COLOR_MATRIX_FLAGS}.colormatrixflagsdefault)
		end

	set_color_matrix_with_flag (a_color_matrix: WEL_COLOR_MATRIX; a_color_matrix_adjust_type: INTEGER; a_color_matrix_flags: INTEGER) is
			-- Set `a_color_matrix' with `a_color_matrix_flags'
		require
			not_void: a_color_matrix /= Void
			valid: (create {WEL_GDIP_COLOR_ADJUST_TYPE}).is_valid (a_color_matrix_adjust_type)
			valid: (create {WEL_GDIP_COLOR_MATRIX_FLAGS}).is_valid (a_color_matrix_flags)
		local
			l_result: INTEGER
		do
			c_gdip_set_image_attributes_color_matrix (item, a_color_matrix.item.item, a_color_matrix_adjust_type, a_color_matrix_flags, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Destory

	delete is
			-- Destory Gdi+ object.
		local
			l_result: INTEGER
		do
			c_gdip_dispose_image_attributes (item, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature {NONE} -- C externals

	c_gdip_create_image_attributes (a_result_image_attributes: TYPED_POINTER [POINTER]; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Create `a_result_image_attributes'
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipCreateImageAttributes = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipCreateImageAttributes = GetProcAddress (user32_module, "GdipCreateImageAttributes");
					if (GdipCreateImageAttributes) {			
						*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImageAttributes **)) GdipCreateImageAttributes)
									((GpImageAttributes **) $a_result_image_attributes);
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

	c_gdip_dispose_image_attributes (a_image_attributes: POINTER; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Dispose `a_image_attributes'
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipDisposeImageAttributes = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipDisposeImageAttributes = GetProcAddress (user32_module, "GdipDisposeImageAttributes");
					if (GdipDisposeImageAttributes) {			
						*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImageAttributes *)) GdipDisposeImageAttributes)
									((GpImageAttributes *) $a_image_attributes);
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

	c_gdip_set_image_attributes_color_keys (a_image_attributes: POINTER; a_color_adjust_type: INTEGER; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Set image attributes color keys.
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipSetImageAttributesColorKeys = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipSetImageAttributesColorKeys = GetProcAddress (user32_module, "GdipSetImageAttributesColorKeys");
					if (GdipSetImageAttributesColorKeys) {			
						*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImageAttributes *, ColorAdjustType, BOOL, ARGB, ARGB)) GdipSetImageAttributesColorKeys)
									((GpImageAttributes *) $a_image_attributes,
									(ColorAdjustType) $a_color_adjust_type,
									(BOOL) FALSE,
									(ARGB) 0,
									(ARGB) 0);
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

	c_gdip_set_image_attributes_color_matrix (a_image_attributes: POINTER; a_new_color_matrix: POINTER; a_color_adjust_type: INTEGER; a_color_matrix_flag: INTEGER; a_result_status: TYPED_POINTER [INTEGER]) is
			-- Set `a_image_attributes''s color matrix.
		external
			"C inline use <gdiplus.h>"
		alias
			"[
			{
				FARPROC GdipSetImageAttributesColorMatrix = NULL;
				HMODULE user32_module = LoadLibrary (L"Gdiplus.dll");
				*(EIF_INTEGER *) $a_result_status = 1;
				if (user32_module) {
					GdipSetImageAttributesColorMatrix = GetProcAddress (user32_module, "GdipSetImageAttributesColorMatrix");
					if (GdipSetImageAttributesColorMatrix) {			
						*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImageAttributes *, ColorAdjustType, BOOL, GDIPCONST ColorMatrix*, GDIPCONST ColorMatrix*, ColorMatrixFlags)) GdipSetImageAttributesColorMatrix)
									((GpImageAttributes *) $a_image_attributes,
									(ColorAdjustType) $a_color_adjust_type,
									(BOOL) TRUE,
									(ColorMatrix*) $a_new_color_matrix,
									(ColorMatrix*) NULL,
									(ColorMatrixFlags) $a_color_matrix_flag);
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
