indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.VARDESC"

frozen expanded external class
	SYSTEM_RUNTIME_INTEROPSERVICES_VARDESC

inherit
	SYSTEM_VALUETYPE

feature -- Access

	frozen mem_id: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.VARDESC"
		alias
			"memid"
		end

	frozen lpstr_schema: STRING is
		external
			"IL field signature :System.String use System.Runtime.InteropServices.VARDESC"
		alias
			"lpstrSchema"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_VARDESC
