indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.LinearGradientBrush"

frozen external class
	SYSTEM_DRAWING_DRAWING2D_LINEARGRADIENTBRUSH

inherit
	SYSTEM_DRAWING_BRUSH
	SYSTEM_ICLONEABLE
	SYSTEM_IDISPOSABLE

create
	make_lineargradientbrush_4,
	make_lineargradientbrush_7,
	make_lineargradientbrush_6,
	make_lineargradientbrush_1,
	make_lineargradientbrush_3,
	make_lineargradientbrush_2,
	make_lineargradientbrush,
	make_lineargradientbrush_5

feature {NONE} -- Initialization

	frozen make_lineargradientbrush_4 (rect: SYSTEM_DRAWING_RECTANGLEF; color1: SYSTEM_DRAWING_COLOR; color2: SYSTEM_DRAWING_COLOR; angle: REAL) is
		external
			"IL creator signature (System.Drawing.RectangleF, System.Drawing.Color, System.Drawing.Color, System.Single) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

	frozen make_lineargradientbrush_7 (rect: SYSTEM_DRAWING_RECTANGLE; color1: SYSTEM_DRAWING_COLOR; color2: SYSTEM_DRAWING_COLOR; angle: REAL; is_angle_scaleable: BOOLEAN) is
		external
			"IL creator signature (System.Drawing.Rectangle, System.Drawing.Color, System.Drawing.Color, System.Single, System.Boolean) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

	frozen make_lineargradientbrush_6 (rect: SYSTEM_DRAWING_RECTANGLE; color1: SYSTEM_DRAWING_COLOR; color2: SYSTEM_DRAWING_COLOR; angle: REAL) is
		external
			"IL creator signature (System.Drawing.Rectangle, System.Drawing.Color, System.Drawing.Color, System.Single) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

	frozen make_lineargradientbrush_1 (point1: SYSTEM_DRAWING_POINT; point2: SYSTEM_DRAWING_POINT; color1: SYSTEM_DRAWING_COLOR; color2: SYSTEM_DRAWING_COLOR) is
		external
			"IL creator signature (System.Drawing.Point, System.Drawing.Point, System.Drawing.Color, System.Drawing.Color) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

	frozen make_lineargradientbrush_3 (rect: SYSTEM_DRAWING_RECTANGLE; color1: SYSTEM_DRAWING_COLOR; color2: SYSTEM_DRAWING_COLOR; linear_gradient_mode: SYSTEM_DRAWING_DRAWING2D_LINEARGRADIENTMODE) is
		external
			"IL creator signature (System.Drawing.Rectangle, System.Drawing.Color, System.Drawing.Color, System.Drawing.Drawing2D.LinearGradientMode) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

	frozen make_lineargradientbrush_2 (rect: SYSTEM_DRAWING_RECTANGLEF; color1: SYSTEM_DRAWING_COLOR; color2: SYSTEM_DRAWING_COLOR; linear_gradient_mode: SYSTEM_DRAWING_DRAWING2D_LINEARGRADIENTMODE) is
		external
			"IL creator signature (System.Drawing.RectangleF, System.Drawing.Color, System.Drawing.Color, System.Drawing.Drawing2D.LinearGradientMode) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

	frozen make_lineargradientbrush (point1: SYSTEM_DRAWING_POINTF; point2: SYSTEM_DRAWING_POINTF; color1: SYSTEM_DRAWING_COLOR; color2: SYSTEM_DRAWING_COLOR) is
		external
			"IL creator signature (System.Drawing.PointF, System.Drawing.PointF, System.Drawing.Color, System.Drawing.Color) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

	frozen make_lineargradientbrush_5 (rect: SYSTEM_DRAWING_RECTANGLEF; color1: SYSTEM_DRAWING_COLOR; color2: SYSTEM_DRAWING_COLOR; angle: REAL; is_angle_scaleable: BOOLEAN) is
		external
			"IL creator signature (System.Drawing.RectangleF, System.Drawing.Color, System.Drawing.Color, System.Single, System.Boolean) use System.Drawing.Drawing2D.LinearGradientBrush"
		end

feature -- Access

	frozen get_rectangle: SYSTEM_DRAWING_RECTANGLEF is
		external
			"IL signature (): System.Drawing.RectangleF use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"get_Rectangle"
		end

	frozen get_wrap_mode: SYSTEM_DRAWING_DRAWING2D_WRAPMODE is
		external
			"IL signature (): System.Drawing.Drawing2D.WrapMode use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"get_WrapMode"
		end

	frozen get_linear_colors: ARRAY [SYSTEM_DRAWING_COLOR] is
		external
			"IL signature (): System.Drawing.Color[] use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"get_LinearColors"
		end

	frozen get_blend: SYSTEM_DRAWING_DRAWING2D_BLEND is
		external
			"IL signature (): System.Drawing.Drawing2D.Blend use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"get_Blend"
		end

	frozen get_interpolation_colors: SYSTEM_DRAWING_DRAWING2D_COLORBLEND is
		external
			"IL signature (): System.Drawing.Drawing2D.ColorBlend use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"get_InterpolationColors"
		end

	frozen get_transform: SYSTEM_DRAWING_DRAWING2D_MATRIX is
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

	frozen set_linear_colors (value: ARRAY [SYSTEM_DRAWING_COLOR]) is
		external
			"IL signature (System.Drawing.Color[]): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"set_LinearColors"
		end

	frozen set_interpolation_colors (value: SYSTEM_DRAWING_DRAWING2D_COLORBLEND) is
		external
			"IL signature (System.Drawing.Drawing2D.ColorBlend): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"set_InterpolationColors"
		end

	frozen set_blend (value: SYSTEM_DRAWING_DRAWING2D_BLEND) is
		external
			"IL signature (System.Drawing.Drawing2D.Blend): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"set_Blend"
		end

	frozen set_transform (value: SYSTEM_DRAWING_DRAWING2D_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"set_Transform"
		end

	frozen set_wrap_mode (value: SYSTEM_DRAWING_DRAWING2D_WRAPMODE) is
		external
			"IL signature (System.Drawing.Drawing2D.WrapMode): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"set_WrapMode"
		end

feature -- Basic Operations

	frozen rotate_transform_single_matrix_order (angle: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
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

	frozen multiply_transform_matrix_matrix_order (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"MultiplyTransform"
		end

	frozen reset_transform is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"ResetTransform"
		end

	clone: ANY is
		external
			"IL signature (): System.Object use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"Clone"
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

	frozen multiply_transform (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"MultiplyTransform"
		end

	frozen scale_transform_single_single_matrix_order (sx: REAL; sy: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"ScaleTransform"
		end

	frozen translate_transform_single_single_matrix_order (dx: REAL; dy: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.LinearGradientBrush"
		alias
			"TranslateTransform"
		end

end -- class SYSTEM_DRAWING_DRAWING2D_LINEARGRADIENTBRUSH
