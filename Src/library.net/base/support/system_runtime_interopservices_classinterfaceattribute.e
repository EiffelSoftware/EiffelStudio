indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.ClassInterfaceAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_class_interface_attribute_1,
	make_class_interface_attribute

feature {NONE} -- Initialization

	frozen make_class_interface_attribute_1 (classInterfaceType: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.ClassInterfaceAttribute"
		end

	frozen make_class_interface_attribute (class_interface_type: INTEGER) is
			-- Valid values for `class_interface_type' are:
			-- None = 0
			-- AutoDispatch = 1
			-- AutoDual = 2
		require
			valid_class_interface_type: class_interface_type = 0 or class_interface_type = 1 or class_interface_type = 2
		external
			"IL creator signature (enum System.Runtime.InteropServices.ClassInterfaceType) use System.Runtime.InteropServices.ClassInterfaceAttribute"
		end

feature -- Access

	frozen get_value: INTEGER is
		external
			"IL signature (): enum System.Runtime.InteropServices.ClassInterfaceType use System.Runtime.InteropServices.ClassInterfaceAttribute"
		alias
			"get_Value"
		ensure
			valid_class_interface_type: Result = 0 or Result = 1 or Result = 2
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE
