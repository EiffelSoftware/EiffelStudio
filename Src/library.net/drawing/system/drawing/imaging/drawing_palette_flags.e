indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.PaletteFlags"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"
	enum_type: "INTEGER"

frozen expanded external class
	DRAWING_PALETTE_FLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen has_alpha: DRAWING_PALETTE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.PaletteFlags use System.Drawing.Imaging.PaletteFlags"
		alias
			"1"
		end

	frozen gray_scale: DRAWING_PALETTE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.PaletteFlags use System.Drawing.Imaging.PaletteFlags"
		alias
			"2"
		end

	frozen halftone: DRAWING_PALETTE_FLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.PaletteFlags use System.Drawing.Imaging.PaletteFlags"
		alias
			"4"
		end

end -- class DRAWING_PALETTE_FLAGS
