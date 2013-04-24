note
	description: "[
					Property variant parameter used by CCommandHandler Execute and UpdateProperty
					
					typedef struct PROPVARIANT {
					  VARTYPE vt;
					  WORD    wReserved1;
					  WORD    wReserved2;
					  WORD    wReserved3;
					  union {....} ;
					} PROPVARIANT;
																									]"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PROPERTY_VARIANT

create
	share_from_pointer,
	make_empty

feature {NONE}  -- Initialization

	share_from_pointer (a_property_variant: POINTER)
			-- Creation method
		do
			create managed_pointer.share_from_pointer (a_property_variant, size)
		end

	make_empty
			-- Create an empty property variant
		do
			create managed_pointer.make (size)
		end

feature -- Access

	item: POINTER
			-- Associated C memory.
		do
			Result := managed_pointer.item
		end

	managed_pointer: MANAGED_POINTER
			-- The property variant structure.

	size: INTEGER
			-- Size of struct PROPVARIANT
		external
			"C inline use <common.h>"
		alias
			"[
			{
				return sizeof (PROPVARIANT);
			}
			]"
		end

feature -- Command

	set_boolean_value (a_value: BOOLEAN)
			-- Set value with `a_value'
		do
			c_init_prop_variant_from_boolean (item, a_value)
		end

	set_string_value (a_value: STRING_32)
			-- Set value with `a_value'
		local
			l_wel_string: WEL_STRING
		do
			create l_wel_string.make (a_value)
			c_init_prop_variant_from_string (item, l_wel_string.item)
			-- FIXME: should call CoTaskMemFree to free string?
		end

	set_decimal_value (a_value: REAL_64)
			-- Set value with `a_value'
		do
			c_init_prop_variant_from_decimal (item, a_value)
		end

	set_image (a_image: EV_PIXEL_BUFFER)
			-- Set value with `a_value'
		local
			l_bitmap: WEL_BITMAP
			l_iui_image: POINTER
		do
			-- Convert to IUIImage
			if attached {EV_PIXEL_BUFFER_IMP} a_image.implementation as l_imp then
				if attached l_imp.gdip_bitmap as l_gdip_bitmap then
					l_bitmap := l_gdip_bitmap.new_bitmap
					c_create_iui_image (l_bitmap.item, $l_iui_image)
				end
			end

			if l_iui_image /= default_pointer then
				c_init_prop_variant_from_iunknown (item, l_iui_image)
			end
		end

	set_uint32 (a_natural: NATURAL_32)
			-- Set value with `a_natural'
		do
			c_init_prop_variant_from_uint32 (item, a_natural)
		end

	set_safe_array (a_list: ARRAYED_LIST [EV_SIMPLE_PROPERTY_SET])
			-- Set value with `a_safe_array'
		require
			not_void: a_list /= Void
		local
			l_safe_array: EV_RIBBON_SAFE_ARRAY
		do
			create l_safe_array.make (a_list)
			c_init_prop_variant_from_iunknown_array (item, l_safe_array.psa)
		end

	destroy
			-- clean up current
		do
			c_prop_variant_clear (item)
		end

feature -- Query

	var_type: NATURAL_16
			-- Value type tag.
		do
			Result := c_var_type (item)
		end

	boolean_value: BOOLEAN
			-- Value type is based on `var_type'
		do
			c_read_boolean (item, $Result)
		end

	string_value: STRING_32
			-- String value of current
		local
			l_wel_string: WEL_STRING
			l_pointer: POINTER
		do
			c_read_string (item, $l_pointer)
			create l_wel_string.make_by_pointer (l_pointer)
			Result := l_wel_string.string
		end

	decimal_value: REAL_64
			-- Decimal value of current
		do
			Result := c_read_decimal (item)
		end

	uint32_value: NATURAL_32
			-- Natural value of current
		do
			Result := c_read_uint32 (item)
		end

	iunknown_value: POINTER
			-- IUnknown value
		do
			Result := c_read_iunknown (item)
		end

feature {NONE} -- Externals

	c_var_type (a_property_variant: POINTER): NATURAL_16
			-- Value type tag.
		external
			"C inline use <common.h>"
		alias
			"[
			{
				PROPVARIANT *l_property_variant;
				l_property_variant = (PROPVARIANT *)$a_property_variant;
				return (EIF_NATURAL_16)(l_property_variant -> vt);				
			}
			]"
		end

	c_read_boolean (a_item: POINTER; a_result: TYPED_POINTER [BOOLEAN])
			-- Read boolean value from `a_item'
			-- The result is available in `a_result'
		external
			"C inline use <common.h>"
		alias
			"[
			{
				//PropVariantToBoolean ($a_item, $a_result);
				PROPVARIANT *ppropvar = (PROPVARIANT *) $a_item;
				if ((ppropvar->boolVal) == VARIANT_TRUE)
				{
					*($a_result) = EIF_TRUE;
				}else
				{
					*($a_result) = EIF_FALSE;
				}			
			}
			]"
		end

	c_read_string (a_item: POINTER; a_pwstr: TYPED_POINTER [POINTER])
			-- Read string value from `a_item'
			-- The result is available in `a_pwstr'			
		external
			"C inline use <common.h>"
		alias
			"[
			{
				//PropVariantToStringAlloc ($a_item, $a_pwstr);
				PROPVARIANT *ppropvar = (PROPVARIANT *) $a_item;
				*($a_pwstr) = ppropvar->pwszVal;
			}
			]"
		end

	c_read_decimal (a_item: POINTER): REAL_64
			-- Read decimal value from `a_item'
		external
			"C inline use <common.h>"
		alias
			"{
				DOUBLE val;
				VarR8FromDec(&((PROPVARIANT *) $a_item)->decVal, &val);
				return val;
			}"
		end

	c_read_uint32 (a_item: POINTER): NATURAL_32
			-- Read uint32 value from `a_item'
		external
			"C inline use <common.h>"
		alias
			"{
				PROPVARIANT *ppropvar = (PROPVARIANT *) $a_item;
				return ppropvar->ulVal;
			}"
		end

	c_read_iunknown (a_item: POINTER): POINTER
			-- Read iunknown from `a_item'
		external
			"C inline use <common.h>"
		alias
			"{
				PROPVARIANT *ppropvar = (PROPVARIANT *) $a_item;
				return ppropvar->punkVal;
			}"
		end

	c_co_task_mem_free (a_pointer: POINTER)
			-- Frees a block of task memory previously allocated through a call to the CoTaskMemAlloc or CoTaskMemRealloc function
		external
			"C inline use %"Objbase.h%""
		alias
			"CoTaskMemFree ($a_pointer);"
		end

	c_init_prop_variant_from_boolean (a_item: POINTER; a_value: BOOLEAN)
			-- Initializes a given PROPVARIANT structure as a VT_BOOL using a specified Boolean value.
		external
			"C inline use <common.h>"
		alias
			"[
			{
				//InitPropVariantFromBoolean only available for C++
				PROPVARIANT *ppropvar = (PROPVARIANT *) $a_item;
				ppropvar->vt = VT_BOOL;
				ppropvar->boolVal = $a_value ? VARIANT_TRUE : VARIANT_FALSE;
			}
			]"
		end

	c_init_prop_variant_from_string (a_item: POINTER; a_string: POINTER)
			-- Initializes a PROPVARIANT structure based on a specified string.
		external
			"C inline use <common.h>"
		alias
			"[
			{
				//InitPropVariantFromString only available for C++
				HRESULT hr;
				PROPVARIANT *ppropvar = (PROPVARIANT *) $a_item;
				ppropvar->vt = VT_LPWSTR;
				hr = SHStrDupW_eiffel($a_string, &ppropvar->pwszVal);
				if (FAILED(hr))	{
					PropVariantInit(ppropvar);
				}
			}
			]"
		end

	c_init_prop_variant_from_decimal (a_item: POINTER; a_value: REAL_64)
			-- Initializes a PROPVARIANT structure based on a decimal value
		external
			"C inline use <common.h>"
		alias
			"[
			{
				PROPVARIANT *ppropvar = (PROPVARIANT *) $a_item;
				ppropvar->vt = VT_DECIMAL;
				VarDecFromR8($a_value, &ppropvar->decVal);
			}
			]"
		end

	c_init_prop_variant_from_uint32 (a_item: POINTER; a_value: NATURAL_32)
			-- Initializes a PROPVARIANT structure based on a 32-bit unsigned integer value.
		external
			"C inline use <common.h>"
		alias
			"[
			{
				//InitPropVariantFromUInt32 only available for C++
				PROPVARIANT *ppropvar = (PROPVARIANT *) $a_item;
				ppropvar->vt = VT_UI4;
				ppropvar->ulVal = $a_value;
			}
			]"
		end

	c_init_prop_variant_from_iunknown (a_item: POINTER; a_iunknown: POINTER)
			-- Initializes a PROPVARIANT structure based on `a_iunknown'
		external
			"C inline use <common.h>"
		alias
			"[
			{
				PROPVARIANT *ppropvar = (PROPVARIANT *) $a_item;
				ppropvar->vt = VT_UNKNOWN;
				ppropvar->punkVal = (IUnknown *)$a_iunknown;
			}
			]"
		end

	c_init_prop_variant_from_iunknown_array (a_item: POINTER; a_psa: POINTER)
			-- Initializes a PROPVARIANT structure based on iunknow array
		external
			"C inline use <common.h>"
		alias
			"[
			{
				PROPVARIANT *ppropvar = (PROPVARIANT *) $a_item;
				ppropvar->vt = VT_ARRAY | VT_UNKNOWN;
				ppropvar->punkVal = (IUnknown *)$a_psa;	
			}
			]"
		end

	c_prop_variant_clear (a_item: POINTER)
			-- Clears a PROPVARIANT structure.
		external
			"C inline use <common.h>"
		alias
			"[
			{
				PropVariantClear ((PROPVARIANT *)$a_item);
			}
			]"
		end

	c_create_iui_image (a_hbitmap: POINTER; a_result_iui_image: TYPED_POINTER [POINTER])
			-- Create a IUIImage from a HBITMAP
		external
			"C inline use %"common.h%""
		alias
			"[
			{
				CreateIUIImageFromBitmap ((HBITMAP) $a_hbitmap, (IUIImage **) $a_result_iui_image);
			}
			]"
		end
note
	copyright: "Copyright (c) 1984-2011, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
