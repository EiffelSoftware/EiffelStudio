indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.CharacterCasing"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_CHARACTERCASING

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

	frozen lower: SYSTEM_WINDOWS_FORMS_CHARACTERCASING is
		external
			"IL enum signature :System.Windows.Forms.CharacterCasing use System.Windows.Forms.CharacterCasing"
		alias
			"2"
		end

	frozen normal: SYSTEM_WINDOWS_FORMS_CHARACTERCASING is
		external
			"IL enum signature :System.Windows.Forms.CharacterCasing use System.Windows.Forms.CharacterCasing"
		alias
			"0"
		end

	frozen upper: SYSTEM_WINDOWS_FORMS_CHARACTERCASING is
		external
			"IL enum signature :System.Windows.Forms.CharacterCasing use System.Windows.Forms.CharacterCasing"
		alias
			"1"
		end

end -- class SYSTEM_WINDOWS_FORMS_CHARACTERCASING
