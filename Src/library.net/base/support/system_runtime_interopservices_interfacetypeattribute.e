indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.InterfaceTypeAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_INTERFACETYPEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_interfacetypeattribute,
	make_interfacetypeattribute_1

feature {NONE} -- Initialization

	frozen make_interfacetypeattribute (interface_type: SYSTEM_RUNTIME_INTEROPSERVICES_COMINTERFACETYPE) is
		external
			"IL creator signature (System.Runtime.InteropServices.ComInterfaceType) use System.Runtime.InteropServices.InterfaceTypeAttribute"
		end

	frozen make_interfacetypeattribute_1 (interface_type: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.InterfaceTypeAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_RUNTIME_INTEROPSERVICES_COMINTERFACETYPE is
		external
			"IL signature (): System.Runtime.InteropServices.ComInterfaceType use System.Runtime.InteropServices.InterfaceTypeAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_INTERFACETYPEATTRIBUTE
