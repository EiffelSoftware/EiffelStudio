indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Graphics"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_GRAPHICS

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			finalize
		end
	IDISPOSABLE

create {NONE}

feature -- Access

	frozen get_visible_clip_bounds: DRAWING_RECTANGLE_F is
		external
			"IL signature (): System.Drawing.RectangleF use System.Drawing.Graphics"
		alias
			"get_VisibleClipBounds"
		end

	frozen get_page_scale: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Graphics"
		alias
			"get_PageScale"
		end

	frozen get_smoothing_mode: DRAWING_SMOOTHING_MODE is
		external
			"IL signature (): System.Drawing.Drawing2D.SmoothingMode use System.Drawing.Graphics"
		alias
			"get_SmoothingMode"
		end

	frozen get_text_rendering_hint: DRAWING_TEXT_RENDERING_HINT is
		external
			"IL signature (): System.Drawing.Text.TextRenderingHint use System.Drawing.Graphics"
		alias
			"get_TextRenderingHint"
		end

	frozen get_dpi_y: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Graphics"
		alias
			"get_DpiY"
		end

	frozen get_dpi_x: REAL is
		external
			"IL signature (): System.Single use System.Drawing.Graphics"
		alias
			"get_DpiX"
		end

	frozen get_clip_bounds: DRAWING_RECTANGLE_F is
		external
			"IL signature (): System.Drawing.RectangleF use System.Drawing.Graphics"
		alias
			"get_ClipBounds"
		end

	frozen get_transform: DRAWING_MATRIX is
		external
			"IL signature (): System.Drawing.Drawing2D.Matrix use System.Drawing.Graphics"
		alias
			"get_Transform"
		end

	frozen get_pixel_offset_mode: DRAWING_PIXEL_OFFSET_MODE is
		external
			"IL signature (): System.Drawing.Drawing2D.PixelOffsetMode use System.Drawing.Graphics"
		alias
			"get_PixelOffsetMode"
		end

	frozen get_is_clip_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Graphics"
		alias
			"get_IsClipEmpty"
		end

	frozen get_compositing_mode: DRAWING_COMPOSITING_MODE is
		external
			"IL signature (): System.Drawing.Drawing2D.CompositingMode use System.Drawing.Graphics"
		alias
			"get_CompositingMode"
		end

	frozen get_rendering_origin: DRAWING_POINT is
		external
			"IL signature (): System.Drawing.Point use System.Drawing.Graphics"
		alias
			"get_RenderingOrigin"
		end

	frozen get_page_unit: DRAWING_GRAPHICS_UNIT is
		external
			"IL signature (): System.Drawing.GraphicsUnit use System.Drawing.Graphics"
		alias
			"get_PageUnit"
		end

	frozen get_compositing_quality: DRAWING_COMPOSITING_QUALITY is
		external
			"IL signature (): System.Drawing.Drawing2D.CompositingQuality use System.Drawing.Graphics"
		alias
			"get_CompositingQuality"
		end

	frozen get_clip: DRAWING_REGION is
		external
			"IL signature (): System.Drawing.Region use System.Drawing.Graphics"
		alias
			"get_Clip"
		end

	frozen get_interpolation_mode: DRAWING_INTERPOLATION_MODE is
		external
			"IL signature (): System.Drawing.Drawing2D.InterpolationMode use System.Drawing.Graphics"
		alias
			"get_InterpolationMode"
		end

	frozen get_text_contrast: INTEGER is
		external
			"IL signature (): System.Int32 use System.Drawing.Graphics"
		alias
			"get_TextContrast"
		end

	frozen get_is_visible_clip_empty: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Drawing.Graphics"
		alias
			"get_IsVisibleClipEmpty"
		end

feature -- Element Change

	frozen set_compositing_quality (value: DRAWING_COMPOSITING_QUALITY) is
		external
			"IL signature (System.Drawing.Drawing2D.CompositingQuality): System.Void use System.Drawing.Graphics"
		alias
			"set_CompositingQuality"
		end

	frozen set_page_unit (value: DRAWING_GRAPHICS_UNIT) is
		external
			"IL signature (System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"set_PageUnit"
		end

	frozen set_pixel_offset_mode (value: DRAWING_PIXEL_OFFSET_MODE) is
		external
			"IL signature (System.Drawing.Drawing2D.PixelOffsetMode): System.Void use System.Drawing.Graphics"
		alias
			"set_PixelOffsetMode"
		end

	frozen set_text_rendering_hint (value: DRAWING_TEXT_RENDERING_HINT) is
		external
			"IL signature (System.Drawing.Text.TextRenderingHint): System.Void use System.Drawing.Graphics"
		alias
			"set_TextRenderingHint"
		end

	frozen set_interpolation_mode (value: DRAWING_INTERPOLATION_MODE) is
		external
			"IL signature (System.Drawing.Drawing2D.InterpolationMode): System.Void use System.Drawing.Graphics"
		alias
			"set_InterpolationMode"
		end

	frozen set_transform (value: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Graphics"
		alias
			"set_Transform"
		end

	frozen set_page_scale (value: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Graphics"
		alias
			"set_PageScale"
		end

	frozen set_text_contrast (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"set_TextContrast"
		end

	frozen set_clip_region (value: DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Drawing.Graphics"
		alias
			"set_Clip"
		end

	frozen set_compositing_mode (value: DRAWING_COMPOSITING_MODE) is
		external
			"IL signature (System.Drawing.Drawing2D.CompositingMode): System.Void use System.Drawing.Graphics"
		alias
			"set_CompositingMode"
		end

	frozen set_rendering_origin (value: DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Point): System.Void use System.Drawing.Graphics"
		alias
			"set_RenderingOrigin"
		end

	frozen set_smoothing_mode (value: DRAWING_SMOOTHING_MODE) is
		external
			"IL signature (System.Drawing.Drawing2D.SmoothingMode): System.Void use System.Drawing.Graphics"
		alias
			"set_SmoothingMode"
		end

feature -- Basic Operations

	frozen draw_image_unscaled_image_int32_int32 (image: DRAWING_IMAGE; x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Drawing.Image, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawImageUnscaled"
		end

	frozen draw_bezier_pen_point_f (pen: DRAWING_PEN; pt1: DRAWING_POINT_F; pt2: DRAWING_POINT_F; pt3: DRAWING_POINT_F; pt4: DRAWING_POINT_F) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF, System.Drawing.PointF, System.Drawing.PointF, System.Drawing.PointF): System.Void use System.Drawing.Graphics"
		alias
			"DrawBezier"
		end

	frozen enumerate_metafile_metafile_point_rectangle_graphics_unit_enumerate_metafile_proc_int_ptr (metafile: DRAWING_METAFILE; dest_point: DRAWING_POINT; src_rect: DRAWING_RECTANGLE; src_unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point, System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen scale_transform (sx: REAL; sy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"ScaleTransform"
		end

	frozen draw_lines_pen_array_point_f (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawLines"
		end

	frozen draw_closed_curve_pen_array_point_f (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawClosedCurve"
		end

	frozen fill_rectangle_brush_rectangle_f (brush: DRAWING_BRUSH; rect: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.RectangleF): System.Void use System.Drawing.Graphics"
		alias
			"FillRectangle"
		end

	frozen enumerate_metafile_metafile_array_point_enumerate_metafile_proc (metafile: DRAWING_METAFILE; dest_points: NATIVE_ARRAY [DRAWING_POINT]; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point[], System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_image_unscaled_image_int32_int32_int32 (image: DRAWING_IMAGE; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Drawing.Image, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawImageUnscaled"
		end

	frozen draw_image_image_array_point_rectangle_graphics_unit (image: DRAWING_IMAGE; dest_points: NATIVE_ARRAY [DRAWING_POINT]; src_rect: DRAWING_RECTANGLE; src_unit: DRAWING_GRAPHICS_UNIT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Point[], System.Drawing.Rectangle, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen fill_pie_brush_int32 (brush: DRAWING_BRUSH; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; start_angle: INTEGER; sweep_angle: INTEGER) is
		external
			"IL signature (System.Drawing.Brush, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"FillPie"
		end

	frozen enumerate_metafile_metafile_array_point_f_enumerate_metafile_proc_int_ptr (metafile: DRAWING_METAFILE; dest_points: NATIVE_ARRAY [DRAWING_POINT_F]; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF[], System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_image_image_rectangle_f (image: DRAWING_IMAGE; rect: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.RectangleF): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_image_image_rectangle_single_single_single_single_graphics_unit (image: DRAWING_IMAGE; dest_rect: DRAWING_RECTANGLE; src_x: REAL; src_y: REAL; src_width: REAL; src_height: REAL; src_unit: DRAWING_GRAPHICS_UNIT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Single, System.Single, System.Single, System.Single, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen measure_string_string_font_point_f (text: SYSTEM_STRING; font: DRAWING_FONT; origin: DRAWING_POINT_F; string_format: DRAWING_STRING_FORMAT): DRAWING_SIZE_F is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.PointF, System.Drawing.StringFormat): System.Drawing.SizeF use System.Drawing.Graphics"
		alias
			"MeasureString"
		end

	frozen enumerate_metafile (metafile: DRAWING_METAFILE; dest_point: DRAWING_POINT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen measure_string_string_font_size_f_string_format (text: SYSTEM_STRING; font: DRAWING_FONT; layout_area: DRAWING_SIZE_F; string_format: DRAWING_STRING_FORMAT): DRAWING_SIZE_F is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.SizeF, System.Drawing.StringFormat): System.Drawing.SizeF use System.Drawing.Graphics"
		alias
			"MeasureString"
		end

	frozen get_hdc: POINTER is
		external
			"IL signature (): System.IntPtr use System.Drawing.Graphics"
		alias
			"GetHdc"
		end

	frozen enumerate_metafile_metafile_array_point_f_rectangle_f_graphics_unit_enumerate_metafile_proc_int_ptr (metafile: DRAWING_METAFILE; dest_points: NATIVE_ARRAY [DRAWING_POINT_F]; src_rect: DRAWING_RECTANGLE_F; src_unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_rectangle_pen_single (pen: DRAWING_PEN; x: REAL; y: REAL; width: REAL; height: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawRectangle"
		end

	frozen set_clip_graphics (g: DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Graphics): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen is_visible_rectangle_f (rect: DRAWING_RECTANGLE_F): BOOLEAN is
		external
			"IL signature (System.Drawing.RectangleF): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen enumerate_metafile_metafile_rectangle_f_rectangle_f_graphics_unit_enumerate_metafile_proc (metafile: DRAWING_METAFILE; dest_rect: DRAWING_RECTANGLE_F; src_rect: DRAWING_RECTANGLE_F; src_unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.RectangleF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen translate_transform (dx: REAL; dy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"TranslateTransform"
		end

	frozen set_clip (rect: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen set_clip_graphics_combine_mode (g: DRAWING_GRAPHICS; combine_mode: DRAWING_COMBINE_MODE) is
		external
			"IL signature (System.Drawing.Graphics, System.Drawing.Drawing2D.CombineMode): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen measure_string_string_font_int32_string_format (text: SYSTEM_STRING; font: DRAWING_FONT; width: INTEGER; format: DRAWING_STRING_FORMAT): DRAWING_SIZE_F is
		external
			"IL signature (System.String, System.Drawing.Font, System.Int32, System.Drawing.StringFormat): System.Drawing.SizeF use System.Drawing.Graphics"
		alias
			"MeasureString"
		end

	frozen end_container (container: DRAWING_GRAPHICS_CONTAINER) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsContainer): System.Void use System.Drawing.Graphics"
		alias
			"EndContainer"
		end

	frozen fill_pie_brush_single (brush: DRAWING_BRUSH; x: REAL; y: REAL; width: REAL; height: REAL; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Brush, System.Single, System.Single, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"FillPie"
		end

	frozen measure_string_string_font_size_f_string_format_int32 (text: SYSTEM_STRING; font: DRAWING_FONT; layout_area: DRAWING_SIZE_F; string_format: DRAWING_STRING_FORMAT; characters_fitted: INTEGER; lines_filled: INTEGER): DRAWING_SIZE_F is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.SizeF, System.Drawing.StringFormat, System.Int32&, System.Int32&): System.Drawing.SizeF use System.Drawing.Graphics"
		alias
			"MeasureString"
		end

	frozen release_hdc (hdc: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"ReleaseHdc"
		end

	frozen draw_image_image_array_point_f_rectangle_f_graphics_unit_image_attributes_draw_image_abort (image: DRAWING_IMAGE; dest_points: NATIVE_ARRAY [DRAWING_POINT_F]; src_rect: DRAWING_RECTANGLE_F; src_unit: DRAWING_GRAPHICS_UNIT; image_attr: DRAWING_IMAGE_ATTRIBUTES; callback: DRAWING_DRAW_IMAGE_ABORT_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen fill_ellipse_brush_int32 (brush: DRAWING_BRUSH; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Drawing.Brush, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"FillEllipse"
		end

	frozen draw_image_image_array_point_f_rectangle_f_graphics_unit (image: DRAWING_IMAGE; dest_points: NATIVE_ARRAY [DRAWING_POINT_F]; src_rect: DRAWING_RECTANGLE_F; src_unit: DRAWING_GRAPHICS_UNIT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen reset_clip is
		external
			"IL signature (): System.Void use System.Drawing.Graphics"
		alias
			"ResetClip"
		end

	frozen draw_image (image: DRAWING_IMAGE; point: DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Point): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen fill_polygon_brush_array_point_fill_mode (brush: DRAWING_BRUSH; points: NATIVE_ARRAY [DRAWING_POINT]; fill_mode: DRAWING_FILL_MODE) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Point[], System.Drawing.Drawing2D.FillMode): System.Void use System.Drawing.Graphics"
		alias
			"FillPolygon"
		end

	frozen measure_string (text: SYSTEM_STRING; font: DRAWING_FONT): DRAWING_SIZE_F is
		external
			"IL signature (System.String, System.Drawing.Font): System.Drawing.SizeF use System.Drawing.Graphics"
		alias
			"MeasureString"
		end

	frozen fill_rectangles (brush: DRAWING_BRUSH; rects: NATIVE_ARRAY [DRAWING_RECTANGLE]) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Rectangle[]): System.Void use System.Drawing.Graphics"
		alias
			"FillRectangles"
		end

	frozen draw_image_image_array_point_f_rectangle_f_graphics_unit_image_attributes_draw_image_abort_int32 (image: DRAWING_IMAGE; dest_points: NATIVE_ARRAY [DRAWING_POINT_F]; src_rect: DRAWING_RECTANGLE_F; src_unit: DRAWING_GRAPHICS_UNIT; image_attr: DRAWING_IMAGE_ATTRIBUTES; callback: DRAWING_DRAW_IMAGE_ABORT_IN_DRAWING_GRAPHICS; callback_data: INTEGER) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_path (pen: DRAWING_PEN; path: DRAWING_GRAPHICS_PATH) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Drawing2D.GraphicsPath): System.Void use System.Drawing.Graphics"
		alias
			"DrawPath"
		end

	frozen is_visible_point (point: DRAWING_POINT): BOOLEAN is
		external
			"IL signature (System.Drawing.Point): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen draw_image_image_single_single_rectangle_f (image: DRAWING_IMAGE; x: REAL; y: REAL; src_rect: DRAWING_RECTANGLE_F; src_unit: DRAWING_GRAPHICS_UNIT) is
		external
			"IL signature (System.Drawing.Image, System.Single, System.Single, System.Drawing.RectangleF, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_line_pen_int32 (pen: DRAWING_PEN; x1: INTEGER; y1: INTEGER; x2: INTEGER; y2: INTEGER) is
		external
			"IL signature (System.Drawing.Pen, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawLine"
		end

	frozen enumerate_metafile_metafile_rectangle_enumerate_metafile_proc_int_ptr_image_attributes (metafile: DRAWING_METAFILE; dest_rect: DRAWING_RECTANGLE; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Rectangle, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen enumerate_metafile_metafile_array_point_rectangle_graphics_unit_enumerate_metafile_proc_int_ptr_image_attributes (metafile: DRAWING_METAFILE; dest_points: NATIVE_ARRAY [DRAWING_POINT]; src_rect: DRAWING_RECTANGLE; unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point[], System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen rotate_transform (angle: REAL) is
		external
			"IL signature (System.Single): System.Void use System.Drawing.Graphics"
		alias
			"RotateTransform"
		end

	frozen translate_clip (dx: INTEGER; dy: INTEGER) is
		external
			"IL signature (System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"TranslateClip"
		end

	frozen clear (color: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Drawing.Graphics"
		alias
			"Clear"
		end

	frozen draw_bezier (pen: DRAWING_PEN; pt1: DRAWING_POINT; pt2: DRAWING_POINT; pt3: DRAWING_POINT; pt4: DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point, System.Drawing.Point, System.Drawing.Point, System.Drawing.Point): System.Void use System.Drawing.Graphics"
		alias
			"DrawBezier"
		end

	frozen draw_polygon_pen_array_point_f (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawPolygon"
		end

	frozen intersect_clip_rectangle (rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"IntersectClip"
		end

	frozen restore (gstate: DRAWING_GRAPHICS_STATE) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsState): System.Void use System.Drawing.Graphics"
		alias
			"Restore"
		end

	frozen draw_lines (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawLines"
		end

	frozen enumerate_metafile_metafile_point_enumerate_metafile_proc_int_ptr (metafile: DRAWING_METAFILE; dest_point: DRAWING_POINT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen enumerate_metafile_metafile_array_point_enumerate_metafile_proc_int_ptr (metafile: DRAWING_METAFILE; dest_points: NATIVE_ARRAY [DRAWING_POINT]; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point[], System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen from_hdc_int_ptr_int_ptr (hdc: POINTER; hdevice: POINTER): DRAWING_GRAPHICS is
		external
			"IL static signature (System.IntPtr, System.IntPtr): System.Drawing.Graphics use System.Drawing.Graphics"
		alias
			"FromHdc"
		end

	frozen draw_image_image_int32_int32_int32_int32 (image: DRAWING_IMAGE; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Drawing.Image, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen enumerate_metafile_metafile_rectangle_f_enumerate_metafile_proc_int_ptr (metafile: DRAWING_METAFILE; dest_rect: DRAWING_RECTANGLE_F; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.RectangleF, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_arc_pen_int32 (pen: DRAWING_PEN; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; start_angle: INTEGER; sweep_angle: INTEGER) is
		external
			"IL signature (System.Drawing.Pen, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawArc"
		end

	frozen multiply_transform_matrix_matrix_order (matrix: DRAWING_MATRIX; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Graphics"
		alias
			"MultiplyTransform"
		end

	frozen draw_pie_pen_rectangle_f (pen: DRAWING_PEN; rect: DRAWING_RECTANGLE_F; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.RectangleF, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawPie"
		end

	frozen enumerate_metafile_metafile_rectangle_rectangle_graphics_unit_enumerate_metafile_proc (metafile: DRAWING_METAFILE; dest_rect: DRAWING_RECTANGLE; src_rect: DRAWING_RECTANGLE; src_unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Rectangle, System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen enumerate_metafile_metafile_point_enumerate_metafile_proc_int_ptr_image_attributes (metafile: DRAWING_METAFILE; dest_point: DRAWING_POINT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_image_image_rectangle_f_rectangle_f_graphics_unit (image: DRAWING_IMAGE; dest_rect: DRAWING_RECTANGLE_F; src_rect: DRAWING_RECTANGLE_F; src_unit: DRAWING_GRAPHICS_UNIT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.RectangleF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen enumerate_metafile_metafile_array_point_rectangle_graphics_unit_enumerate_metafile_proc (metafile: DRAWING_METAFILE; dest_points: NATIVE_ARRAY [DRAWING_POINT]; src_rect: DRAWING_RECTANGLE; src_unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point[], System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen set_clip_region_combine_mode (region: DRAWING_REGION; combine_mode: DRAWING_COMBINE_MODE) is
		external
			"IL signature (System.Drawing.Region, System.Drawing.Drawing2D.CombineMode): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen enumerate_metafile_metafile_point_f_enumerate_metafile_proc_int_ptr (metafile: DRAWING_METAFILE; dest_point: DRAWING_POINT_F; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen fill_region (brush: DRAWING_BRUSH; region: DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Region): System.Void use System.Drawing.Graphics"
		alias
			"FillRegion"
		end

	frozen begin_container_rectangle_f (dstrect: DRAWING_RECTANGLE_F; srcrect: DRAWING_RECTANGLE_F; unit: DRAWING_GRAPHICS_UNIT): DRAWING_GRAPHICS_CONTAINER is
		external
			"IL signature (System.Drawing.RectangleF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit): System.Drawing.Drawing2D.GraphicsContainer use System.Drawing.Graphics"
		alias
			"BeginContainer"
		end

	frozen enumerate_metafile_metafile_array_point_enumerate_metafile_proc_int_ptr_image_attributes (metafile: DRAWING_METAFILE; dest_points: NATIVE_ARRAY [DRAWING_POINT]; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point[], System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen scale_transform_single_single_matrix_order (sx: REAL; sy: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Graphics"
		alias
			"ScaleTransform"
		end

	frozen draw_closed_curve_pen_array_point_single_fill_mode (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT]; tension: REAL; fillmode: DRAWING_FILL_MODE) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[], System.Single, System.Drawing.Drawing2D.FillMode): System.Void use System.Drawing.Graphics"
		alias
			"DrawClosedCurve"
		end

	frozen enumerate_metafile_metafile_rectangle_f_enumerate_metafile_proc (metafile: DRAWING_METAFILE; dest_rect: DRAWING_RECTANGLE_F; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.RectangleF, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen is_visible_single_single (x: REAL; y: REAL): BOOLEAN is
		external
			"IL signature (System.Single, System.Single): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen draw_image_image_point_f (image: DRAWING_IMAGE; point: DRAWING_POINT_F) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.PointF): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen measure_string_string_font_size_f (text: SYSTEM_STRING; font: DRAWING_FONT; layout_area: DRAWING_SIZE_F): DRAWING_SIZE_F is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.SizeF): System.Drawing.SizeF use System.Drawing.Graphics"
		alias
			"MeasureString"
		end

	frozen fill_closed_curve_brush_array_point_f (brush: DRAWING_BRUSH; points: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"FillClosedCurve"
		end

	frozen draw_closed_curve (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawClosedCurve"
		end

	frozen draw_string_string_font_brush_rectangle_f_string_format (s: SYSTEM_STRING; font: DRAWING_FONT; brush: DRAWING_BRUSH; layout_rectangle: DRAWING_RECTANGLE_F; format: DRAWING_STRING_FORMAT) is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.Brush, System.Drawing.RectangleF, System.Drawing.StringFormat): System.Void use System.Drawing.Graphics"
		alias
			"DrawString"
		end

	frozen draw_ellipse_pen_single (pen: DRAWING_PEN; x: REAL; y: REAL; width: REAL; height: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawEllipse"
		end

	frozen add_metafile_comment (data: NATIVE_ARRAY [INTEGER_8]) is
		external
			"IL signature (System.Byte[]): System.Void use System.Drawing.Graphics"
		alias
			"AddMetafileComment"
		end

	frozen fill_ellipse_brush_single (brush: DRAWING_BRUSH; x: REAL; y: REAL; width: REAL; height: REAL) is
		external
			"IL signature (System.Drawing.Brush, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"FillEllipse"
		end

	frozen from_hdc_internal (hdc: POINTER): DRAWING_GRAPHICS is
		external
			"IL static signature (System.IntPtr): System.Drawing.Graphics use System.Drawing.Graphics"
		alias
			"FromHdcInternal"
		end

	frozen from_hwnd_internal (hwnd: POINTER): DRAWING_GRAPHICS is
		external
			"IL static signature (System.IntPtr): System.Drawing.Graphics use System.Drawing.Graphics"
		alias
			"FromHwndInternal"
		end

	frozen enumerate_metafile_metafile_rectangle_f_rectangle_f_graphics_unit_enumerate_metafile_proc_int_ptr_image_attributes (metafile: DRAWING_METAFILE; dest_rect: DRAWING_RECTANGLE_F; src_rect: DRAWING_RECTANGLE_F; unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.RectangleF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_pie_pen_single (pen: DRAWING_PEN; x: REAL; y: REAL; width: REAL; height: REAL; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Single, System.Single, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawPie"
		end

	frozen is_visible_rectangle (rect: DRAWING_RECTANGLE): BOOLEAN is
		external
			"IL signature (System.Drawing.Rectangle): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen draw_icon_icon_int32 (icon: DRAWING_ICON; x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Drawing.Icon, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawIcon"
		end

	frozen draw_image_image_array_point_f (image: DRAWING_IMAGE; dest_points: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_line_pen_single (pen: DRAWING_PEN; x1: REAL; y1: REAL; x2: REAL; y2: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawLine"
		end

	frozen draw_image_image_array_point_f_rectangle_f_graphics_unit_image_attributes (image: DRAWING_IMAGE; dest_points: NATIVE_ARRAY [DRAWING_POINT_F]; src_rect: DRAWING_RECTANGLE_F; src_unit: DRAWING_GRAPHICS_UNIT; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_curve_pen_array_point_f (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawCurve"
		end

	frozen draw_curve_pen_array_point_single (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT]; tension: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[], System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawCurve"
		end

	frozen exclude_clip_rectangle (rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"ExcludeClip"
		end

	frozen draw_ellipse (pen: DRAWING_PEN; rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"DrawEllipse"
		end

	frozen draw_image_image_array_point (image: DRAWING_IMAGE; dest_points: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen enumerate_metafile_metafile_array_point_f_rectangle_f_graphics_unit_enumerate_metafile_proc (metafile: DRAWING_METAFILE; dest_points: NATIVE_ARRAY [DRAWING_POINT_F]; src_rect: DRAWING_RECTANGLE_F; src_unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_beziers_pen_array_point_f (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawBeziers"
		end

	frozen draw_pie_pen_int32 (pen: DRAWING_PEN; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER; start_angle: INTEGER; sweep_angle: INTEGER) is
		external
			"IL signature (System.Drawing.Pen, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawPie"
		end

	frozen enumerate_metafile_metafile_array_point_f_rectangle_f_graphics_unit_enumerate_metafile_proc_int_ptr_image_attributes (metafile: DRAWING_METAFILE; dest_points: NATIVE_ARRAY [DRAWING_POINT_F]; src_rect: DRAWING_RECTANGLE_F; unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF[], System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_image_image_rectangle_single_single_single_single_graphics_unit_image_attributes_draw_image_abort (image: DRAWING_IMAGE; dest_rect: DRAWING_RECTANGLE; src_x: REAL; src_y: REAL; src_width: REAL; src_height: REAL; src_unit: DRAWING_GRAPHICS_UNIT; image_attrs: DRAWING_IMAGE_ATTRIBUTES; callback: DRAWING_DRAW_IMAGE_ABORT_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Single, System.Single, System.Single, System.Single, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_image_image_rectangle_single_single_single_single_graphics_unit_image_attributes_draw_image_abort_int_ptr (image: DRAWING_IMAGE; dest_rect: DRAWING_RECTANGLE; src_x: REAL; src_y: REAL; src_width: REAL; src_height: REAL; src_unit: DRAWING_GRAPHICS_UNIT; image_attrs: DRAWING_IMAGE_ATTRIBUTES; callback: DRAWING_DRAW_IMAGE_ABORT_IN_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Single, System.Single, System.Single, System.Single, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen enumerate_metafile_metafile_point_rectangle_graphics_unit_enumerate_metafile_proc (metafile: DRAWING_METAFILE; dest_point: DRAWING_POINT; src_rect: DRAWING_RECTANGLE; src_unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point, System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen translate_transform_single_single_matrix_order (dx: REAL; dy: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Graphics"
		alias
			"TranslateTransform"
		end

	frozen intersect_clip (region: DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Drawing.Graphics"
		alias
			"IntersectClip"
		end

	frozen fill_rectangle (brush: DRAWING_BRUSH; rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"FillRectangle"
		end

	frozen exclude_clip (region: DRAWING_REGION) is
		external
			"IL signature (System.Drawing.Region): System.Void use System.Drawing.Graphics"
		alias
			"ExcludeClip"
		end

	frozen enumerate_metafile_metafile_point_f_enumerate_metafile_proc_int_ptr_image_attributes (metafile: DRAWING_METAFILE; dest_point: DRAWING_POINT_F; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen fill_ellipse_brush_rectangle_f (brush: DRAWING_BRUSH; rect: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.RectangleF): System.Void use System.Drawing.Graphics"
		alias
			"FillEllipse"
		end

	frozen draw_ellipse_pen_rectangle_f (pen: DRAWING_PEN; rect: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.RectangleF): System.Void use System.Drawing.Graphics"
		alias
			"DrawEllipse"
		end

	frozen draw_image_unscaled (image: DRAWING_IMAGE; rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"DrawImageUnscaled"
		end

	frozen begin_container_rectangle (dstrect: DRAWING_RECTANGLE; srcrect: DRAWING_RECTANGLE; unit: DRAWING_GRAPHICS_UNIT): DRAWING_GRAPHICS_CONTAINER is
		external
			"IL signature (System.Drawing.Rectangle, System.Drawing.Rectangle, System.Drawing.GraphicsUnit): System.Drawing.Drawing2D.GraphicsContainer use System.Drawing.Graphics"
		alias
			"BeginContainer"
		end

	frozen is_visible_int32_int32_int32 (x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32, System.Int32, System.Int32): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen draw_arc_pen_single (pen: DRAWING_PEN; x: REAL; y: REAL; width: REAL; height: REAL; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Single, System.Single, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawArc"
		end

	frozen draw_image_image_int32_int32_rectangle (image: DRAWING_IMAGE; x: INTEGER; y: INTEGER; src_rect: DRAWING_RECTANGLE; src_unit: DRAWING_GRAPHICS_UNIT) is
		external
			"IL signature (System.Drawing.Image, System.Int32, System.Int32, System.Drawing.Rectangle, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_string_string_font_brush_single_single (s: SYSTEM_STRING; font: DRAWING_FONT; brush: DRAWING_BRUSH; x: REAL; y: REAL) is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.Brush, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawString"
		end

	frozen draw_image_image_int32_int32 (image: DRAWING_IMAGE; x: INTEGER; y: INTEGER) is
		external
			"IL signature (System.Drawing.Image, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen dispose is
		external
			"IL signature (): System.Void use System.Drawing.Graphics"
		alias
			"Dispose"
		end

	frozen fill_closed_curve_brush_array_point_fill_mode_single (brush: DRAWING_BRUSH; points: NATIVE_ARRAY [DRAWING_POINT]; fillmode: DRAWING_FILL_MODE; tension: REAL) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Point[], System.Drawing.Drawing2D.FillMode, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"FillClosedCurve"
		end

	frozen release_hdc_internal (hdc: POINTER) is
		external
			"IL signature (System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"ReleaseHdcInternal"
		end

	frozen enumerate_metafile_metafile_rectangle_enumerate_metafile_proc_int_ptr (metafile: DRAWING_METAFILE; dest_rect: DRAWING_RECTANGLE; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Rectangle, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen enumerate_metafile_metafile_point_f_rectangle_f_graphics_unit_enumerate_metafile_proc (metafile: DRAWING_METAFILE; dest_point: DRAWING_POINT_F; src_rect: DRAWING_RECTANGLE_F; src_unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen get_halftone_palette: POINTER is
		external
			"IL static signature (): System.IntPtr use System.Drawing.Graphics"
		alias
			"GetHalftonePalette"
		end

	frozen draw_curve_pen_array_point_f_int32_int32_single (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT_F]; offset: INTEGER; number_of_segments: INTEGER; tension: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[], System.Int32, System.Int32, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawCurve"
		end

	frozen fill_ellipse (brush: DRAWING_BRUSH; rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"FillEllipse"
		end

	frozen from_image (image: DRAWING_IMAGE): DRAWING_GRAPHICS is
		external
			"IL static signature (System.Drawing.Image): System.Drawing.Graphics use System.Drawing.Graphics"
		alias
			"FromImage"
		end

	frozen draw_image_image_rectangle_int32_int32_int32_int32_graphics_unit_image_attributes (image: DRAWING_IMAGE; dest_rect: DRAWING_RECTANGLE; src_x: INTEGER; src_y: INTEGER; src_width: INTEGER; src_height: INTEGER; src_unit: DRAWING_GRAPHICS_UNIT; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Int32, System.Int32, System.Int32, System.Int32, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_arc (pen: DRAWING_PEN; rect: DRAWING_RECTANGLE; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Rectangle, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawArc"
		end

	frozen draw_line (pen: DRAWING_PEN; pt1: DRAWING_POINT; pt2: DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point, System.Drawing.Point): System.Void use System.Drawing.Graphics"
		alias
			"DrawLine"
		end

	frozen draw_image_image_rectangle_int32_int32_int32_int32_graphics_unit_image_attributes_draw_image_abort (image: DRAWING_IMAGE; dest_rect: DRAWING_RECTANGLE; src_x: INTEGER; src_y: INTEGER; src_width: INTEGER; src_height: INTEGER; src_unit: DRAWING_GRAPHICS_UNIT; image_attr: DRAWING_IMAGE_ATTRIBUTES; callback: DRAWING_DRAW_IMAGE_ABORT_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Int32, System.Int32, System.Int32, System.Int32, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_rectangle (pen: DRAWING_PEN; rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"DrawRectangle"
		end

	frozen draw_image_image_single_single (image: DRAWING_IMAGE; x: REAL; y: REAL) is
		external
			"IL signature (System.Drawing.Image, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen enumerate_metafile_metafile_array_point_rectangle_graphics_unit_enumerate_metafile_proc_int_ptr (metafile: DRAWING_METAFILE; dest_points: NATIVE_ARRAY [DRAWING_POINT]; src_rect: DRAWING_RECTANGLE; src_unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point[], System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen measure_string_string_font_int32 (text: SYSTEM_STRING; font: DRAWING_FONT; width: INTEGER): DRAWING_SIZE_F is
		external
			"IL signature (System.String, System.Drawing.Font, System.Int32): System.Drawing.SizeF use System.Drawing.Graphics"
		alias
			"MeasureString"
		end

	frozen draw_image_image_array_point_rectangle_graphics_unit_image_attributes_draw_image_abort (image: DRAWING_IMAGE; dest_points: NATIVE_ARRAY [DRAWING_POINT]; src_rect: DRAWING_RECTANGLE; src_unit: DRAWING_GRAPHICS_UNIT; image_attr: DRAWING_IMAGE_ATTRIBUTES; callback: DRAWING_DRAW_IMAGE_ABORT_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Point[], System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen enumerate_metafile_metafile_point_f_rectangle_f_graphics_unit_enumerate_metafile_proc_int_ptr_image_attributes (metafile: DRAWING_METAFILE; dest_point: DRAWING_POINT_F; src_rect: DRAWING_RECTANGLE_F; unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_curve_pen_array_point_f_single (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT_F]; tension: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[], System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawCurve"
		end

	frozen fill_polygon_brush_array_point_f_fill_mode (brush: DRAWING_BRUSH; points: NATIVE_ARRAY [DRAWING_POINT_F]; fill_mode: DRAWING_FILL_MODE) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.PointF[], System.Drawing.Drawing2D.FillMode): System.Void use System.Drawing.Graphics"
		alias
			"FillPolygon"
		end

	frozen draw_image_image_single_single_single_single (image: DRAWING_IMAGE; x: REAL; y: REAL; width: REAL; height: REAL) is
		external
			"IL signature (System.Drawing.Image, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_rectangles (pen: DRAWING_PEN; rects: NATIVE_ARRAY [DRAWING_RECTANGLE]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Rectangle[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawRectangles"
		end

	frozen is_visible_int32_int32 (x: INTEGER; y: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32, System.Int32): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen draw_curve (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawCurve"
		end

	frozen fill_closed_curve_brush_array_point_f_fill_mode (brush: DRAWING_BRUSH; points: NATIVE_ARRAY [DRAWING_POINT_F]; fillmode: DRAWING_FILL_MODE) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.PointF[], System.Drawing.Drawing2D.FillMode): System.Void use System.Drawing.Graphics"
		alias
			"FillClosedCurve"
		end

	frozen enumerate_metafile_metafile_rectangle_f_enumerate_metafile_proc_int_ptr_image_attributes (metafile: DRAWING_METAFILE; dest_rect: DRAWING_RECTANGLE_F; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.RectangleF, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen enumerate_metafile_metafile_point_rectangle_graphics_unit_enumerate_metafile_proc_int_ptr_image_attributes (metafile: DRAWING_METAFILE; dest_point: DRAWING_POINT; src_rect: DRAWING_RECTANGLE; unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Point, System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen from_hdc (hdc: POINTER): DRAWING_GRAPHICS is
		external
			"IL static signature (System.IntPtr): System.Drawing.Graphics use System.Drawing.Graphics"
		alias
			"FromHdc"
		end

	frozen measure_character_ranges (text: SYSTEM_STRING; font: DRAWING_FONT; layout_rect: DRAWING_RECTANGLE_F; string_format: DRAWING_STRING_FORMAT): NATIVE_ARRAY [DRAWING_REGION] is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.RectangleF, System.Drawing.StringFormat): System.Drawing.Region[] use System.Drawing.Graphics"
		alias
			"MeasureCharacterRanges"
		end

	frozen draw_line_pen_point_f (pen: DRAWING_PEN; pt1: DRAWING_POINT_F; pt2: DRAWING_POINT_F) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF, System.Drawing.PointF): System.Void use System.Drawing.Graphics"
		alias
			"DrawLine"
		end

	frozen draw_string_string_font_brush_single_single_string_format (s: SYSTEM_STRING; font: DRAWING_FONT; brush: DRAWING_BRUSH; x: REAL; y: REAL; format: DRAWING_STRING_FORMAT) is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.Brush, System.Single, System.Single, System.Drawing.StringFormat): System.Void use System.Drawing.Graphics"
		alias
			"DrawString"
		end

	frozen enumerate_metafile_metafile_point_f_rectangle_f_graphics_unit_enumerate_metafile_proc_int_ptr (metafile: DRAWING_METAFILE; dest_point: DRAWING_POINT_F; src_rect: DRAWING_RECTANGLE_F; src_unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_image_image_array_point_rectangle_graphics_unit_image_attributes_draw_image_abort_int32 (image: DRAWING_IMAGE; dest_points: NATIVE_ARRAY [DRAWING_POINT]; src_rect: DRAWING_RECTANGLE; src_unit: DRAWING_GRAPHICS_UNIT; image_attr: DRAWING_IMAGE_ATTRIBUTES; callback: DRAWING_DRAW_IMAGE_ABORT_IN_DRAWING_GRAPHICS; callback_data: INTEGER) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Point[], System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen multiply_transform (matrix: DRAWING_MATRIX) is
		external
			"IL signature (System.Drawing.Drawing2D.Matrix): System.Void use System.Drawing.Graphics"
		alias
			"MultiplyTransform"
		end

	frozen translate_clip_single (dx: REAL; dy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"TranslateClip"
		end

	frozen draw_image_image_rectangle (image: DRAWING_IMAGE; rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen fill_path (brush: DRAWING_BRUSH; path: DRAWING_GRAPHICS_PATH) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Drawing2D.GraphicsPath): System.Void use System.Drawing.Graphics"
		alias
			"FillPath"
		end

	frozen fill_pie (brush: DRAWING_BRUSH; rect: DRAWING_RECTANGLE; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Rectangle, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"FillPie"
		end

	frozen draw_icon (icon: DRAWING_ICON; target_rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Icon, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"DrawIcon"
		end

	frozen fill_closed_curve_brush_array_point_fill_mode (brush: DRAWING_BRUSH; points: NATIVE_ARRAY [DRAWING_POINT]; fillmode: DRAWING_FILL_MODE) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Point[], System.Drawing.Drawing2D.FillMode): System.Void use System.Drawing.Graphics"
		alias
			"FillClosedCurve"
		end

	frozen draw_string (s: SYSTEM_STRING; font: DRAWING_FONT; brush: DRAWING_BRUSH; point: DRAWING_POINT_F) is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.Brush, System.Drawing.PointF): System.Void use System.Drawing.Graphics"
		alias
			"DrawString"
		end

	frozen draw_curve_pen_array_point_f_int32_int32 (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT_F]; offset: INTEGER; number_of_segments: INTEGER) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[], System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawCurve"
		end

	frozen draw_icon_unstretched (icon: DRAWING_ICON; target_rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Icon, System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"DrawIconUnstretched"
		end

	frozen draw_string_string_font_brush_point_f_string_format (s: SYSTEM_STRING; font: DRAWING_FONT; brush: DRAWING_BRUSH; point: DRAWING_POINT_F; format: DRAWING_STRING_FORMAT) is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.Brush, System.Drawing.PointF, System.Drawing.StringFormat): System.Void use System.Drawing.Graphics"
		alias
			"DrawString"
		end

	frozen enumerate_metafile_metafile_rectangle_f_rectangle_f_graphics_unit_enumerate_metafile_proc_int_ptr (metafile: DRAWING_METAFILE; dest_rect: DRAWING_RECTANGLE_F; src_rect: DRAWING_RECTANGLE_F; src_unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.RectangleF, System.Drawing.RectangleF, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen set_clip_graphics_path_combine_mode (path: DRAWING_GRAPHICS_PATH; combine_mode: DRAWING_COMBINE_MODE) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath, System.Drawing.Drawing2D.CombineMode): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen set_clip_rectangle_f_combine_mode (rect: DRAWING_RECTANGLE_F; combine_mode: DRAWING_COMBINE_MODE) is
		external
			"IL signature (System.Drawing.RectangleF, System.Drawing.Drawing2D.CombineMode): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen is_visible (point: DRAWING_POINT_F): BOOLEAN is
		external
			"IL signature (System.Drawing.PointF): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen draw_curve_pen_array_point_int32_int32_single (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT]; offset: INTEGER; number_of_segments: INTEGER; tension: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[], System.Int32, System.Int32, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawCurve"
		end

	frozen rotate_transform_single_matrix_order (angle: REAL; order: DRAWING_MATRIX_ORDER) is
		external
			"IL signature (System.Single, System.Drawing.Drawing2D.MatrixOrder): System.Void use System.Drawing.Graphics"
		alias
			"RotateTransform"
		end

	frozen get_nearest_color (color: DRAWING_COLOR): DRAWING_COLOR is
		external
			"IL signature (System.Drawing.Color): System.Drawing.Color use System.Drawing.Graphics"
		alias
			"GetNearestColor"
		end

	frozen draw_bezier_pen_single (pen: DRAWING_PEN; x1: REAL; y1: REAL; x2: REAL; y2: REAL; x3: REAL; y3: REAL; x4: REAL; y4: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Single, System.Single, System.Single, System.Single, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawBezier"
		end

	frozen is_visible_single_single_single (x: REAL; y: REAL; width: REAL; height: REAL): BOOLEAN is
		external
			"IL signature (System.Single, System.Single, System.Single, System.Single): System.Boolean use System.Drawing.Graphics"
		alias
			"IsVisible"
		end

	frozen set_clip_graphics_path (path: DRAWING_GRAPHICS_PATH) is
		external
			"IL signature (System.Drawing.Drawing2D.GraphicsPath): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen draw_rectangle_pen_int32 (pen: DRAWING_PEN; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Drawing.Pen, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawRectangle"
		end

	frozen enumerate_metafile_metafile_array_point_f_enumerate_metafile_proc_int_ptr_image_attributes (metafile: DRAWING_METAFILE; dest_points: NATIVE_ARRAY [DRAWING_POINT_F]; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF[], System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen fill_closed_curve_brush_array_point_f_fill_mode_single (brush: DRAWING_BRUSH; points: NATIVE_ARRAY [DRAWING_POINT_F]; fillmode: DRAWING_FILL_MODE; tension: REAL) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.PointF[], System.Drawing.Drawing2D.FillMode, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"FillClosedCurve"
		end

	frozen draw_string_string_font_brush_rectangle_f (s: SYSTEM_STRING; font: DRAWING_FONT; brush: DRAWING_BRUSH; layout_rectangle: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.String, System.Drawing.Font, System.Drawing.Brush, System.Drawing.RectangleF): System.Void use System.Drawing.Graphics"
		alias
			"DrawString"
		end

	frozen draw_ellipse_pen_int32 (pen: DRAWING_PEN; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Drawing.Pen, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"DrawEllipse"
		end

	frozen begin_container: DRAWING_GRAPHICS_CONTAINER is
		external
			"IL signature (): System.Drawing.Drawing2D.GraphicsContainer use System.Drawing.Graphics"
		alias
			"BeginContainer"
		end

	frozen fill_polygon_brush_array_point_f (brush: DRAWING_BRUSH; points: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"FillPolygon"
		end

	frozen fill_rectangle_brush_single (brush: DRAWING_BRUSH; x: REAL; y: REAL; width: REAL; height: REAL) is
		external
			"IL signature (System.Drawing.Brush, System.Single, System.Single, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"FillRectangle"
		end

	frozen set_clip_rectangle (rect: DRAWING_RECTANGLE) is
		external
			"IL signature (System.Drawing.Rectangle): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen fill_closed_curve (brush: DRAWING_BRUSH; points: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"FillClosedCurve"
		end

	frozen flush is
		external
			"IL signature (): System.Void use System.Drawing.Graphics"
		alias
			"Flush"
		end

	frozen draw_image_unscaled_image_point (image: DRAWING_IMAGE; point: DRAWING_POINT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Point): System.Void use System.Drawing.Graphics"
		alias
			"DrawImageUnscaled"
		end

	frozen enumerate_metafile_metafile_rectangle_rectangle_graphics_unit_enumerate_metafile_proc_int_ptr_image_attributes (metafile: DRAWING_METAFILE; dest_rect: DRAWING_RECTANGLE; src_rect: DRAWING_RECTANGLE; unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Rectangle, System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen from_hwnd (hwnd: POINTER): DRAWING_GRAPHICS is
		external
			"IL static signature (System.IntPtr): System.Drawing.Graphics use System.Drawing.Graphics"
		alias
			"FromHwnd"
		end

	frozen transform_points_coordinate_space_coordinate_space_array_point_f (dest_space: DRAWING_COORDINATE_SPACE; src_space: DRAWING_COORDINATE_SPACE; pts: NATIVE_ARRAY [DRAWING_POINT_F]) is
		external
			"IL signature (System.Drawing.Drawing2D.CoordinateSpace, System.Drawing.Drawing2D.CoordinateSpace, System.Drawing.PointF[]): System.Void use System.Drawing.Graphics"
		alias
			"TransformPoints"
		end

	frozen draw_image_image_rectangle_int32_int32_int32_int32_graphics_unit_image_attributes_draw_image_abort_int_ptr (image: DRAWING_IMAGE; dest_rect: DRAWING_RECTANGLE; src_x: INTEGER; src_y: INTEGER; src_width: INTEGER; src_height: INTEGER; src_unit: DRAWING_GRAPHICS_UNIT; image_attrs: DRAWING_IMAGE_ATTRIBUTES; callback: DRAWING_DRAW_IMAGE_ABORT_IN_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Int32, System.Int32, System.Int32, System.Int32, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes, System.Drawing.Graphics+DrawImageAbort, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_image_image_array_point_rectangle_graphics_unit_image_attributes (image: DRAWING_IMAGE; dest_points: NATIVE_ARRAY [DRAWING_POINT]; src_rect: DRAWING_RECTANGLE; src_unit: DRAWING_GRAPHICS_UNIT; image_attr: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Point[], System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen fill_polygon (brush: DRAWING_BRUSH; points: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"FillPolygon"
		end

	frozen enumerate_metafile_metafile_rectangle_rectangle_graphics_unit_enumerate_metafile_proc_int_ptr (metafile: DRAWING_METAFILE; dest_rect: DRAWING_RECTANGLE; src_rect: DRAWING_RECTANGLE; src_unit: DRAWING_GRAPHICS_UNIT; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS; callback_data: POINTER) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Rectangle, System.Drawing.Rectangle, System.Drawing.GraphicsUnit, System.Drawing.Graphics+EnumerateMetafileProc, System.IntPtr): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen fill_rectangles_brush_array_rectangle_f (brush: DRAWING_BRUSH; rects: NATIVE_ARRAY [DRAWING_RECTANGLE_F]) is
		external
			"IL signature (System.Drawing.Brush, System.Drawing.RectangleF[]): System.Void use System.Drawing.Graphics"
		alias
			"FillRectangles"
		end

	frozen draw_image_image_rectangle_int32_int32_int32_int32_graphics_unit (image: DRAWING_IMAGE; dest_rect: DRAWING_RECTANGLE; src_x: INTEGER; src_y: INTEGER; src_width: INTEGER; src_height: INTEGER; src_unit: DRAWING_GRAPHICS_UNIT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Int32, System.Int32, System.Int32, System.Int32, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_image_image_rectangle_rectangle_graphics_unit (image: DRAWING_IMAGE; dest_rect: DRAWING_RECTANGLE; src_rect: DRAWING_RECTANGLE; src_unit: DRAWING_GRAPHICS_UNIT) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Drawing.Rectangle, System.Drawing.GraphicsUnit): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen intersect_clip_rectangle_f (rect: DRAWING_RECTANGLE_F) is
		external
			"IL signature (System.Drawing.RectangleF): System.Void use System.Drawing.Graphics"
		alias
			"IntersectClip"
		end

	frozen reset_transform is
		external
			"IL signature (): System.Void use System.Drawing.Graphics"
		alias
			"ResetTransform"
		end

	frozen flush_flush_intention (intention: DRAWING_FLUSH_INTENTION) is
		external
			"IL signature (System.Drawing.Drawing2D.FlushIntention): System.Void use System.Drawing.Graphics"
		alias
			"Flush"
		end

	frozen set_clip_rectangle_combine_mode (rect: DRAWING_RECTANGLE; combine_mode: DRAWING_COMBINE_MODE) is
		external
			"IL signature (System.Drawing.Rectangle, System.Drawing.Drawing2D.CombineMode): System.Void use System.Drawing.Graphics"
		alias
			"SetClip"
		end

	frozen draw_rectangles_pen_array_rectangle_f (pen: DRAWING_PEN; rects: NATIVE_ARRAY [DRAWING_RECTANGLE_F]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.RectangleF[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawRectangles"
		end

	frozen save: DRAWING_GRAPHICS_STATE is
		external
			"IL signature (): System.Drawing.Drawing2D.GraphicsState use System.Drawing.Graphics"
		alias
			"Save"
		end

	frozen draw_arc_pen_rectangle_f (pen: DRAWING_PEN; rect: DRAWING_RECTANGLE_F; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.RectangleF, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawArc"
		end

	frozen draw_image_image_rectangle_single_single_single_single_graphics_unit_image_attributes (image: DRAWING_IMAGE; dest_rect: DRAWING_RECTANGLE; src_x: REAL; src_y: REAL; src_width: REAL; src_height: REAL; src_unit: DRAWING_GRAPHICS_UNIT; image_attrs: DRAWING_IMAGE_ATTRIBUTES) is
		external
			"IL signature (System.Drawing.Image, System.Drawing.Rectangle, System.Single, System.Single, System.Single, System.Single, System.Drawing.GraphicsUnit, System.Drawing.Imaging.ImageAttributes): System.Void use System.Drawing.Graphics"
		alias
			"DrawImage"
		end

	frozen draw_polygon (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawPolygon"
		end

	frozen transform_points (dest_space: DRAWING_COORDINATE_SPACE; src_space: DRAWING_COORDINATE_SPACE; pts: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Drawing2D.CoordinateSpace, System.Drawing.Drawing2D.CoordinateSpace, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"TransformPoints"
		end

	frozen fill_rectangle_brush_int32 (brush: DRAWING_BRUSH; x: INTEGER; y: INTEGER; width: INTEGER; height: INTEGER) is
		external
			"IL signature (System.Drawing.Brush, System.Int32, System.Int32, System.Int32, System.Int32): System.Void use System.Drawing.Graphics"
		alias
			"FillRectangle"
		end

	frozen draw_beziers (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT]) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Point[]): System.Void use System.Drawing.Graphics"
		alias
			"DrawBeziers"
		end

	frozen enumerate_metafile_metafile_rectangle_enumerate_metafile_proc (metafile: DRAWING_METAFILE; dest_rect: DRAWING_RECTANGLE; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.Rectangle, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen enumerate_metafile_metafile_point_f_enumerate_metafile_proc (metafile: DRAWING_METAFILE; dest_point: DRAWING_POINT_F; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF, System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_pie (pen: DRAWING_PEN; rect: DRAWING_RECTANGLE; start_angle: REAL; sweep_angle: REAL) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.Rectangle, System.Single, System.Single): System.Void use System.Drawing.Graphics"
		alias
			"DrawPie"
		end

	frozen enumerate_metafile_metafile_array_point_f_enumerate_metafile_proc (metafile: DRAWING_METAFILE; dest_points: NATIVE_ARRAY [DRAWING_POINT_F]; callback: DRAWING_ENUMERATE_METAFILE_PROC_IN_DRAWING_GRAPHICS) is
		external
			"IL signature (System.Drawing.Imaging.Metafile, System.Drawing.PointF[], System.Drawing.Graphics+EnumerateMetafileProc): System.Void use System.Drawing.Graphics"
		alias
			"EnumerateMetafile"
		end

	frozen draw_closed_curve_pen_array_point_f_single_fill_mode (pen: DRAWING_PEN; points: NATIVE_ARRAY [DRAWING_POINT_F]; tension: REAL; fillmode: DRAWING_FILL_MODE) is
		external
			"IL signature (System.Drawing.Pen, System.Drawing.PointF[], System.Single, System.Drawing.Drawing2D.FillMode): System.Void use System.Drawing.Graphics"
		alias
			"DrawClosedCurve"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Drawing.Graphics"
		alias
			"Finalize"
		end

end -- class DRAWING_GRAPHICS
