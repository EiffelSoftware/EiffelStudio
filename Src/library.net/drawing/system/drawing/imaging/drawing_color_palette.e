indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Imaging.ColorPalette"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_COLOR_PALETTE

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_flags: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Imaging.ColorPalette"
		alias
			"get_Flags"
		end

	frozen get_entries: NATIVE_ARRAY [DRAWING_COLOR] is
		external
			"IL signature (): System.Drawing.Color[] use System.Drawing.Imaging.ColorPalette"
		alias
			"get_Entries"
		end

end -- class DRAWING_COLOR_PALETTE
