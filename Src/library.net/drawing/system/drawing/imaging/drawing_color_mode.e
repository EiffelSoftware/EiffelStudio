indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.ColorMode"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DRAWING_COLOR_MODE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen argb32_mode: DRAWING_COLOR_MODE is
		external
			"IL enum signature :System.Drawing.Imaging.ColorMode use System.Drawing.Imaging.ColorMode"
		alias
			"0"
		end

	frozen argb64_mode: DRAWING_COLOR_MODE is
		external
			"IL enum signature :System.Drawing.Imaging.ColorMode use System.Drawing.Imaging.ColorMode"
		alias
			"1"
		end

end -- class DRAWING_COLOR_MODE
