indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.CheckState"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_CHECKSTATE

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

	frozen unchecked: SYSTEM_WINDOWS_FORMS_CHECKSTATE is
		external
			"IL enum signature :System.Windows.Forms.CheckState use System.Windows.Forms.CheckState"
		alias
			"0"
		end

	frozen checked: SYSTEM_WINDOWS_FORMS_CHECKSTATE is
		external
			"IL enum signature :System.Windows.Forms.CheckState use System.Windows.Forms.CheckState"
		alias
			"1"
		end

	frozen indeterminate: SYSTEM_WINDOWS_FORMS_CHECKSTATE is
		external
			"IL enum signature :System.Windows.Forms.CheckState use System.Windows.Forms.CheckState"
		alias
			"2"
		end

end -- class SYSTEM_WINDOWS_FORMS_CHECKSTATE
