indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.CustomLineCap"

external class
	SYSTEM_DRAWING_DRAWING2D_CUSTOMLINECAP

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			finalize
		end
	SYSTEM_ICLONEABLE
	SYSTEM_IDISPOSABLE

create
	make_customlinecap_2,
	make_customlinecap_1,
	make_customlinecap

feature {NONE} -- Initialization

	frozen make_customlinecap_2 (fill_path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH; stroke_path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH; base_cap: SYSTEM_DRAWING_DRAWING2D_LINECAP; base_inset: REAL) is
		external
			"IL creator signature (System.Drawing.Drawing2D.GraphicsPath, System.Drawing.Drawing2D.GraphicsPath, System.Drawing.Drawing2D.LineCap, System.Single) use System.Drawing.Drawing2D.CustomLineCap"
		end

	frozen make_customlinecap_1 (fill_path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH; stroke_path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH; base_cap: SYSTEM_DRAWING_DRAWING2D_LINECAP) is
		external
			"IL creator signature (System.Drawing.Drawing2D.GraphicsPath, System.Drawing.Drawing2D.GraphicsPath, System.Drawing.Drawing2D.LineCap) use System.Drawing.Drawing2D.CustomLineCap"
		end

	frozen make_customlinecap (fill_path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH; stroke_path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH) is
		external
			"IL creator signature (System.Drawing.Drawing2D.GraphicsPath, System.Drawing.Drawing2D.GraphicsPath) use System.Drawing.Drawing2D.CustomLineCap"
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

	frozen get_base_cap: SYSTEM_DRAWING_DRAWING2D_LINECAP is
		external
			"IL signature (): System.Drawing.Drawing2D.LineCap use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"get_BaseCap"
		end

	frozen get_stroke_join: SYSTEM_DRAWING_DRAWING2D_LINEJOIN is
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

	frozen set_stroke_join (value: SYSTEM_DRAWING_DRAWING2D_LINEJOIN) is
		external
			"IL signature (System.Drawing.Drawing2D.LineJoin): System.Void use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"set_StrokeJoin"
		end

	frozen set_base_cap (value: SYSTEM_DRAWING_DRAWING2D_LINECAP) is
		external
			"IL signature (System.Drawing.Drawing2D.LineCap): System.Void use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"set_BaseCap"
		end

feature -- Basic Operations

	frozen set_stroke_caps (start_cap: SYSTEM_DRAWING_DRAWING2D_LINECAP; end_cap: SYSTEM_DRAWING_DRAWING2D_LINECAP) is
		external
			"IL signature (System.Drawing.Drawing2D.LineCap, System.Drawing.Drawing2D.LineCap): System.Void use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"SetStrokeCaps"
		end

	frozen get_stroke_caps (start_cap: SYSTEM_DRAWING_DRAWING2D_LINECAP; end_cap: SYSTEM_DRAWING_DRAWING2D_LINECAP) is
		external
			"IL signature (System.Drawing.Drawing2D.LineCap&, System.Drawing.Drawing2D.LineCap&): System.Void use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"GetStrokeCaps"
		end

	dispose is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.CustomLineCap"
		alias
			"Dispose"
		end

	frozen clone: ANY is
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

end -- class SYSTEM_DRAWING_DRAWING2D_CUSTOMLINECAP
