indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Appearance"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_APPEARANCE

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

	frozen button: SYSTEM_WINDOWS_FORMS_APPEARANCE is
		external
			"IL enum signature :System.Windows.Forms.Appearance use System.Windows.Forms.Appearance"
		alias
			"1"
		end

	frozen normal: SYSTEM_WINDOWS_FORMS_APPEARANCE is
		external
			"IL enum signature :System.Windows.Forms.Appearance use System.Windows.Forms.Appearance"
		alias
			"0"
		end

end -- class SYSTEM_WINDOWS_FORMS_APPEARANCE
