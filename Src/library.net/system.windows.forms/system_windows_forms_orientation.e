indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Orientation"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_ORIENTATION

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

	frozen horizontal: SYSTEM_WINDOWS_FORMS_ORIENTATION is
		external
			"IL enum signature :System.Windows.Forms.Orientation use System.Windows.Forms.Orientation"
		alias
			"0"
		end

	frozen vertical: SYSTEM_WINDOWS_FORMS_ORIENTATION is
		external
			"IL enum signature :System.Windows.Forms.Orientation use System.Windows.Forms.Orientation"
		alias
			"1"
		end

end -- class SYSTEM_WINDOWS_FORMS_ORIENTATION
