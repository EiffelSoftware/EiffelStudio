indexing
	description: "Feature parameters used for language service"
	date: "$Date$"
	revision: "$Revision$"

class
	PARAMETER_ENUMERATOR

inherit
	IENUM_PARAMETER_INTERFACE
	
	ECOM_STUB
	
	IENUM_STUB [IEIFFEL_PARAMETER_DESCRIPTOR_INTERFACE]

create
	make

feature -- Basic Operations

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end
	
feature {NONE} -- Externals

	ccom_create_item (eif_object: like Current): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_eiffel_compiler::IEnumParameter_impl_stub %"ecom_eiffel_compiler_IEnumParameter_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- class PARAMETER_ENUMERATOR
