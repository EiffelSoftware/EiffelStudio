indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ComSourceInterfacesAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	COM_SOURCE_INTERFACES_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_com_source_interfaces_attribute_4,
	make_com_source_interfaces_attribute_1,
	make_com_source_interfaces_attribute_3,
	make_com_source_interfaces_attribute,
	make_com_source_interfaces_attribute_2

feature {NONE} -- Initialization

	frozen make_com_source_interfaces_attribute_4 (source_interface1: TYPE; source_interface2: TYPE; source_interface3: TYPE; source_interface4: TYPE) is
		external
			"IL creator signature (System.Type, System.Type, System.Type, System.Type) use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		end

	frozen make_com_source_interfaces_attribute_1 (source_interface: TYPE) is
		external
			"IL creator signature (System.Type) use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		end

	frozen make_com_source_interfaces_attribute_3 (source_interface1: TYPE; source_interface2: TYPE; source_interface3: TYPE) is
		external
			"IL creator signature (System.Type, System.Type, System.Type) use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		end

	frozen make_com_source_interfaces_attribute (source_interfaces: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		end

	frozen make_com_source_interfaces_attribute_2 (source_interface1: TYPE; source_interface2: TYPE) is
		external
			"IL creator signature (System.Type, System.Type) use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		alias
			"get_Value"
		end

end -- class COM_SOURCE_INTERFACES_ATTRIBUTE
