indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.FlatStyle"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_FLATSTYLE

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

	frozen flat: SYSTEM_WINDOWS_FORMS_FLATSTYLE is
		external
			"IL enum signature :System.Windows.Forms.FlatStyle use System.Windows.Forms.FlatStyle"
		alias
			"0"
		end

	frozen system: SYSTEM_WINDOWS_FORMS_FLATSTYLE is
		external
			"IL enum signature :System.Windows.Forms.FlatStyle use System.Windows.Forms.FlatStyle"
		alias
			"3"
		end

	frozen standard: SYSTEM_WINDOWS_FORMS_FLATSTYLE is
		external
			"IL enum signature :System.Windows.Forms.FlatStyle use System.Windows.Forms.FlatStyle"
		alias
			"2"
		end

	frozen popup: SYSTEM_WINDOWS_FORMS_FLATSTYLE is
		external
			"IL enum signature :System.Windows.Forms.FlatStyle use System.Windows.Forms.FlatStyle"
		alias
			"1"
		end

end -- class SYSTEM_WINDOWS_FORMS_FLATSTYLE
