indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ClassInterfaceAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	CLASS_INTERFACE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_class_interface_attribute_1,
	make_class_interface_attribute

feature {NONE} -- Initialization

	frozen make_class_interface_attribute_1 (class_interface_type: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.ClassInterfaceAttribute"
		end

	frozen make_class_interface_attribute (class_interface_type: CLASS_INTERFACE_TYPE) is
		external
			"IL creator signature (System.Runtime.InteropServices.ClassInterfaceType) use System.Runtime.InteropServices.ClassInterfaceAttribute"
		end

feature -- Access

	frozen get_value: CLASS_INTERFACE_TYPE is
		external
			"IL signature (): System.Runtime.InteropServices.ClassInterfaceType use System.Runtime.InteropServices.ClassInterfaceAttribute"
		alias
			"get_Value"
		end

end -- class CLASS_INTERFACE_ATTRIBUTE
