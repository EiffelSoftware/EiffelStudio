indexing
	description: "Implemented `IEnumClusterProp' Interface."
	date: "$Date$"
	revision: "$Revision$"

class
	CLUSTER_PROP_ENUMERATOR

inherit
	IENUM_CLUSTER_PROP_INTERFACE

	ECOM_STUB

	IENUM_STUB [IEIFFEL_CLUSTER_PROPERTIES_INTERFACE]

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
			"C++ [new ecom_eiffel_compiler::IEnumClusterProp_impl_stub %"ecom_eiffel_compiler_IEnumClusterProp_impl_stub_s.h%"](EIF_OBJECT)"
		end

end -- CLUSTER_PROP_ENUMERATOR

