indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.SortOrder"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_SORTORDER

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

	frozen none: SYSTEM_WINDOWS_FORMS_SORTORDER is
		external
			"IL enum signature :System.Windows.Forms.SortOrder use System.Windows.Forms.SortOrder"
		alias
			"0"
		end

	frozen descending: SYSTEM_WINDOWS_FORMS_SORTORDER is
		external
			"IL enum signature :System.Windows.Forms.SortOrder use System.Windows.Forms.SortOrder"
		alias
			"2"
		end

	frozen ascending: SYSTEM_WINDOWS_FORMS_SORTORDER is
		external
			"IL enum signature :System.Windows.Forms.SortOrder use System.Windows.Forms.SortOrder"
		alias
			"1"
		end

end -- class SYSTEM_WINDOWS_FORMS_SORTORDER
