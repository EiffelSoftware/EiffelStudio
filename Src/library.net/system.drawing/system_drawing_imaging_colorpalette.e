indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Imaging.ColorPalette"

frozen external class
	SYSTEM_DRAWING_IMAGING_COLORPALETTE

create {NONE}

feature -- Access

	frozen get_flags: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.ColorPalette"
		alias
			"get_Flags"
		end

	frozen get_entries: ARRAY [SYSTEM_DRAWING_COLOR] is
		external
			"IL signature (): System.Drawing.Color[] use System.Drawing.Imaging.ColorPalette"
		alias
			"get_Entries"
		end

end -- class SYSTEM_DRAWING_IMAGING_COLORPALETTE
