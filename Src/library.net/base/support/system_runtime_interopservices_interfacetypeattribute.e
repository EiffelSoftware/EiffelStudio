indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.InterfaceTypeAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_INTERFACETYPEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_interface_type_attribute,
	make_interface_type_attribute_1

feature {NONE} -- Initialization

	frozen make_interface_type_attribute (interface_type: INTEGER) is
			-- Valid values for `interface_type' are:
			-- InterfaceIsDual = 0
			-- InterfaceIsIUnknown = 1
			-- InterfaceIsIDispatch = 2
		require
			valid_com_interface_type: interface_type = 0 or interface_type = 1 or interface_type = 2
		external
			"IL creator signature (enum System.Runtime.InteropServices.ComInterfaceType) use System.Runtime.InteropServices.InterfaceTypeAttribute"
		end

	frozen make_interface_type_attribute_1 (interfaceType: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.InterfaceTypeAttribute"
		end

feature -- Access

	frozen get_value: INTEGER is
		external
			"IL signature (): enum System.Runtime.InteropServices.ComInterfaceType use System.Runtime.InteropServices.InterfaceTypeAttribute"
		alias
			"get_Value"
		ensure
			valid_com_interface_type: Result = 0 or Result = 1 or Result = 2
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_INTERFACETYPEATTRIBUTE
