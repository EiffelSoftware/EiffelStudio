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
end
