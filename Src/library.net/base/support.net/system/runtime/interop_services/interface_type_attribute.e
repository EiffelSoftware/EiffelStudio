indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.InterfaceTypeAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	INTERFACE_TYPE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_interface_type_attribute_1,
	make_interface_type_attribute

feature {NONE} -- Initialization

	frozen make_interface_type_attribute_1 (interface_type: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.InterfaceTypeAttribute"
		end

	frozen make_interface_type_attribute (interface_type: COM_INTERFACE_TYPE) is
		external
			"IL creator signature (System.Runtime.InteropServices.ComInterfaceType) use System.Runtime.InteropServices.InterfaceTypeAttribute"
		end

feature -- Access

	frozen get_value: COM_INTERFACE_TYPE is
		external
			"IL signature (): System.Runtime.InteropServices.ComInterfaceType use System.Runtime.InteropServices.InterfaceTypeAttribute"
		alias
			"get_Value"
		end

end -- class INTERFACE_TYPE_ATTRIBUTE
