indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.DispIdAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_DISPIDATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_dispid_attribute

feature {NONE} -- Initialization

	frozen make_dispid_attribute (dispId: INTEGER) is
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

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_DISPIDATTRIBUTE
