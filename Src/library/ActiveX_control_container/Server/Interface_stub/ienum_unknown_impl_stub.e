indexing
	description: "Implemented `IEnumUnknown' Interface."
	date: "$Date$"
	revision: "$Revision$"

class
	IENUM_UNKNOWN_IMPL_STUB

inherit
	IENUM_UNKNOWN_INTERFACE
	
	IENUM_IMPL [ECOM_INTERFACE]

	ECOM_STUB

create
	make
	
feature -- Basic Operations

	create_item is
			-- Initialize `item'
		do
			item := ccom_create_item (Current)
		end

feature {NONE}  -- Externals

	ccom_create_item (eif_object: IENUM_UNKNOWN_IMPL_STUB): POINTER is
			-- Initialize `item'
		external
			"C++ [new ecom_control_library::IEnumUnknown_impl_stub %"ecom_control_library_ienumunknown_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- IENUM_UNKNOWN_IMPL_STUB

