indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.IDLDESC"

frozen expanded external class
	SYSTEM_RUNTIME_INTEROPSERVICES_IDLDESC

inherit
	VALUE_TYPE

feature -- Access

	frozen dw_reserved: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.IDLDESC"
		alias
			"dwReserved"
		end

	frozen w_idlflags: SYSTEM_RUNTIME_INTEROPSERVICES_IDLFLAG is
		external
			"IL field signature :System.Runtime.InteropServices.IDLFLAG use System.Runtime.InteropServices.IDLDESC"
		alias
			"wIDLFlags"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_IDLDESC
