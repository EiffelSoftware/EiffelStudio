indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.ClassInterfaceAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_classinterfaceattribute_1,
	make_classinterfaceattribute

feature {NONE} -- Initialization

	frozen make_classinterfaceattribute_1 (class_interface_type: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.ClassInterfaceAttribute"
		end

	frozen make_classinterfaceattribute (class_interface_type: SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE) is
		external
			"IL creator signature (System.Runtime.InteropServices.ClassInterfaceType) use System.Runtime.InteropServices.ClassInterfaceAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACETYPE is
		external
			"IL signature (): System.Runtime.InteropServices.ClassInterfaceType use System.Runtime.InteropServices.ClassInterfaceAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_CLASSINTERFACEATTRIBUTE
