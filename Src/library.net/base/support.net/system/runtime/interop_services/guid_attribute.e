indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.GuidAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	GUID_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_guid_attribute

feature {NONE} -- Initialization

	frozen make_guid_attribute (guid: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.InteropServices.GuidAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.InteropServices.GuidAttribute"
		alias
			"get_Value"
		end

end -- class GUID_ATTRIBUTE
