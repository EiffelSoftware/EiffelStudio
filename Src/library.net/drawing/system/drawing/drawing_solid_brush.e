indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.SolidBrush"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_SOLID_BRUSH

inherit
	DRAWING_BRUSH
		redefine
			dispose_boolean
		end
	ICLONEABLE
	IDISPOSABLE

create
	make_drawing_solid_brush

feature {NONE} -- Initialization

	frozen make_drawing_solid_brush (color: DRAWING_COLOR) is
		external
			"IL creator signature (System.Drawing.Color) use System.Drawing.SolidBrush"
		end

feature -- Access

	frozen get_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Drawing.SolidBrush"
		alias
			"get_Color"
		end

feature -- Element Change

	frozen set_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Drawing.SolidBrush"
		alias
			"set_Color"
		end

feature -- Basic Operations

	clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Drawing.SolidBrush"
		alias
			"Clone"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Drawing.SolidBrush"
		alias
			"Dispose"
		end

end -- class DRAWING_SOLID_BRUSH
