indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ColorDepth"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_COLORDEPTH

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

	frozen depth4_bit: SYSTEM_WINDOWS_FORMS_COLORDEPTH is
		external
			"IL enum signature :System.Windows.Forms.ColorDepth use System.Windows.Forms.ColorDepth"
		alias
			"4"
		end

	frozen depth24_bit: SYSTEM_WINDOWS_FORMS_COLORDEPTH is
		external
			"IL enum signature :System.Windows.Forms.ColorDepth use System.Windows.Forms.ColorDepth"
		alias
			"24"
		end

	frozen depth16_bit: SYSTEM_WINDOWS_FORMS_COLORDEPTH is
		external
			"IL enum signature :System.Windows.Forms.ColorDepth use System.Windows.Forms.ColorDepth"
		alias
			"16"
		end

	frozen depth8_bit: SYSTEM_WINDOWS_FORMS_COLORDEPTH is
		external
			"IL enum signature :System.Windows.Forms.ColorDepth use System.Windows.Forms.ColorDepth"
		alias
			"8"
		end

	frozen depth32_bit: SYSTEM_WINDOWS_FORMS_COLORDEPTH is
		external
			"IL enum signature :System.Windows.Forms.ColorDepth use System.Windows.Forms.ColorDepth"
		alias
			"32"
		end

end -- class SYSTEM_WINDOWS_FORMS_COLORDEPTH
