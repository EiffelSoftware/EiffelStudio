indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ColumnHeaderStyle"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_COLUMNHEADERSTYLE

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

	frozen nonclickable: SYSTEM_WINDOWS_FORMS_COLUMNHEADERSTYLE is
		external
			"IL enum signature :System.Windows.Forms.ColumnHeaderStyle use System.Windows.Forms.ColumnHeaderStyle"
		alias
			"1"
		end

	frozen clickable: SYSTEM_WINDOWS_FORMS_COLUMNHEADERSTYLE is
		external
			"IL enum signature :System.Windows.Forms.ColumnHeaderStyle use System.Windows.Forms.ColumnHeaderStyle"
		alias
			"2"
		end

	frozen none: SYSTEM_WINDOWS_FORMS_COLUMNHEADERSTYLE is
		external
			"IL enum signature :System.Windows.Forms.ColumnHeaderStyle use System.Windows.Forms.ColumnHeaderStyle"
		alias
			"0"
		end

end -- class SYSTEM_WINDOWS_FORMS_COLUMNHEADERSTYLE
