indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.BootMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_BOOTMODE

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen fail_safe: SYSTEM_WINDOWS_FORMS_BOOTMODE is
		external
			"IL enum signature :System.Windows.Forms.BootMode use System.Windows.Forms.BootMode"
		alias
			"1"
		end

	frozen fail_safe_with_network: SYSTEM_WINDOWS_FORMS_BOOTMODE is
		external
			"IL enum signature :System.Windows.Forms.BootMode use System.Windows.Forms.BootMode"
		alias
			"2"
		end

	frozen normal: SYSTEM_WINDOWS_FORMS_BOOTMODE is
		external
			"IL enum signature :System.Windows.Forms.BootMode use System.Windows.Forms.BootMode"
		alias
			"0"
		end

end -- class SYSTEM_WINDOWS_FORMS_BOOTMODE
