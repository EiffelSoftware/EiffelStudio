indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.StructLayoutAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_STRUCTLAYOUTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_structlayoutattribute,
	make_structlayoutattribute_1

feature {NONE} -- Initialization

	frozen make_structlayoutattribute (layout_kind: SYSTEM_RUNTIME_INTEROPSERVICES_LAYOUTKIND) is
		external
			"IL creator signature (System.Runtime.InteropServices.LayoutKind) use System.Runtime.InteropServices.StructLayoutAttribute"
		end

	frozen make_structlayoutattribute_1 (layout_kind: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.StructLayoutAttribute"
		end

feature -- Access

	frozen get_value: SYSTEM_RUNTIME_INTEROPSERVICES_LAYOUTKIND is
		external
			"IL signature (): System.Runtime.InteropServices.LayoutKind use System.Runtime.InteropServices.StructLayoutAttribute"
		alias
			"get_Value"
		end

	frozen char_set: SYSTEM_RUNTIME_INTEROPSERVICES_CHARSET is
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

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_STRUCTLAYOUTATTRIBUTE
