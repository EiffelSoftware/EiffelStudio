indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Pen"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_PEN

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize
		end
	ICLONEABLE
	IDISPOSABLE

create
	make_drawing_pen,
	make_drawing_pen_1,
	make_drawing_pen_2,
	make_drawing_pen_3

feature {NONE} -- Initialization

	frozen make_drawing_pen (color: DRAWING_COLOR) is
		external
			"IL creator signature (System.Drawing.Color) use System.Drawing.Pen"
		end

	frozen make_drawing_pen_1 (color: DRAWING_COLOR; width: REAL) is
		external
			"IL creator signature (System.Drawing.Color, System.Single) use System.Drawing.Pen"
		end

	frozen make_drawing_pen_2 (brush: DRAWING_BRUSH) is
		external
			"IL creator signature (System.Drawing.Brush) use System.Drawing.Pen"
		end

	frozen make_drawing_pen_3 (brush: DRAWING_BRUSH; width: REAL) is
		external
			"IL creator signature (System.Drawing.Brush, System.Single) use System.Drawing.Pen"
		end

feature -- Access

	frozen get_line_join: DRAWING_LINE_JOIN is
		external
			"IL signature (): System.Drawing.Drawing2D.LineJoin use System.Drawing.Pen"
		alias
			"get_LineJoin"
		end

	frozen get_custom_start_cap: DRAWING_CUSTOM_LINE_CAP is
		external
			"IL signature (): System.Drawing.Drawing2D.CustomLineCap use System.Drawing.Pen"
		alias
			"get_CustomStartCap"
		end

	frozen get_dash_cap: DRAWING_DASH_CAP is
		external
			"IL signature (): System.Drawing.Drawing2D.DashCap use System.Drawing.Pen"
		alias
			"get_DashCap"
		end

	frozen get_custom_end_cap: DRAWING_CUSTOM_LINE_CAP is
		external
			"IL signature (): System.Drawing.Drawing2D.CustomLineCap use System.Drawing.Pen"
		alias
			"get_CustomEndCap"
		end

	frozen get_brush: DRAWING_BRUSH is
		external
			"IL signature (): System.Drawing.Brush use System.Drawing.Pen"
		alias
			"get_Brush"
		end

	frozen get_start_cap: DRAWING_LINE_CAP is
		external
			"IL signature (): System.Drawing.Drawing2D.LineCap use System.Drawing.Pen"
		alias
			"get_StartCap"
		end

	frozen get_alignment: DRAWING_PEN_ALIGNMENT is
		external
			"IL signature (): System.Drawing.Drawing2D.PenAlignment use System.Drawing.Pen"
		alias
			"get_Alignment"
		end

	frozen get_dash_offset: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Pen"
		alias
			"get_DashOffset"
		end

	frozen get_transform: DRAWING_MATRIX is
		external
			"IL signature (): System.Drawing.Drawing2D.Matrix use System.Drawing.Pen"
		alias
			"get_Transform"
		end

	frozen get_compound_array: NATIVE_ARRAY [REAL] is
		external
			"IL signature (): System.Single[] use System.Drawing.Pen"
		alias
			"get_CompoundArray"
		end

	frozen get_dash_style: DRAWING_DASH_STYLE is
		external
			"IL signature (): System.Drawing.Drawing2D.DashStyle use System.Drawing.Pen"
		alias
			"get_DashStyle"
		end

	frozen get_end_cap: DRAWING_LINE_CAP is
		external
			"IL signature (): System.Drawing.Drawing2D.LineCap use System.Drawing.Pen"
		alias
			"get_EndCap"
		end

	frozen get_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Drawing.Pen"
		alias
			"get_Color"
		end

	frozen get_width: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Pen"
		alias
			"get_Width"
		end

	frozen get_miter_limit: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Pen"
		alias
			"get_MiterLimit"
		end

	frozen get_pen_type: DRAWING_PEN_TYPE is
		external
			"IL signature (): System.Drawing.Drawing2D.PenType use System.Drawing.Pen"
		alias
			"get_PenType"
		end

	frozen get_dash_pattern: NATIVE_ARRAY [REAL] is
		external
			"IL signature (): System.Single[] use System.Drawing.Pen"
		alias
			"get_DashPattern"
		end

feature -- Element Change

	frozen set_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Drawing.Pen"
		alias
			"set_Color"
		end

	frozen set_miter_limit (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Pen"
		alias
			"set_MiterLimit"
		end

	frozen set_dash_pattern (value: NATIVE_ARRAY [REAL]) is
		external
			"IL signature (System.Single[]): System.Void use System.Drawing.Pen"
		alias
			"set_DashPattern"
		end

	frozen set_dash_style (value: DRAWING_DASH_STYLE) is
		external
			"IL signature (System.Drawing.Drawing2D.DashStyle): System.Void use System.Drawing.Pen"
		alias
			"set_DashStyle"
		end

	frozen set_custom_start_cap (value: DRAWING_CUSTOM_LINE_CAP) is
		external
			"IL signature (System.Drawing.Drawing2D.CustomLineCap): System.Void use System.Drawing.Pen"
		alias
			"set_CustomStartCap"
		end

	frozen set_brush (value: DRAWING_BRUSH) is
		external
			"IL signature (System.Drawing.Brush): System.Void use System.Drawing.Pen"
		alias
			"set_Brush"
		end

	frozen set_compound_array (value: NATIVE_ARRAY [REAL]) is
		external
			"IL signature (System.Single[]): System.Void use System.Drawing.Pen"
		alias
			"set_CompoundArray"
		end

	frozen set_custom_end_cap (value: DRAWING_CUSTOM_LINE_CAP) is
		external
			"IL signature (System.Drawing.Drawing2D.CustomLineCap): System.Void use System.Drawing.Pen"
		alias
			"set_CustomEndCap"
		end

	frozen set_transform (value: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Pen"
		alias
			"set_Transform"
		end

	frozen set_dash_offset (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Pen"
		alias
			"set_DashOffset"
		end

	frozen set_start_cap (value: DRAWING_LINE_CAP) is
		external
			"IL signature (System.Drawing.Drawing2D.LineCap): System.Void use System.Drawing.Pen"
		alias
			"set_StartCap"
		end

	frozen set_line_join (value: DRAWING_LINE_JOIN) is
		external
			"IL signature (System.Drawing.Drawing2D.LineJoin): System.Void use System.Drawing.Pen"
		alias
			"set_LineJoin"
		end

	frozen set_end_cap (value: DRAWING_LINE_CAP) is
		external
			"IL signature (System.Drawing.Drawing2D.LineCap): System.Void use System.Drawing.Pen"
		alias
			"set_EndCap"
		end

	frozen set_width (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Pen"
		alias
			"set_Width"
		end

	frozen set_alignment (value: DRAWING_PEN_ALIGNMENT) is
		external
			"IL signature (System.Drawing.Drawing2D.PenAlignment): System.Void use System.Drawing.Pen"
		alias
			"set_Alignment"
		end

	frozen set_dash_cap (value: DRAWING_DASH_CAP) is
		external
			"IL signature (System.Drawing.Drawing2D.DashCap): System.Void use System.Drawing.Pen"
		alias
			"set_DashCap"
		end

feature -- Basic Operations

	frozen rotate_transform_single_matrix_order (angle: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Pen"
		alias
			"RotateTransform"
		end

	frozen translate_transform_single_single_matrix_order (dx: REAL; dy: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Pen"
		alias
			"TranslateTransform"
		end

	frozen multiply_transform_matrix_matrix_order (matrix: DRAWING_MATRIX; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Pen"
		alias
			"MultiplyTransform"
		end

	frozen set_line_cap (start_cap: DRAWING_LINE_CAP; end_cap: DRAWING_LINE_CAP; dash_cap: DRAWING_DASH_CAP) is
		external
			"IL signature (System.Drawing.Drawing2D.LineCap, System.Drawing.Drawing2D.LineCap, System.Drawing.Drawing2D.DashCap): System.Void use System.Drawing.Pen"
		alias
			"SetLineCap"
		end

	frozen clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Drawing.Pen"
		alias
			"Clone"
		end

	frozen reset_transform is
		external
			"IL signature (): System.Void use System.Drawing.Pen"
		alias
			"ResetTransform"
		end

	frozen scale_transform (sx: REAL; sy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Pen"
		alias
			"ScaleTransform"
		end

	frozen translate_transform (dx: REAL; dy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Pen"
		alias
			"TranslateTransform"
		end

	frozen rotate_transform (angle: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Pen"
		alias
			"RotateTransform"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Pen"
		alias
			"Dispose"
		end

	frozen multiply_transform (matrix: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Pen"
		alias
			"MultiplyTransform"
		end

	frozen scale_transform_single_single_matrix_order (sx: REAL; sy: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Pen"
		alias
			"ScaleTransform"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Pen"
		alias
			"Finalize"
		end

end -- class DRAWING_PEN
