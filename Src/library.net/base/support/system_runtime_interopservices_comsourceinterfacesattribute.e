indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.ComSourceInterfacesAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_COMSOURCEINTERFACESATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_com_source_interfaces_attribute_3,
	make_com_source_interfaces_attribute_1,
	make_com_source_interfaces_attribute,
	make_com_source_interfaces_attribute_4,
	make_com_source_interfaces_attribute_2

feature {NONE} -- Initialization

	frozen make_com_source_interfaces_attribute_3 (sourceInterface1: SYSTEM_TYPE; sourceInterface2: SYSTEM_TYPE; sourceInterface3: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type, System.Type, System.Type) use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		end

	frozen make_com_source_interfaces_attribute_1 (sourceInterface: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		end

	frozen make_com_source_interfaces_attribute (sourceInterfaces: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		end

	frozen make_com_source_interfaces_attribute_4 (sourceInterface1: SYSTEM_TYPE; sourceInterface2: SYSTEM_TYPE; sourceInterface3: SYSTEM_TYPE; sourceInterface4: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type, System.Type, System.Type, System.Type) use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		end

	frozen make_com_source_interfaces_attribute_2 (sourceInterface1: SYSTEM_TYPE; sourceInterface2: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type, System.Type) use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		end

feature -- Access

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_COMSOURCEINTERFACESATTRIBUTE
