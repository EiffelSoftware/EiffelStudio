indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.GuidAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_GUIDATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_guidattribute

feature {NONE} -- Initialization

	frozen make_guidattribute (guid: STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.GuidAttribute"
		end

feature -- Access

	frozen get_value: STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.GuidAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_GUIDATTRIBUTE
