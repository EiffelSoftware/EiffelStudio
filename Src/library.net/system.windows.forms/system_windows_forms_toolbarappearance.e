indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ToolBarAppearance"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_TOOLBARAPPEARANCE

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

	frozen flat: SYSTEM_WINDOWS_FORMS_TOOLBARAPPEARANCE is
		external
			"IL enum signature :System.Windows.Forms.ToolBarAppearance use System.Windows.Forms.ToolBarAppearance"
		alias
			"1"
		end

	frozen normal: SYSTEM_WINDOWS_FORMS_TOOLBARAPPEARANCE is
		external
			"IL enum signature :System.Windows.Forms.ToolBarAppearance use System.Windows.Forms.ToolBarAppearance"
		alias
			"0"
		end

end -- class SYSTEM_WINDOWS_FORMS_TOOLBARAPPEARANCE
