indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.LCIDConversionAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_LCIDCONVERSIONATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_lcid_conversion_attribute

feature {NONE} -- Initialization

	frozen make_lcid_conversion_attribute (lcid: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Runtime.InteropServices.LCIDConversionAttribute"
		end

feature -- Access

	frozen get_value: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.LCIDConversionAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_LCIDCONVERSIONATTRIBUTE
