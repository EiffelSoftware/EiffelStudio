indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ComInterfaceType"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	COM_INTERFACE_TYPE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen interface_is_iunknown: COM_INTERFACE_TYPE is
		external
			"IL enum signature :System.Runtime.InteropServices.ComInterfaceType use System.Runtime.InteropServices.ComInterfaceType"
		alias
			"1"
		end

	frozen interface_is_dual: COM_INTERFACE_TYPE is
		external
			"IL enum signature :System.Runtime.InteropServices.ComInterfaceType use System.Runtime.InteropServices.ComInterfaceType"
		alias
			"0"
		end

	frozen interface_is_idispatch: COM_INTERFACE_TYPE is
		external
			"IL enum signature :System.Runtime.InteropServices.ComInterfaceType use System.Runtime.InteropServices.ComInterfaceType"
		alias
			"2"
		end

end -- class COM_INTERFACE_TYPE
