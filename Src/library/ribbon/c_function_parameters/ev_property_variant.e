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
			create pointer.share_from_pointer (a_property_variant, size)
		end

	make_empty
			--
		do
			create pointer.make (size)
		end

feature -- Command

	set_boolean_value (a_value: BOOLEAN)
			-- Set value with `a_value'
		do
			c_init_prop_variant_from_boolean (pointer.item, a_value)
		end

	set_string_value (a_value: STRING_32)
			-- Set value with `a_value'
		local
			l_wel_string: WEL_STRING
		do
			create l_wel_string.make (a_value)
			c_init_prop_variant_from_string (pointer.item, l_wel_string.item)
		end

	set_decimal_value (a_value: REAL_64)
			-- Set value with `a_value'
		do
			c_init_prop_variant_from_decimal (pointer.item, a_value)
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
				c_init_prop_variant_from_iunknown (pointer.item, l_iui_image)
			end
		end

	set_uint32 (a_natural: NATURAL_32)
			-- Set value with `a_natural'
		do
			c_init_prop_variant_from_uint32 (pointer.item, a_natural)
		end

	destroy
			-- clean up current
		do
			c_prop_variant_clear (pointer.item)
		end

feature -- Query

	var_type: NATURAL_16
			--
		do
			Result := c_var_type (pointer.item)
		end

	boolean_value: BOOLEAN
			-- Value type is based on `var_type'
		do
			c_read_boolean (pointer.item, $Result)
		end

	string_value: STRING_32
			-- String value of current
		local
			l_wel_string: WEL_STRING
			l_pointer: POINTER
		do
			c_read_string (pointer.item, $l_pointer)
			create l_wel_string.make_by_pointer (l_pointer)
			Result := l_wel_string.string
			c_co_task_mem_free (l_pointer)
		end

	decimal_value: REAL_64
			-- Decimal value of current
		do
			c_read_decimal (pointer.item, $Result)
		end

	pointer: MANAGED_POINTER
			--
feature {NONE} -- Externals

	c_var_type (a_property_variant: POINTER): NATURAL_16
			--
		external
			"C inline use %"PropIdl.h%""
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
			--
		external
			"C inline use %"PropIdl.h%""
		alias
			"[
			{
				PropVariantToBoolean ($a_item, $a_result);
			}
			]"
		end

	c_read_string (a_item: POINTER; a_pwstr: TYPED_POINTER [POINTER])
			--
		external
			"C inline use %"Propvarutil.h%""
		alias
			"[
			{
				PropVariantToStringAlloc ($a_item, $a_pwstr);
			}
			]"
		end

	c_read_decimal (a_item: POINTER; a_result: TYPED_POINTER [REAL_64])
			--
		external
			"C inline use %"Propvarutil.h%""
		alias
			"[
			{
				DECIMAL * l_dec = (DECIMAL *)$a_item;
				*($a_result) = l_dec->Lo64;
			}
			]"
		end

	c_co_task_mem_free (a_pointer: POINTER)
			-- Frees a block of task memory previously allocated through a call to the CoTaskMemAlloc or CoTaskMemRealloc function
		external
			"C inline use %"Objbase.h%""
		alias
			"[
			{
				CoTaskMemFree ($a_pointer);
			}
			]"
		end

	c_init_prop_variant_from_boolean (a_item: POINTER; a_value: BOOLEAN)
			--
		external
			"C inline use %"Propvarutil.h%""
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
			--
		external
			"C inline use %"Shlwapi.h%""
		alias
			"[
			{
				//InitPropVariantFromString only available for C++
				HRESULT hr;
				PROPVARIANT *ppropvar = (PROPVARIANT *) $a_item;
				ppropvar->vt = VT_LPWSTR;
				hr = SHStrDupW($a_string, &ppropvar->pwszVal);
				if (FAILED(hr))
				{
				PropVariantInit(ppropvar);
				}
				return hr;
			}
			]"
		end

	c_init_prop_variant_from_decimal (a_item: POINTER; a_value: REAL_64)
			--
		external
			"C inline use %"Shlwapi.h%""
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
			--
		external
			"C inline use %"Propvarutil.h%""
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
			--
		external
			"C inline use %"Propidl.h%""
		alias
			"[
			{
				PROPVARIANT *ppropvar = (PROPVARIANT *) $a_item;
				ppropvar->vt = VT_UNKNOWN;
				ppropvar->punkVal = $a_iunknown;
			}
			]"
		end

	size: INTEGER
			--
		external
			"C inline use %"PropIdl.h%""
		alias
			"[
			{
				return sizeof (PROPVARIANT);
			}
			]"
		end

	c_prop_variant_clear (a_item: POINTER)
			--
		external
			"C inline use %"PropIdl.h%""
		alias
			"[
			{
				PropVariantClear ($a_item);
			}
			]"
		end

	c_create_iui_image (a_hbitmap: POINTER; a_result_iui_image: TYPED_POINTER [POINTER])
			--
		external
			"C inline use %"ribbon.h%""
		alias
			"[
			{
				CreateIUIImageFromBitmap ($a_hbitmap, $a_result_iui_image);
			}
			]"
		end
end
