indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Drawing2D.PathGradientBrush"

frozen external class
	SYSTEM_DRAWING_DRAWING2D_PATHGRADIENTBRUSH

inherit
	SYSTEM_DRAWING_BRUSH
	SYSTEM_ICLONEABLE
	SYSTEM_IDISPOSABLE

create
	make_pathgradientbrush_1,
	make_pathgradientbrush_3,
	make_pathgradientbrush_2,
	make_pathgradientbrush,
	make_pathgradientbrush_4

feature {NONE} -- Initialization

	frozen make_pathgradientbrush_1 (points: ARRAY [SYSTEM_DRAWING_POINTF]; wrap_mode: SYSTEM_DRAWING_DRAWING2D_WRAPMODE) is
		external
			"IL creator signature (System.Drawing.PointF[], System.Drawing.Drawing2D.WrapMode) use System.Drawing.Drawing2D.PathGradientBrush"
		end

	frozen make_pathgradientbrush_3 (points: ARRAY [SYSTEM_DRAWING_POINT]; wrap_mode: SYSTEM_DRAWING_DRAWING2D_WRAPMODE) is
		external
			"IL creator signature (System.Drawing.Point[], System.Drawing.Drawing2D.WrapMode) use System.Drawing.Drawing2D.PathGradientBrush"
		end

	frozen make_pathgradientbrush_2 (points: ARRAY [SYSTEM_DRAWING_POINT]) is
		external
			"IL creator signature (System.Drawing.Point[]) use System.Drawing.Drawing2D.PathGradientBrush"
		end

	frozen make_pathgradientbrush (points: ARRAY [SYSTEM_DRAWING_POINTF]) is
		external
			"IL creator signature (System.Drawing.PointF[]) use System.Drawing.Drawing2D.PathGradientBrush"
		end

	frozen make_pathgradientbrush_4 (path: SYSTEM_DRAWING_DRAWING2D_GRAPHICSPATH) is
		external
			"IL creator signature (System.Drawing.Drawing2D.GraphicsPath) use System.Drawing.Drawing2D.PathGradientBrush"
		end

feature -- Access

	frozen get_focus_scales: SYSTEM_DRAWING_POINTF is
		external
			"IL signature (): System.Drawing.PointF use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_FocusScales"
		end

	frozen get_blend: SYSTEM_DRAWING_DRAWING2D_BLEND is
		external
			"IL signature (): System.Drawing.Drawing2D.Blend use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_Blend"
		end

	frozen get_surround_colors: ARRAY [SYSTEM_DRAWING_COLOR] is
		external
			"IL signature (): System.Drawing.Color[] use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_SurroundColors"
		end

	frozen get_wrap_mode: SYSTEM_DRAWING_DRAWING2D_WRAPMODE is
		external
			"IL signature (): System.Drawing.Drawing2D.WrapMode use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_WrapMode"
		end

	frozen get_center_point: SYSTEM_DRAWING_POINTF is
		external
			"IL signature (): System.Drawing.PointF use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_CenterPoint"
		end

	frozen get_transform: SYSTEM_DRAWING_DRAWING2D_MATRIX is
		external
			"IL signature (): System.Drawing.Drawing2D.Matrix use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_Transform"
		end

	frozen get_interpolation_colors: SYSTEM_DRAWING_DRAWING2D_COLORBLEND is
		external
			"IL signature (): System.Drawing.Drawing2D.ColorBlend use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_InterpolationColors"
		end

	frozen get_center_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_CenterColor"
		end

	frozen get_rectangle: SYSTEM_DRAWING_RECTANGLEF is
		external
			"IL signature (): System.Drawing.RectangleF use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"get_Rectangle"
		end

feature -- Element Change

	frozen set_interpolation_colors (value: SYSTEM_DRAWING_DRAWING2D_COLORBLEND) is
		external
			"IL signature (System.Drawing.Drawing2D.ColorBlend): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_InterpolationColors"
		end

	frozen set_center_point (value: SYSTEM_DRAWING_POINTF) is
		external
			"IL signature (System.Drawing.PointF): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_CenterPoint"
		end

	frozen set_surround_colors (value: ARRAY [SYSTEM_DRAWING_COLOR]) is
		external
			"IL signature (System.Drawing.Color[]): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_SurroundColors"
		end

	frozen set_blend (value: SYSTEM_DRAWING_DRAWING2D_BLEND) is
		external
			"IL signature (System.Drawing.Drawing2D.Blend): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_Blend"
		end

	frozen set_center_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_CenterColor"
		end

	frozen set_wrap_mode (value: SYSTEM_DRAWING_DRAWING2D_WRAPMODE) is
		external
			"IL signature (System.Drawing.Drawing2D.WrapMode): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_WrapMode"
		end

	frozen set_transform (value: SYSTEM_DRAWING_DRAWING2D_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_Transform"
		end

	frozen set_focus_scales (value: SYSTEM_DRAWING_POINTF) is
		external
			"IL signature (System.Drawing.PointF): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"set_FocusScales"
		end

feature -- Basic Operations

	frozen rotate_transform_single_matrix_order (angle: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
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

	frozen multiply_transform_matrix_matrix_order (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"MultiplyTransform"
		end

	frozen reset_transform is
		external
			"IL signature (): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"ResetTransform"
		end

	clone: ANY is
		external
			"IL signature (): System.Object use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"Clone"
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

	frozen multiply_transform (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"MultiplyTransform"
		end

	frozen scale_transform_single_single_matrix_order (sx: REAL; sy: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"ScaleTransform"
		end

	frozen translate_transform_single_single_matrix_order (dx: REAL; dy: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Drawing2D.PathGradientBrush"
		alias
			"TranslateTransform"
		end

end -- class SYSTEM_DRAWING_DRAWING2D_PATHGRADIENTBRUSH
