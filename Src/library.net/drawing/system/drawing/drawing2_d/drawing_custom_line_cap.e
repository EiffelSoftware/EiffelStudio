indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Drawing2D.CustomLineCap"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DRAWING_CUSTOM_LINE_CAP

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize
		end
	ICLONEABLE
	IDISPOSABLE

create
	make_drawing_custom_line_cap,
	make_drawing_custom_line_cap_1,
	make_drawing_custom_line_cap_2

feature {NONE} -- Initialization

	frozen make_drawing_custom_line_cap (fill_path: DRAWING_GRAPHICS_PATH; stroke_path: DRAWING_GRAPHICS_PATH) is
		external
			"IL creator signature (System.Drawing.Drawing2D.GraphicsPath, System.Drawing.Drawing2D.GraphicsPath) use System.Drawing.Drawing2D.CustomLineCap"
		end

	frozen make_drawing_custom_line_cap_1 (fill_path: DRAWING_GRAPHICS_PATH; stroke_path: DRAWING_GRAPHICS_PATH; base_cap: DRAWING_LINE_CAP) is
		external
			"IL creator signature (System.Drawing.Drawing2D.GraphicsPath, System.Drawing.Drawing2D.GraphicsPath, System.Drawing.Drawing2D.LineCap) use System.Drawing.Drawing2D.CustomLineCap"
		end

	frozen make_drawing_custom_line_cap_2 (fill_path: DRAWING_GRAPHICS_PATH; stroke_path: DRAWING_GRAPHICS_PATH; base_cap: DRAWING_LINE_CAP; base_inset: REAL) is
		external
			"IL creator signature (System.Drawing.Drawing2D.GraphicsPath, System.Drawing.Drawing2D.GraphicsPath, System.Drawing.Drawing2D.LineCap, System.Single) use System.Drawing.Drawing2D.CustomLineCap"
		end

feature -- Access

	frozen get_width_scale: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"get_WidthScale"
		end

	frozen get_base_inset: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"get_BaseInset"
		end

	frozen get_base_cap: DRAWING_LINE_CAP is
		external
			"IL signature (): System.Drawing.Drawing2D.LineCap use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"get_BaseCap"
		end

	frozen get_stroke_join: DRAWING_LINE_JOIN is
		external
			"IL signature (): System.Drawing.Drawing2D.LineJoin use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"get_StrokeJoin"
		end

feature -- Element Change

	frozen set_width_scale (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"set_WidthScale"
		end

	frozen set_base_inset (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"set_BaseInset"
		end

	frozen set_stroke_join (value: DRAWING_LINE_JOIN) is
		external
			"IL signature (System.Drawing.Drawing2D.LineJoin): System.Void use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"set_StrokeJoin"
		end

	frozen set_base_cap (value: DRAWING_LINE_CAP) is
		external
			"IL signature (System.Drawing.Drawing2D.LineCap): System.Void use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"set_BaseCap"
		end

feature -- Basic Operations

	frozen set_stroke_caps (start_cap: DRAWING_LINE_CAP; end_cap: DRAWING_LINE_CAP) is
		external
			"IL signature (System.Drawing.Drawing2D.LineCap, System.Drawing.Drawing2D.LineCap): System.Void use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"SetStrokeCaps"
		end

	frozen get_stroke_caps (start_cap: DRAWING_LINE_CAP; end_cap: DRAWING_LINE_CAP) is
		external
			"IL signature (System.Drawing.Drawing2D.LineCap&, System.Drawing.Drawing2D.LineCap&): System.Void use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"GetStrokeCaps"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"Dispose"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"Clone"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"Finalize"
		end

end -- class DRAWING_CUSTOM_LINE_CAP
