note
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
			destroy_item
		end

create
	make

feature -- Initlization

	make
			-- Creation method
		local
			l_result: INTEGER
		do
			default_create
			item := c_gdip_create_image_attributes (gdi_plus_handle, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Command

	clear_color_key
			-- Clear color key
		do
			clear_color_key_with_type ({WEL_GDIP_COLOR_ADJUST_TYPE}.coloradjusttypedefault)
		end

	clear_color_key_with_type (a_type: INTEGER)
			-- Clear color key with `a_type'
		require
			valid: (create {WEL_GDIP_COLOR_ADJUST_TYPE}).is_valid (a_type)
		local
			l_result: INTEGER
		do
			c_gdip_set_image_attributes_color_keys (gdi_plus_handle, item, a_type, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

	set_color_matrix (a_color_matrix: WEL_COLOR_MATRIX)
			-- Set color matrix to `a_color_matrix'
		require
			not_void: a_color_matrix /= Void
		do
			set_color_matrix_with_flag (a_color_matrix, {WEL_GDIP_COLOR_ADJUST_TYPE}.coloradjusttypedefault, {WEL_GDIP_COLOR_MATRIX_FLAGS}.colormatrixflagsdefault)
		end

	set_color_matrix_with_flag (a_color_matrix: WEL_COLOR_MATRIX; a_color_matrix_adjust_type: INTEGER; a_color_matrix_flags: INTEGER)
			-- Set `a_color_matrix' with `a_color_matrix_flags'
		require
			not_void: a_color_matrix /= Void
			valid: (create {WEL_GDIP_COLOR_ADJUST_TYPE}).is_valid (a_color_matrix_adjust_type)
			valid: (create {WEL_GDIP_COLOR_MATRIX_FLAGS}).is_valid (a_color_matrix_flags)
		local
			l_result: INTEGER
		do
			c_gdip_set_image_attributes_color_matrix (gdi_plus_handle, item, a_color_matrix.item, a_color_matrix_adjust_type, a_color_matrix_flags, $l_result)
			check ok: l_result = {WEL_GDIP_STATUS}.ok end
		end

feature -- Destory

	destroy_item
			-- Destory Gdi+ object.
		local
			l_result: INTEGER
		do
			if item /= default_pointer then
				c_gdip_dispose_image_attributes (gdi_plus_handle, item, $l_result)
				check ok: l_result = {WEL_GDIP_STATUS}.ok end
				item := default_pointer
			end
		end

feature {NONE} -- C externals

	c_gdip_create_image_attributes (a_gdiplus_handle: POINTER; a_result_status: TYPED_POINTER [INTEGER]): POINTER
			-- Create `a_result_image_attributes'
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipCreateImageAttributes = NULL;
				GpImageAttributes *l_result = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipCreateImageAttributes) {
					GdipCreateImageAttributes = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipCreateImageAttributes");
				}			
				if (GdipCreateImageAttributes) {			
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImageAttributes **)) GdipCreateImageAttributes)
								((GpImageAttributes **) &l_result);
				}					
				return (EIF_POINTER)l_result;
			}
			]"
		end

	c_gdip_dispose_image_attributes (a_gdiplus_handle: POINTER; a_image_attributes: POINTER; a_result_status: TYPED_POINTER [INTEGER])
			-- Dispose `a_image_attributes'
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_image_attributes_not_null: a_image_attributes /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipDisposeImageAttributes = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipDisposeImageAttributes) {
					GdipDisposeImageAttributes = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipDisposeImageAttributes");
				}		
				
				if (GdipDisposeImageAttributes) {			
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImageAttributes *)) GdipDisposeImageAttributes)
								((GpImageAttributes *) $a_image_attributes);
				}				
			}
			]"
		end

	c_gdip_set_image_attributes_color_keys (a_gdiplus_handle: POINTER; a_image_attributes: POINTER; a_color_adjust_type: INTEGER; a_result_status: TYPED_POINTER [INTEGER])
			-- Set image attributes color keys.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_image_attributes_not_null: a_image_attributes /= default_pointer
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipSetImageAttributesColorKeys = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipSetImageAttributesColorKeys) {
					GdipSetImageAttributesColorKeys = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipSetImageAttributesColorKeys");				
				}				
				if (GdipSetImageAttributesColorKeys) {			
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImageAttributes *, ColorAdjustType, BOOL, ARGB, ARGB)) GdipSetImageAttributesColorKeys)
								((GpImageAttributes *) $a_image_attributes,
								(ColorAdjustType) $a_color_adjust_type,
								(BOOL) FALSE,
								(ARGB) 0,
								(ARGB) 0);
				}				
			}
			]"
		end

	c_gdip_set_image_attributes_color_matrix (a_gdiplus_handle: POINTER; a_image_attributes: POINTER; a_new_color_matrix: POINTER; a_color_adjust_type: INTEGER; a_color_matrix_flag: INTEGER; a_result_status: TYPED_POINTER [INTEGER])
			-- Set `a_image_attributes''s color matrix.
		require
			a_gdiplus_handle_not_null: a_gdiplus_handle /= default_pointer
			a_image_attributes_not_null: a_image_attributes /= default_pointer
			a_new_color_matrix_not_null: a_new_color_matrix /= default_pointer
			a_color_adjust_type_valid: (create {WEL_GDIP_COLOR_ADJUST_TYPE}).is_valid (a_color_adjust_type)
			a_color_matrix_flag_valid: (create {WEL_GDIP_COLOR_MATRIX_FLAGS}).is_valid (a_color_matrix_flag)
		external
			"C inline use %"wel_gdi_plus.h%""
		alias
			"[
			{
				static FARPROC GdipSetImageAttributesColorMatrix = NULL;
				*(EIF_INTEGER *) $a_result_status = 1;
				
				if (!GdipSetImageAttributesColorMatrix) {
					GdipSetImageAttributesColorMatrix = GetProcAddress ((HMODULE) $a_gdiplus_handle, "GdipSetImageAttributesColorMatrix");			
				}						
				if (GdipSetImageAttributesColorMatrix) {			
					*(EIF_INTEGER *) $a_result_status = (FUNCTION_CAST_TYPE (GpStatus, WINGDIPAPI, (GpImageAttributes *, ColorAdjustType, BOOL, GDIPCONST ColorMatrix*, GDIPCONST ColorMatrix*, ColorMatrixFlags)) GdipSetImageAttributesColorMatrix)
								((GpImageAttributes *) $a_image_attributes,
								(ColorAdjustType) $a_color_adjust_type,
								(BOOL) TRUE,
								(ColorMatrix*) $a_new_color_matrix,
								(ColorMatrix*) NULL,
								(ColorMatrixFlags) $a_color_matrix_flag);
				}				
			}
			]"
		end

note
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
