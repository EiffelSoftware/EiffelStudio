indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.TextureBrush"

frozen external class
	SYSTEM_DRAWING_TEXTUREBRUSH

inherit
	SYSTEM_DRAWING_BRUSH
	SYSTEM_ICLONEABLE
	SYSTEM_IDISPOSABLE

create
	make_texturebrush_7,
	make_texturebrush,
	make_texturebrush_6,
	make_texturebrush_1,
	make_texturebrush_3,
	make_texturebrush_2,
	make_texturebrush_5,
	make_texturebrush_4

feature {NONE} -- Initialization

	frozen make_texturebrush_7 (image: SYSTEM_DRAWING_IMAGE; dst_rect: SYSTEM_DRAWING_RECTANGLE; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Rectangle, System.Drawing.Imaging.ImageAttributes) use System.Drawing.TextureBrush"
		end

	frozen make_texturebrush (bitmap: SYSTEM_DRAWING_IMAGE) is
		external
			"IL creator signature (System.Drawing.Image) use System.Drawing.TextureBrush"
		end

	frozen make_texturebrush_6 (image: SYSTEM_DRAWING_IMAGE; dst_rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Rectangle) use System.Drawing.TextureBrush"
		end

	frozen make_texturebrush_1 (image: SYSTEM_DRAWING_IMAGE; wrap_mode: SYSTEM_DRAWING_DRAWING2D_WRAPMODE) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Drawing2D.WrapMode) use System.Drawing.TextureBrush"
		end

	frozen make_texturebrush_3 (image: SYSTEM_DRAWING_IMAGE; wrap_mode: SYSTEM_DRAWING_DRAWING2D_WRAPMODE; dst_rect: SYSTEM_DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Drawing2D.WrapMode, System.Drawing.Rectangle) use System.Drawing.TextureBrush"
		end

	frozen make_texturebrush_2 (image: SYSTEM_DRAWING_IMAGE; wrap_mode: SYSTEM_DRAWING_DRAWING2D_WRAPMODE; dst_rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Drawing2D.WrapMode, System.Drawing.RectangleF) use System.Drawing.TextureBrush"
		end

	frozen make_texturebrush_5 (image: SYSTEM_DRAWING_IMAGE; dst_rect: SYSTEM_DRAWING_RECTANGLEF; image_attr: SYSTEM_DRAWING_IMAGING_IMAGEATTRIBUTES) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.RectangleF, System.Drawing.Imaging.ImageAttributes) use System.Drawing.TextureBrush"
		end

	frozen make_texturebrush_4 (image: SYSTEM_DRAWING_IMAGE; dst_rect: SYSTEM_DRAWING_RECTANGLEF) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.RectangleF) use System.Drawing.TextureBrush"
		end

feature -- Access

	frozen get_image: SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Drawing.TextureBrush"
		alias
			"get_Image"
		end

	frozen get_transform: SYSTEM_DRAWING_DRAWING2D_MATRIX is
		external
			"IL signature (): System.Drawing.Drawing2D.Matrix use System.Drawing.TextureBrush"
		alias
			"get_Transform"
		end

	frozen get_wrap_mode: SYSTEM_DRAWING_DRAWING2D_WRAPMODE is
		external
			"IL signature (): System.Drawing.Drawing2D.WrapMode use System.Drawing.TextureBrush"
		alias
			"get_WrapMode"
		end

feature -- Element Change

	frozen set_wrap_mode (value: SYSTEM_DRAWING_DRAWING2D_WRAPMODE) is
		external
			"IL signature (System.Drawing.Drawing2D.WrapMode): System.Void use System.Drawing.TextureBrush"
		alias
			"set_WrapMode"
		end

	frozen set_transform (value: SYSTEM_DRAWING_DRAWING2D_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.TextureBrush"
		alias
			"set_Transform"
		end

feature -- Basic Operations

	frozen rotate_transform_single_matrix_order (angle: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.TextureBrush"
		alias
			"RotateTransform"
		end

	frozen translate_transform_single_single_matrix_order (dx: REAL; dy: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.TextureBrush"
		alias
			"TranslateTransform"
		end

	frozen scale_transform (sx: REAL; sy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.TextureBrush"
		alias
			"ScaleTransform"
		end

	frozen multiply_transform_matrix_matrix_order (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.TextureBrush"
		alias
			"MultiplyTransform"
		end

	frozen reset_transform is
		external
			"IL signature (): System.Void use System.Drawing.TextureBrush"
		alias
			"ResetTransform"
		end

	clone: ANY is
		external
			"IL signature (): System.Object use System.Drawing.TextureBrush"
		alias
			"Clone"
		end

	frozen translate_transform (dx: REAL; dy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.TextureBrush"
		alias
			"TranslateTransform"
		end

	frozen rotate_transform (angle: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.TextureBrush"
		alias
			"RotateTransform"
		end

	frozen scale_transform_single_single_matrix_order (sx: REAL; sy: REAL; order: SYSTEM_DRAWING_DRAWING2D_MATRIXORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.TextureBrush"
		alias
			"ScaleTransform"
		end

	frozen multiply_transform (matrix: SYSTEM_DRAWING_DRAWING2D_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.TextureBrush"
		alias
			"MultiplyTransform"
		end

end -- class SYSTEM_DRAWING_TEXTUREBRUSH
