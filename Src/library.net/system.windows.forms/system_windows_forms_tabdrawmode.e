indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.TabDrawMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_TABDRAWMODE

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

	frozen normal: SYSTEM_WINDOWS_FORMS_TABDRAWMODE is
		external
			"IL enum signature :System.Windows.Forms.TabDrawMode use System.Windows.Forms.TabDrawMode"
		alias
			"0"
		end

	frozen owner_draw_fixed: SYSTEM_WINDOWS_FORMS_TABDRAWMODE is
		external
			"IL enum signature :System.Windows.Forms.TabDrawMode use System.Windows.Forms.TabDrawMode"
		alias
			"1"
		end

end -- class SYSTEM_WINDOWS_FORMS_TABDRAWMODE
