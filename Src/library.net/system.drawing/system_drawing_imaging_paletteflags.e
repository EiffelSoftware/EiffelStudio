indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.PaletteFlags"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_IMAGING_PALETTEFLAGS

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

	frozen has_alpha: SYSTEM_DRAWING_IMAGING_PALETTEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.PaletteFlags use System.Drawing.Imaging.PaletteFlags"
		alias
			"1"
		end

	frozen gray_scale: SYSTEM_DRAWING_IMAGING_PALETTEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.PaletteFlags use System.Drawing.Imaging.PaletteFlags"
		alias
			"2"
		end

	frozen halftone: SYSTEM_DRAWING_IMAGING_PALETTEFLAGS is
		external
			"IL enum signature :System.Drawing.Imaging.PaletteFlags use System.Drawing.Imaging.PaletteFlags"
		alias
			"4"
		end

end -- class SYSTEM_DRAWING_IMAGING_PALETTEFLAGS
