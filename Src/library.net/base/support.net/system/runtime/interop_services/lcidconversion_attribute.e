indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.LCIDConversionAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	LCIDCONVERSION_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_lcidconversion_attribute

feature {NONE} -- Initialization

	frozen make_lcidconversion_attribute (lcid: INTEGER) is
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

end -- class LCIDCONVERSION_ATTRIBUTE
