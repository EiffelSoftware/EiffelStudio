indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.IDLDESC"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	IDLDESC

inherit
	VALUE_TYPE

feature -- Access

	frozen dw_reserved: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.IDLDESC"
		alias
			"dwReserved"
		end

	frozen w_idlflags: IDLFLAG is
		external
			"IL field signature :System.Runtime.InteropServices.IDLFLAG use System.Runtime.InteropServices.IDLDESC"
		alias
			"wIDLFlags"
		end

end -- class IDLDESC
