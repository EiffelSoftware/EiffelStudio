indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.SolidBrush"

frozen external class
	SYSTEM_DRAWING_SOLIDBRUSH

inherit
	SYSTEM_DRAWING_BRUSH
		redefine
			dispose_boolean
		end
	SYSTEM_ICLONEABLE
	SYSTEM_IDISPOSABLE

create
	make_solidbrush

feature {NONE} -- Initialization

	frozen make_solidbrush (color: SYSTEM_DRAWING_COLOR) is
		external
			"IL creator signature (System.Drawing.Color) use System.Drawing.SolidBrush"
		end

feature -- Access

	frozen get_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Drawing.SolidBrush"
		alias
			"get_Color"
		end

feature -- Element Change

	frozen set_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Drawing.SolidBrush"
		alias
			"set_Color"
		end

feature -- Basic Operations

	clone: ANY is
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

end -- class SYSTEM_DRAWING_SOLIDBRUSH
