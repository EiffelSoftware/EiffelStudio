indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Border3DSide"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_BORDER3_DSIDE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen all_: WINFORMS_BORDER3_DSIDE is
		external
			"IL enum signature :System.Windows.Forms.Border3DSide use System.Windows.Forms.Border3DSide"
		alias
			"2063"
		end

	frozen right: WINFORMS_BORDER3_DSIDE is
		external
			"IL enum signature :System.Windows.Forms.Border3DSide use System.Windows.Forms.Border3DSide"
		alias
			"4"
		end

	frozen top: WINFORMS_BORDER3_DSIDE is
		external
			"IL enum signature :System.Windows.Forms.Border3DSide use System.Windows.Forms.Border3DSide"
		alias
			"2"
		end

	frozen bottom: WINFORMS_BORDER3_DSIDE is
		external
			"IL enum signature :System.Windows.Forms.Border3DSide use System.Windows.Forms.Border3DSide"
		alias
			"8"
		end

	frozen left: WINFORMS_BORDER3_DSIDE is
		external
			"IL enum signature :System.Windows.Forms.Border3DSide use System.Windows.Forms.Border3DSide"
		alias
			"1"
		end

	frozen middle: WINFORMS_BORDER3_DSIDE is
		external
			"IL enum signature :System.Windows.Forms.Border3DSide use System.Windows.Forms.Border3DSide"
		alias
			"2048"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class WINFORMS_BORDER3_DSIDE
