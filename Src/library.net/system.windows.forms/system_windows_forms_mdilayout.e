indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.MdiLayout"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_WINDOWS_FORMS_MDILAYOUT

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

	frozen cascade: SYSTEM_WINDOWS_FORMS_MDILAYOUT is
		external
			"IL enum signature :System.Windows.Forms.MdiLayout use System.Windows.Forms.MdiLayout"
		alias
			"0"
		end

	frozen tile_vertical: SYSTEM_WINDOWS_FORMS_MDILAYOUT is
		external
			"IL enum signature :System.Windows.Forms.MdiLayout use System.Windows.Forms.MdiLayout"
		alias
			"2"
		end

	frozen tile_horizontal: SYSTEM_WINDOWS_FORMS_MDILAYOUT is
		external
			"IL enum signature :System.Windows.Forms.MdiLayout use System.Windows.Forms.MdiLayout"
		alias
			"1"
		end

	frozen arrange_icons: SYSTEM_WINDOWS_FORMS_MDILAYOUT is
		external
			"IL enum signature :System.Windows.Forms.MdiLayout use System.Windows.Forms.MdiLayout"
		alias
			"3"
		end

end -- class SYSTEM_WINDOWS_FORMS_MDILAYOUT
