indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Text.PrivateFontCollection"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_PRIVATE_FONT_COLLECTION

inherit
	DRAWING_FONT_COLLECTION
		redefine
			dispose_boolean
		end
	IDISPOSABLE

create
	make_drawing_private_font_collection

feature {NONE} -- Initialization

	frozen make_drawing_private_font_collection is
		external
			"IL creator use System.Drawing.Text.PrivateFontCollection"
		end

feature -- Basic Operations

	frozen add_font_file (filename: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Drawing.Text.PrivateFontCollection"
		alias
			"AddFontFile"
		end

	frozen add_memory_font (memory: POINTER; length: INTEGER) is
		external
			"IL signature (System.IntPtr, System.Int32): System.Void use System.Drawing.Text.PrivateFontCollection"
		alias
			"AddMemoryFont"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Drawing.Text.PrivateFontCollection"
		alias
			"Dispose"
		end

end -- class DRAWING_PRIVATE_FONT_COLLECTION
