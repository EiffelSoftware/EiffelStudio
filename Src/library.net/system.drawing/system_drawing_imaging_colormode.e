indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.ColorMode"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_IMAGING_COLORMODE

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

	frozen argb32_mode: SYSTEM_DRAWING_IMAGING_COLORMODE is
		external
			"IL enum signature :System.Drawing.Imaging.ColorMode use System.Drawing.Imaging.ColorMode"
		alias
			"0"
		end

	frozen argb64_mode: SYSTEM_DRAWING_IMAGING_COLORMODE is
		external
			"IL enum signature :System.Drawing.Imaging.ColorMode use System.Drawing.Imaging.ColorMode"
		alias
			"1"
		end

end -- class SYSTEM_DRAWING_IMAGING_COLORMODE
