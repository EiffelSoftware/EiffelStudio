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
