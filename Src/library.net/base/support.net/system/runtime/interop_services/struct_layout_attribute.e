indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.StructLayoutAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	STRUCT_LAYOUT_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_struct_layout_attribute,
	make_struct_layout_attribute_1

feature {NONE} -- Initialization

	frozen make_struct_layout_attribute (layout_kind: LAYOUT_KIND) is
		external
			"IL creator signature (System.Runtime.InteropServices.LayoutKind) use System.Runtime.InteropServices.StructLayoutAttribute"
		end

	frozen make_struct_layout_attribute_1 (layout_kind: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.StructLayoutAttribute"
		end

feature -- Access

	frozen get_value: LAYOUT_KIND is
		external
			"IL signature (): System.Runtime.InteropServices.LayoutKind use System.Runtime.InteropServices.StructLayoutAttribute"
		alias
			"get_Value"
		end

	frozen char_set: CHAR_SET is
		external
			"IL field signature :System.Runtime.InteropServices.CharSet use System.Runtime.InteropServices.StructLayoutAttribute"
		alias
			"CharSet"
		end

	frozen size: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.StructLayoutAttribute"
		alias
			"Size"
		end

	frozen pack: INTEGER is
		external
			"IL field signature :System.Int32 use System.Runtime.InteropServices.StructLayoutAttribute"
		alias
			"Pack"
		end

end -- class STRUCT_LAYOUT_ATTRIBUTE
