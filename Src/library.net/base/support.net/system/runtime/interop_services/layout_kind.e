indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.LayoutKind"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	LAYOUT_KIND

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen sequential: LAYOUT_KIND is
		external
			"IL enum signature :System.Runtime.InteropServices.LayoutKind use System.Runtime.InteropServices.LayoutKind"
		alias
			"0"
		end

	frozen auto: LAYOUT_KIND is
		external
			"IL enum signature :System.Runtime.InteropServices.LayoutKind use System.Runtime.InteropServices.LayoutKind"
		alias
			"3"
		end

	frozen explicit: LAYOUT_KIND is
		external
			"IL enum signature :System.Runtime.InteropServices.LayoutKind use System.Runtime.InteropServices.LayoutKind"
		alias
			"2"
		end

end -- class LAYOUT_KIND
