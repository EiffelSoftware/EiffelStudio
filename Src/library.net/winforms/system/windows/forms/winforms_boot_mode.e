indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.BootMode"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_BOOT_MODE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen fail_safe: WINFORMS_BOOT_MODE is
		external
			"IL enum signature :System.Windows.Forms.BootMode use System.Windows.Forms.BootMode"
		alias
			"1"
		end

	frozen fail_safe_with_network: WINFORMS_BOOT_MODE is
		external
			"IL enum signature :System.Windows.Forms.BootMode use System.Windows.Forms.BootMode"
		alias
			"2"
		end

	frozen normal: WINFORMS_BOOT_MODE is
		external
			"IL enum signature :System.Windows.Forms.BootMode use System.Windows.Forms.BootMode"
		alias
			"0"
		end

end -- class WINFORMS_BOOT_MODE
