indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Drawing2D.LinearGradientBrush"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_LINEAR_GRADIENT_BRUSH

inherit
	DRAWING_BRUSH
	ICLONEABLE
	IDISPOSABLE

create
	make_drawing_linear_gradient_brush_2,
	make_drawing_linear_gradient_brush_3,
	make_drawing_linear_gradient_brush_1,
	make_drawing_linear_gradient_brush_6,
	make_drawing_linear_gradient_brush_7,
	make_drawing_linear_gradient_brush_4,
	make_drawing_linear_gradient_brush_5,
	make_drawing_linear_gradient_brush

feature {NONE} -- Initialization

	frozen make_drawing_linear_gradient_brush_2 (rect: DRAWING_RECTANGLE_F; color1: DRAWING_COLOR; color2: DRAWING_COLOR; linear_gradient_mode: DRAWING_LINEAR_GRADIENT_MODE) is
		external
			"IL creator signature (System.Drawing.RectangleF, System.Drawing.Color, System.Drawing.Color, System.Drawing.Drawing2D.LinearGradientMode) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

	frozen make_drawing_linear_gradient_brush_3 (rect: DRAWING_RECTANGLE; color1: DRAWING_COLOR; color2: DRAWING_COLOR; linear_gradient_mode: DRAWING_LINEAR_GRADIENT_MODE) is
		external
			"IL creator signature (System.Drawing.Rectangle, System.Drawing.Color, System.Drawing.Color, System.Drawing.Drawing2D.LinearGradientMode) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

	frozen make_drawing_linear_gradient_brush_1 (point1: DRAWING_POINT; point2: DRAWING_POINT; color1: DRAWING_COLOR; color2: DRAWING_COLOR) is
		external
			"IL creator signature (System.Drawing.Point, System.Drawing.Point, System.Drawing.Color, System.Drawing.Color) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

	frozen make_drawing_linear_gradient_brush_6 (rect: DRAWING_RECTANGLE; color1: DRAWING_COLOR; color2: DRAWING_COLOR; angle: REAL) is
		external
			"IL creator signature (System.Drawing.Rectangle, System.Drawing.Color, System.Drawing.Color, System.Single) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

	frozen make_drawing_linear_gradient_brush_7 (rect: DRAWING_RECTANGLE; color1: DRAWING_COLOR; color2: DRAWING_COLOR; angle: REAL; is_angle_scaleable: BOOLEAN) is
		external
			"IL creator signature (System.Drawing.Rectangle, System.Drawing.Color, System.Drawing.Color, System.Single, System.Boolean) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

	frozen make_drawing_linear_gradient_brush_4 (rect: DRAWING_RECTANGLE_F; color1: DRAWING_COLOR; color2: DRAWING_COLOR; angle: REAL) is
		external
			"IL creator signature (System.Drawing.RectangleF, System.Drawing.Color, System.Drawing.Color, System.Single) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

	frozen make_drawing_linear_gradient_brush_5 (rect: DRAWING_RECTANGLE_F; color1: DRAWING_COLOR; color2: DRAWING_COLOR; angle: REAL; is_angle_scaleable: BOOLEAN) is
		external
			"IL creator signature (System.Drawing.RectangleF, System.Drawing.Color, System.Drawing.Color, System.Single, System.Boolean) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

	frozen make_drawing_linear_gradient_brush (point1: DRAWING_POINT_F; point2: DRAWING_POINT_F; color1: DRAWING_COLOR; color2: DRAWING_COLOR) is
		external
			"IL creator signature (System.Drawing.PointF, System.Drawing.PointF, System.Drawing.Color, System.Drawing.Color) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

feature -- Access

	frozen get_rectangle: DRAWING_RECTANGLE_F is
		external
			"IL signature (): System.Drawing.RectangleF use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"get_Rectangle"
		end

	frozen get_wrap_mode: DRAWING_WRAP_MODE is
		external
			"IL signature (): System.Drawing.Drawing2D.WrapMode use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"get_WrapMode"
		end

	frozen get_linear_colors: NATIVE_ARRAY [DRAWING_COLOR] is
		external
			"IL signature (): System.Drawing.Color[] use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"get_LinearColors"
		end

	frozen get_blend: DRAWING_BLEND is
		external
			"IL signature (): System.Drawing.Drawing2D.Blend use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"get_Blend"
		end

	frozen get_interpolation_colors: DRAWING_COLOR_BLEND is
		external
			"IL signature (): System.Drawing.Drawing2D.ColorBlend use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"get_InterpolationColors"
		end

	frozen get_transform: DRAWING_MATRIX is
		external
			"IL signature (): System.Drawing.Drawing2D.Matrix use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"get_Transform"
		end

	frozen get_gamma_correction: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"get_GammaCorrection"
		end

feature -- Element Change

	frozen set_gamma_correction (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"set_GammaCorrection"
		end

	frozen set_linear_colors (value: NATIVE_ARRAY [DRAWING_COLOR]) is
		external
			"IL signature (System.Drawing.Color[]): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"set_LinearColors"
		end

	frozen set_interpolation_colors (value: DRAWING_COLOR_BLEND) is
		external
			"IL signature (System.Drawing.Drawing2D.ColorBlend): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"set_InterpolationColors"
		end

	frozen set_blend (value: DRAWING_BLEND) is
		external
			"IL signature (System.Drawing.Drawing2D.Blend): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"set_Blend"
		end

	frozen set_transform (value: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"set_Transform"
		end

	frozen set_wrap_mode (value: DRAWING_WRAP_MODE) is
		external
			"IL signature (System.Drawing.Drawing2D.WrapMode): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"set_WrapMode"
		end

feature -- Basic Operations

	frozen rotate_transform_single_matrix_order (angle: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"RotateTransform"
		end

	frozen translate_transform (dx: REAL; dy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"TranslateTransform"
		end

	frozen multiply_transform_matrix_matrix_order (matrix: DRAWING_MATRIX; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"MultiplyTransform"
		end

	frozen set_blend_triangular_shape_single_single (focus: REAL; scale: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"SetBlendTriangularShape"
		end

	frozen scale_transform (sx: REAL; sy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"ScaleTransform"
		end

	clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"Clone"
		end

	frozen reset_transform is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"ResetTransform"
		end

	frozen set_sigma_bell_shape_single_single (focus: REAL; scale: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"SetSigmaBellShape"
		end

	frozen rotate_transform (angle: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"RotateTransform"
		end

	frozen set_sigma_bell_shape (focus: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"SetSigmaBellShape"
		end

	frozen set_blend_triangular_shape (focus: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"SetBlendTriangularShape"
		end

	frozen multiply_transform (matrix: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"MultiplyTransform"
		end

	frozen scale_transform_single_single_matrix_order (sx: REAL; sy: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"ScaleTransform"
		end

	frozen translate_transform_single_single_matrix_order (dx: REAL; dy: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"TranslateTransform"
		end

end -- class DRAWING_LINEAR_GRADIENT_BRUSH
