indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.AnchorStyles"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_ANCHOR_STYLES

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen right: WINFORMS_ANCHOR_STYLES is
		external
			"IL enum signature :System.Windows.Forms.AnchorStyles use System.Windows.Forms.AnchorStyles"
		alias
			"8"
		end

	frozen top: WINFORMS_ANCHOR_STYLES is
		external
			"IL enum signature :System.Windows.Forms.AnchorStyles use System.Windows.Forms.AnchorStyles"
		alias
			"1"
		end

	frozen left: WINFORMS_ANCHOR_STYLES is
		external
			"IL enum signature :System.Windows.Forms.AnchorStyles use System.Windows.Forms.AnchorStyles"
		alias
			"4"
		end

	frozen bottom: WINFORMS_ANCHOR_STYLES is
		external
			"IL enum signature :System.Windows.Forms.AnchorStyles use System.Windows.Forms.AnchorStyles"
		alias
			"2"
		end

	frozen none: WINFORMS_ANCHOR_STYLES is
		external
			"IL enum signature :System.Windows.Forms.AnchorStyles use System.Windows.Forms.AnchorStyles"
		alias
			"0"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class WINFORMS_ANCHOR_STYLES
