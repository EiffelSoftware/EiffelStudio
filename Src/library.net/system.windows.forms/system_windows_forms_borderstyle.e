indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.BorderStyle"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_BORDERSTYLE

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

	frozen fixed_single: SYSTEM_WINDOWS_FORMS_BORDERSTYLE is
		external
			"IL enum signature :System.Windows.Forms.BorderStyle use System.Windows.Forms.BorderStyle"
		alias
			"1"
		end

	frozen fixed3_d: SYSTEM_WINDOWS_FORMS_BORDERSTYLE is
		external
			"IL enum signature :System.Windows.Forms.BorderStyle use System.Windows.Forms.BorderStyle"
		alias
			"2"
		end

	frozen none: SYSTEM_WINDOWS_FORMS_BORDERSTYLE is
		external
			"IL enum signature :System.Windows.Forms.BorderStyle use System.Windows.Forms.BorderStyle"
		alias
			"0"
		end

end -- class SYSTEM_WINDOWS_FORMS_BORDERSTYLE
