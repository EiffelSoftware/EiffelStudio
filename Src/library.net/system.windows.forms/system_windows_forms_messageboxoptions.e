indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.MessageBoxOptions"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_MESSAGEBOXOPTIONS

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

	frozen rtl_reading: SYSTEM_WINDOWS_FORMS_MESSAGEBOXOPTIONS is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxOptions use System.Windows.Forms.MessageBoxOptions"
		alias
			"1048576"
		end

	frozen right_align: SYSTEM_WINDOWS_FORMS_MESSAGEBOXOPTIONS is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxOptions use System.Windows.Forms.MessageBoxOptions"
		alias
			"524288"
		end

	frozen default_desktop_only: SYSTEM_WINDOWS_FORMS_MESSAGEBOXOPTIONS is
		external
			"IL enum signature :System.Windows.Forms.MessageBoxOptions use System.Windows.Forms.MessageBoxOptions"
		alias
			"131072"
		end

	frozen service_notification: SYSTEM_WINDOWS_FORMS_MESSAGEBOXOPTIONS is
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

end -- class SYSTEM_WINDOWS_FORMS_MESSAGEBOXOPTIONS
