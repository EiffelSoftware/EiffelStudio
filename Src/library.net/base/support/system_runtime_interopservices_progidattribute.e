indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.ProgIdAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_PROGIDATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_progidattribute

feature {NONE} -- Initialization

	frozen make_progidattribute (prog_id: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.ProgIdAttribute"
		end

feature -- Access

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.ProgIdAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_PROGIDATTRIBUTE
