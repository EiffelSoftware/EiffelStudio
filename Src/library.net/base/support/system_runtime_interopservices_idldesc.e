indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.IDLDESC"

frozen expanded external class
	SYSTEM_RUNTIME_INTEROPSERVICES_IDLDESC

inherit
	SYSTEM_VALUETYPE

feature -- Access

	frozen dw_reserved: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.IDLDESC"
		alias
			"dwReserved"
		end

	frozen w_idl_flags: INTEGER_16 is
		external
			"IL field signature :System.Runtime.InteropServices.IDLFLAG use System.Runtime.InteropServices.IDLDESC"
		alias
			"wIDLFlags"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_IDLDESC
