indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Text.PrivateFontCollection"

frozen external class
	SYSTEM_DRAWING_TEXT_PRIVATEFONTCOLLECTION

inherit
	SYSTEM_DRAWING_TEXT_FONTCOLLECTION
		redefine
			dispose_boolean
		end
	SYSTEM_IDISPOSABLE

create
	make_privatefontcollection

feature {NONE} -- Initialization

	frozen make_privatefontcollection is
		external
			"IL creator use System.Drawing.Text.PrivateFontCollection"
		end

feature -- Basic Operations

	frozen add_font_file (filename: STRING) is
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

end -- class SYSTEM_DRAWING_TEXT_PRIVATEFONTCOLLECTION
