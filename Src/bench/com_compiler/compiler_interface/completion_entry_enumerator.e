indexing
	description: "Completion entries enumerator"
	date: "$Date$"
	revision: "$Revision$"

class
	COMPLETION_ENTRY_ENUMERATOR

inherit
	IENUM_COMPLETION_ENTRY_INTERFACE

	ECOM_STUB
	
	IENUM_STUB [IEIFFEL_COMPLETION_ENTRY_INTERFACE]

create 
	make

feature -- Basic Operations

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: like Current): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_eiffel_compiler::IEnumFeature_impl_stub %"ecom_eiffel_compiler_IEnumFeature_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- class COMPLETION_ENTRY_ENUMERATOR
