indexing
	description: "Implemented `IEiffelEnumString' Interface."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_STRING_ENUMERATOR

inherit
	IEIFFEL_ENUM_STRING_INTERFACE

	ECOM_STUB

	IENUM_STUB [STRING]

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
			"C++ [new ecom_EiffelComCompiler::IEiffelEnumString_impl_stub %"ecom_EiffelComCompiler_IEiffelEnumString_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- class EIFFEL_STRING_ENUMERATOR
