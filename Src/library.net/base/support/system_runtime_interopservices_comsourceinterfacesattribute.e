indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.ComSourceInterfacesAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_COMSOURCEINTERFACESATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_comsourceinterfacesattribute_3,
	make_comsourceinterfacesattribute_1,
	make_comsourceinterfacesattribute,
	make_comsourceinterfacesattribute_4,
	make_comsourceinterfacesattribute_2

feature {NONE} -- Initialization

	frozen make_comsourceinterfacesattribute_3 (source_interface1: SYSTEM_TYPE; source_interface2: SYSTEM_TYPE; source_interface3: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type, System.Type, System.Type) use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		end

	frozen make_comsourceinterfacesattribute_1 (source_interface: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		end

	frozen make_comsourceinterfacesattribute (source_interfaces: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		end

	frozen make_comsourceinterfacesattribute_4 (source_interface1: SYSTEM_TYPE; source_interface2: SYSTEM_TYPE; source_interface3: SYSTEM_TYPE; source_interface4: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type, System.Type, System.Type, System.Type) use System.Runtime.InteropServices.ComSourceInterfacesAttribute"
		end

	frozen make_comsourceinterfacesattribute_2 (source_interface1: SYSTEM_TYPE; source_interface2: SYSTEM_TYPE) is
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
