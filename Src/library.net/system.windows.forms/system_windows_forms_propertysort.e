indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.PropertySort"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_PROPERTYSORT

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

	frozen no_sort: SYSTEM_WINDOWS_FORMS_PROPERTYSORT is
		external
			"IL enum signature :System.Windows.Forms.PropertySort use System.Windows.Forms.PropertySort"
		alias
			"0"
		end

	frozen alphabetical: SYSTEM_WINDOWS_FORMS_PROPERTYSORT is
		external
			"IL enum signature :System.Windows.Forms.PropertySort use System.Windows.Forms.PropertySort"
		alias
			"1"
		end

	frozen categorized: SYSTEM_WINDOWS_FORMS_PROPERTYSORT is
		external
			"IL enum signature :System.Windows.Forms.PropertySort use System.Windows.Forms.PropertySort"
		alias
			"2"
		end

	frozen categorized_alphabetical: SYSTEM_WINDOWS_FORMS_PROPERTYSORT is
		external
			"IL enum signature :System.Windows.Forms.PropertySort use System.Windows.Forms.PropertySort"
		alias
			"3"
		end

end -- class SYSTEM_WINDOWS_FORMS_PROPERTYSORT
