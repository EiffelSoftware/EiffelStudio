indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.StructLayoutAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_STRUCTLAYOUTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_struct_layout_attribute,
	make_struct_layout_attribute_1

feature {NONE} -- Initialization

	frozen make_struct_layout_attribute (layout_kind: INTEGER) is
			-- Valid values for `layout_kind' are:
			-- Sequential = 0
			-- Explicit = 2
			-- Auto = 3
		require
			valid_layout_kind: layout_kind = 0 or layout_kind = 2 or layout_kind = 3
		external
			"IL creator signature (enum System.Runtime.InteropServices.LayoutKind) use System.Runtime.InteropServices.StructLayoutAttribute"
		end

	frozen make_struct_layout_attribute_1 (layoutKind: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.Runtime.InteropServices.StructLayoutAttribute"
		end

feature -- Access

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

	frozen get_value: INTEGER is
		external
			"IL signature (): enum System.Runtime.InteropServices.LayoutKind use System.Runtime.InteropServices.StructLayoutAttribute"
		alias
			"get_Value"
		ensure
			valid_layout_kind: Result = 0 or Result = 2 or Result = 3
		end

	frozen char_set: INTEGER is
		external
			"IL field signature :System.Runtime.InteropServices.CharSet use System.Runtime.InteropServices.StructLayoutAttribute"
		alias
			"CharSet"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_STRUCTLAYOUTATTRIBUTE
