indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.TextureBrush"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_TEXTURE_BRUSH

inherit
	DRAWING_BRUSH
	ICLONEABLE
	IDISPOSABLE

create
	make_drawing_texture_brush_4,
	make_drawing_texture_brush_7,
	make_drawing_texture_brush_6,
	make_drawing_texture_brush,
	make_drawing_texture_brush_1,
	make_drawing_texture_brush_3,
	make_drawing_texture_brush_2,
	make_drawing_texture_brush_5

feature {NONE} -- Initialization

	frozen make_drawing_texture_brush_4 (image: DRAWING_IMAGE; dst_rect: DRAWING_RECTANGLE_F) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.RectangleF) use System.Drawing.TextureBrush"
		end

	frozen make_drawing_texture_brush_7 (image: DRAWING_IMAGE; dst_rect: DRAWING_RECTANGLE; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Rectangle, System.Drawing.Imaging.ImageAttributes) use System.Drawing.TextureBrush"
		end

	frozen make_drawing_texture_brush_6 (image: DRAWING_IMAGE; dst_rect: DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Rectangle) use System.Drawing.TextureBrush"
		end

	frozen make_drawing_texture_brush (bitmap: DRAWING_IMAGE) is
		external
			"IL creator signature (System.Drawing.Image) use System.Drawing.TextureBrush"
		end

	frozen make_drawing_texture_brush_1 (image: DRAWING_IMAGE; wrap_mode: DRAWING_WRAP_MODE) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Drawing2D.WrapMode) use System.Drawing.TextureBrush"
		end

	frozen make_drawing_texture_brush_3 (image: DRAWING_IMAGE; wrap_mode: DRAWING_WRAP_MODE; dst_rect: DRAWING_RECTANGLE) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Drawing2D.WrapMode, System.Drawing.Rectangle) use System.Drawing.TextureBrush"
		end

	frozen make_drawing_texture_brush_2 (image: DRAWING_IMAGE; wrap_mode: DRAWING_WRAP_MODE; dst_rect: DRAWING_RECTANGLE_F) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.Drawing2D.WrapMode, System.Drawing.RectangleF) use System.Drawing.TextureBrush"
		end

	frozen make_drawing_texture_brush_5 (image: DRAWING_IMAGE; dst_rect: DRAWING_RECTANGLE_F; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL creator signature (System.Drawing.Image, System.Drawing.RectangleF, System.Drawing.Imaging.ImageAttributes) use System.Drawing.TextureBrush"
		end

feature -- Access

	frozen get_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Drawing.TextureBrush"
		alias
			"get_Image"
		end

	frozen get_transform: DRAWING_MATRIX is
		external
			"IL signature (): System.Drawing.Drawing2D.Matrix use System.Drawing.TextureBrush"
		alias
			"get_Transform"
		end

	frozen get_wrap_mode: DRAWING_WRAP_MODE is
		external
			"IL signature (): System.Drawing.Drawing2D.WrapMode use System.Drawing.TextureBrush"
		alias
			"get_WrapMode"
		end

feature -- Element Change

	frozen set_wrap_mode (value: DRAWING_WRAP_MODE) is
		external
			"IL signature (System.Drawing.Drawing2D.WrapMode): System.Void use System.Drawing.TextureBrush"
		alias
			"set_WrapMode"
		end

	frozen set_transform (value: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.TextureBrush"
		alias
			"set_Transform"
		end

feature -- Basic Operations

	frozen rotate_transform_single_matrix_order (angle: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.TextureBrush"
		alias
			"RotateTransform"
		end

	frozen translate_transform_single_single_matrix_order (dx: REAL; dy: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.TextureBrush"
		alias
			"TranslateTransform"
		end

	frozen multiply_transform_matrix_matrix_order (matrix: DRAWING_MATRIX; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.TextureBrush"
		alias
			"MultiplyTransform"
		end

	frozen scale_transform (sx: REAL; sy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.TextureBrush"
		alias
			"ScaleTransform"
		end

	clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Drawing.TextureBrush"
		alias
			"Clone"
		end

	frozen reset_transform is
		external
			"IL signature (): System.Void use System.Drawing.TextureBrush"
		alias
			"ResetTransform"
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

	frozen scale_transform_single_single_matrix_order (sx: REAL; sy: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.TextureBrush"
		alias
			"ScaleTransform"
		end

	frozen multiply_transform (matrix: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.TextureBrush"
		alias
			"MultiplyTransform"
		end

end -- class DRAWING_TEXTURE_BRUSH
