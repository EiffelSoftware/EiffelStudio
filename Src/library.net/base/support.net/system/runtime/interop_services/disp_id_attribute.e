indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.DispIdAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	DISP_ID_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_disp_id_attribute

feature {NONE} -- Initialization

	frozen make_disp_id_attribute (disp_id: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Runtime.InteropServices.DispIdAttribute"
		end

feature -- Access

	frozen get_value: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.DispIdAttribute"
		alias
			"get_Value"
		end

end -- class DISP_ID_ATTRIBUTE
