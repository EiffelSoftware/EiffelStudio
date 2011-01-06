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
	share_from_pointer

feature {NONE}  -- Initialization

	share_from_pointer (a_property_variant: POINTER)
			-- Creation method
		do
			pointer := a_property_variant
		end

feature -- Query

	var_type: NATURAL_16
			--
		do
			Result := c_var_type (pointer)
		end

	value
			-- Value type is based on `var_type'
		do

		end

feature {NONE}	-- Implementation

	pointer: POINTER
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

	c_read_xxx
			--
		do

		end
		
end
