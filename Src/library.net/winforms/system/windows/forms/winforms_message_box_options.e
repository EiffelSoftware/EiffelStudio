indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.MessageBoxOptions"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_MESSAGE_BOX_OPTIONS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen rtl_reading: WINFORMS_MESSAGE_BOX_OPTIONS is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxOptions use System.Windows.Forms.MessageBoxOptions"
		alias
			"1048576"
		end

	frozen right_align: WINFORMS_MESSAGE_BOX_OPTIONS is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxOptions use System.Windows.Forms.MessageBoxOptions"
		alias
			"524288"
		end

	frozen default_desktop_only: WINFORMS_MESSAGE_BOX_OPTIONS is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxOptions use System.Windows.Forms.MessageBoxOptions"
		alias
			"131072"
		end

	frozen service_notification: WINFORMS_MESSAGE_BOX_OPTIONS is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxOptions use System.Windows.Forms.MessageBoxOptions"
		alias
			"2097152"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class WINFORMS_MESSAGE_BOX_OPTIONS
