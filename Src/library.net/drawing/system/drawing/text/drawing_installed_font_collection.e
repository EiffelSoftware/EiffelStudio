indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Text.InstalledFontCollection"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_INSTALLED_FONT_COLLECTION

inherit
	DRAWING_FONT_COLLECTION
	IDISPOSABLE

create
	make_drawing_installed_font_collection

feature {NONE} -- Initialization

	frozen make_drawing_installed_font_collection is
		external
			"IL creator use System.Drawing.Text.InstalledFontCollection"
		end

end -- class DRAWING_INSTALLED_FONT_COLLECTION
