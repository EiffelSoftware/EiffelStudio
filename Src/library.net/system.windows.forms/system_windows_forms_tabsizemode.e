indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.TabSizeMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_TABSIZEMODE

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

	frozen fixed: SYSTEM_WINDOWS_FORMS_TABSIZEMODE is
		external
			"IL enum signature :System.Windows.Forms.TabSizeMode use System.Windows.Forms.TabSizeMode"
		alias
			"2"
		end

	frozen fill_to_right: SYSTEM_WINDOWS_FORMS_TABSIZEMODE is
		external
			"IL enum signature :System.Windows.Forms.TabSizeMode use System.Windows.Forms.TabSizeMode"
		alias
			"1"
		end

	frozen normal: SYSTEM_WINDOWS_FORMS_TABSIZEMODE is
		external
			"IL enum signature :System.Windows.Forms.TabSizeMode use System.Windows.Forms.TabSizeMode"
		alias
			"0"
		end

end -- class SYSTEM_WINDOWS_FORMS_TABSIZEMODE
