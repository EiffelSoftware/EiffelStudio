indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Drawing2D.PathGradientBrush"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_PATH_GRADIENT_BRUSH

inherit
	DRAWING_BRUSH
	ICLONEABLE
	IDISPOSABLE

create
	make_drawing_path_gradient_brush_1,
	make_drawing_path_gradient_brush_4,
	make_drawing_path_gradient_brush,
	make_drawing_path_gradient_brush_2,
	make_drawing_path_gradient_brush_3

feature {NONE} -- Initialization

	frozen make_drawing_path_gradient_brush_1 (points: NATIVE_ARRAY [DRAWING_POINT_F]; wrap_mode: DRAWING_WRAP_MODE) is
		external
			"IL creator signature (System.Drawing.PointF[], System.Drawing.Drawing2D.WrapMode) use System.Drawing.Drawing2D.PathGradientBrush"
		end

	frozen make_drawing_path_gradient_brush_4 (path: DRAWING_GRAPHICS_PATH) is
		external
			"IL creator signature (System.Drawing.Drawing2D.GraphicsPath) use System.Drawing.Drawing2D.PathGradientBrush"
		end

	frozen make_drawing_path_gradient_brush (points: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL creator signature (System.Drawing.PointF[]) use System.Drawing.Drawing2D.PathGradientBrush"
		end

	frozen make_drawing_path_gradient_brush_2 (points: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL creator signature (System.Drawing.Point[]) use System.Drawing.Drawing2D.PathGradientBrush"
		end

	frozen make_drawing_path_gradient_brush_3 (points: NATIVE_ARRAY [DRAWING_POINT]; wrap_mode: DRAWING_WRAP_MODE) is
		external
			"IL creator signature (System.Drawing.Point[], System.Drawing.Drawing2D.WrapMode) use System.Drawing.Drawing2D.PathGradientBrush"
		end

feature -- Access

	frozen get_focus_scales: DRAWING_POINT_F is
		external
			"IL signature (): System.Drawing.PointF use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_FocusScales"
		end

	frozen get_blend: DRAWING_BLEND is
		external
			"IL signature (): System.Drawing.Drawing2D.Blend use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_Blend"
		end

	frozen get_surround_colors: NATIVE_ARRAY [DRAWING_COLOR] is
		external
			"IL signature (): System.Drawing.Color[] use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_SurroundColors"
		end

	frozen get_wrap_mode: DRAWING_WRAP_MODE is
		external
			"IL signature (): System.Drawing.Drawing2D.WrapMode use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_WrapMode"
		end

	frozen get_center_point: DRAWING_POINT_F is
		external
			"IL signature (): System.Drawing.PointF use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_CenterPoint"
		end

	frozen get_transform: DRAWING_MATRIX is
		external
			"IL signature (): System.Drawing.Drawing2D.Matrix use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_Transform"
		end

	frozen get_interpolation_colors: DRAWING_COLOR_BLEND is
		external
			"IL signature (): System.Drawing.Drawing2D.ColorBlend use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_InterpolationColors"
		end

	frozen get_center_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_CenterColor"
		end

	frozen get_rectangle: DRAWING_RECTANGLE_F is
		external
			"IL signature (): System.Drawing.RectangleF use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_Rectangle"
		end

feature -- Element Change

	frozen set_interpolation_colors (value: DRAWING_COLOR_BLEND) is
		external
			"IL signature (System.Drawing.Drawing2D.ColorBlend): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_InterpolationColors"
		end

	frozen set_center_point (value: DRAWING_POINT_F) is
		external
			"IL signature (System.Drawing.PointF): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_CenterPoint"
		end

	frozen set_surround_colors (value: NATIVE_ARRAY [DRAWING_COLOR]) is
		external
			"IL signature (System.Drawing.Color[]): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_SurroundColors"
		end

	frozen set_blend (value: DRAWING_BLEND) is
		external
			"IL signature (System.Drawing.Drawing2D.Blend): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_Blend"
		end

	frozen set_center_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_CenterColor"
		end

	frozen set_wrap_mode (value: DRAWING_WRAP_MODE) is
		external
			"IL signature (System.Drawing.Drawing2D.WrapMode): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_WrapMode"
		end

	frozen set_transform (value: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_Transform"
		end

	frozen set_focus_scales (value: DRAWING_POINT_F) is
		external
			"IL signature (System.Drawing.PointF): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_FocusScales"
		end

feature -- Basic Operations

	frozen rotate_transform_single_matrix_order (angle: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"RotateTransform"
		end

	frozen translate_transform (dx: REAL; dy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"TranslateTransform"
		end

	frozen multiply_transform_matrix_matrix_order (matrix: DRAWING_MATRIX; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"MultiplyTransform"
		end

	frozen set_blend_triangular_shape_single_single (focus: REAL; scale: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"SetBlendTriangularShape"
		end

	frozen scale_transform (sx: REAL; sy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"ScaleTransform"
		end

	clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"Clone"
		end

	frozen reset_transform is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"ResetTransform"
		end

	frozen set_sigma_bell_shape_single_single (focus: REAL; scale: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"SetSigmaBellShape"
		end

	frozen rotate_transform (angle: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"RotateTransform"
		end

	frozen set_sigma_bell_shape (focus: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"SetSigmaBellShape"
		end

	frozen set_blend_triangular_shape (focus: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"SetBlendTriangularShape"
		end

	frozen multiply_transform (matrix: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"MultiplyTransform"
		end

	frozen scale_transform_single_single_matrix_order (sx: REAL; sy: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"ScaleTransform"
		end

	frozen translate_transform_single_single_matrix_order (dx: REAL; dy: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"TranslateTransform"
		end

end -- class DRAWING_PATH_GRADIENT_BRUSH
