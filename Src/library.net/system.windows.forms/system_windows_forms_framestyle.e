indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.FrameStyle"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_FRAMESTYLE

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

	frozen thick: SYSTEM_WINDOWS_FORMS_FRAMESTYLE is
		external
			"IL enum signature :System.Windows.Forms.FrameStyle use System.Windows.Forms.FrameStyle"
		alias
			"1"
		end

	frozen dashed: SYSTEM_WINDOWS_FORMS_FRAMESTYLE is
		external
			"IL enum signature :System.Windows.Forms.FrameStyle use System.Windows.Forms.FrameStyle"
		alias
			"0"
		end

end -- class SYSTEM_WINDOWS_FORMS_FRAMESTYLE
