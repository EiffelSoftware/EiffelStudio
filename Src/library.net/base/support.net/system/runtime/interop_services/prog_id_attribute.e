indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ProgIdAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	PROG_ID_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_prog_id_attribute

feature {NONE} -- Initialization

	frozen make_prog_id_attribute (prog_id: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.ProgIdAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.ProgIdAttribute"
		alias
			"get_Value"
		end

end -- class PROG_ID_ATTRIBUTE
